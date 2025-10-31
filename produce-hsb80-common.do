/* HS&B:80 Common Variables
   Michael J. Culbertson
   October 30, 2025
   
   Data sources:
     hsb8086.dta: HS&B:80 base year to third follow-up data (panel sample)
     hsb80-ps-trans-sr.dta: HS&B:80 senior post-secondary transcripts
     hsb80-ps-trans-so.dta: HS&B:80 sophomore post-secondary transcripts
   
   Set the global macros in the paths.do file for your system.
   Run this from the repository directory to access metadata.
   
   This dataset compiles standard operationalizations for our most commonly
   used variables, including the recommended standard minimum set of variables
   for multiple imputation. Unlike most EdSHARe internal datasets,
   this data file uses system missing values, rather than reserve codes.
   
   Universe for the file is all HS&B:80 panel members.   
*/


* Location of this file
global dodir "."

* Load the path macros
do "$dodir/paths.do"

* Location of the HS&B:80 public data files
global dtadir "$outdir"


frames reset
clear all
set maxvar 6000

* Data version
global dtaversion "2025-10-30"


*************************
*** Load data
*************************

* Variables list
frame create vars
frame vars: import delimited "$repodir/variables-hsb80.csv", varnames(1)

* HS&B:80/86 panel data
frame create out
frame out: use "$dtadir/hsb8086.dta"

* HS&B:80 Senior transcripts
frame create srtran
frame srtran: use "$dtadir/hsb80-ps-trans-sr.dta"

* HS&B:80 Sophomore transcripts
frame create sotran
frame sotran: use "$dtadir/hsb80-ps-trans-so.dta"



*************************
*** Collate variables
*************************

frame change vars

* Iterate over variables
forv i = 1/`=_N' {
    
    * If this variable is from the historical panel
    if source[`i'] == "hsb8086" {
        
        * Load the metadata for this variable
        local so = srcvar[`i']         // Sophomore variable name
        local sr = srvar[`i']          // Senior variable name
        local v = variable[`i']        // Destination (output) variable name
        * If no destination variable, keep source name (prefer soph var name)
        if "`v'" == "" local v `so'    // Use sophomore name
        if "`v'" == "" local v `sr'    // Use senior name
        
        display "`v' from `so'/`sr'..."
        
        * Sophomore panel variable
        if "`so'" != "" {
            if "`so'" != "`v'"  frame out: rename `so' `v'
        }
        * Senior panel variable
        if "`sr'" != "" & "`sr'" != "`so'" {
            if "`so'" == "" {
                * No sophomore variable
                if "`sr'" != "`v'"  frame out: rename `sr' `v'
            }
            else {
                * Combine senior with sophomore variables
                frame out: replace `v' = `sr' if !missing(`sr')
            }
        }
        
    }
    
}

frame change out

* Flag sophomores and seniors
label list GRADE
gen so = cohort == 1  // Sophomores
gen sr = cohort == 2  // Seniors



*************************
*** Constructed variables: High school
*************************

** paredu: Parental education (BB039, BB042, FY55/FE20, FY56/FE21)

* Recode
label list BB039
label define edatt  1 "HS or less"  2 "Some college" ///
    3 "Two-year Degree"  4 "Four-year Degree"  5 "Graduate Degree"
recode BB039 BB042 FY55 FY56 (2/3 = 1) (4/7 = 2) (8 = 4) (9/10 = 5) (else = .)

* Get highest parental education from 1980, fill in missing with 1982
egen paredu = rowmax(BB039 BB042)
egen paredu82 = rowmax(FY55 FY56)  // == FE20 FE21 for seniors
replace paredu = paredu82 if missing(paredu)
label values paredu edatt


** income80: Family income in 1980 (BB101)

* Use only the 7-category student-report (BB101)
* The 3-category variable fills in only a small proportion of cases.
* The categories differ between 1980 and 1982, not to mention inflation.

* Use the midpoint of the response option ranges; except that the highest
* category does not have a defined mid-point.
* If we fit the data to a Normal distribution with cut points defined by the
* response option ranges, we obtain mean ~ $20k with sd ~ $11.5k.
* Values for categories 6 and 7, below, are close to the medians of the
* truncated Normal distributions corresponding to these response options.

recode income80 (1 = 3500) (2 = 9500) (3 = 14000) (4 = 18000) (5 = 22500)  ///
                (6 = 30000) (7 = 42000) (else = .)
label define income80  3500 "<$7k"  9500 "$7-12k"  14000 "$12-16k"         ///
             18000 "$16-20k"  22500 "$20-25k"   30000 "$25-38k"  42000 "$38k+"
label values income80 income80


** income82: Family income in 1982 (FY111), sophomores only
* Similar logic as above
recode income82 (1 = 4000) (2 = 11500) (3 = 17500) (4 = 22500) (5 = 27500) ///
                (6 = 35000) (7 = 44000) (8 = 55000) (else = .)
label define income82  4000 "<$8k"  11500 "$8-15k"  17500 "$15-20k"        ///
             22500 "$20-25k"  27500 "$25-30k"  35000 "$30-40k"             ///
             44000 "$40-50k"  55000 "$50k+"
label values income82 income82


** siblings: Number of siblings (BB096*, FY106/FE70)

* In 1980, we have a bunch of different age ranges that we don't care about.
* Moreover, some people report a wild number of siblings across all the items.
* In 1982, there was only a single question with a maximum of 6 siblings.
* Prefer the 1982, fill in missing with 1980 capped at 6.

* Recode
*   Category 1 is "No siblings", so bump everything down by 1
label list BB096A
recode BB096A-BB096E siblings (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (else=.)

* Get 1980 total number of siblings
egen siblings80 = rowtotal(BB096A-BB096E)
* Cap at "6 or more"
replace siblings80 = 6 if !missing(siblings80) & siblings80 > 6

* Fill in 1982 missing with 1980
replace siblings = siblings80 if missing(siblings)
label define siblings  6 "6 or more"
label values siblings siblings


** physdis/learndis: Physical and learning disabilities (BB087, FY103, FE83)

* For sophomores, prefer the 1982 report, but fill in with 1980 if missing.
* For seniors, prefer the 1980 report, but fill in with 1982 if missing.
* Here, "physical" disability excludes visual impairments (item B).

* Recode to binary
label list BB087A  // 1980
recode BB087A-BB087G (1=1) (0=0) (else=.)
label list FY103A  // 1982; == FE83 for seniors (renamed as FY103A)
recode FY103A-FY103G (1=1) (2=0) (else=.)

* Combine 1980/1982 reports
foreach i in A B C D E F G {
    * Prefer 1982 report for sophomores
    replace BB087`i' = FY103`i' if !missing(FY103`i') & so
    * Or fill in missing with 1982 for seniors
    replace BB087`i' = FY103`i' if  missing(BB087`i') & sr
}

* Any (non-visual) physical disability (items C-G)
egen physdisab = rowmax(BB087C-BB087G)

* Specific learning disability (item A)
gen learndisab = BB087A


** bmi80: Body mass index (BB085, BB086)
*    = weight in pounds / (height in inches) * 703
* Height (BB085) is in inches
rename BB085 height80
* Recode weight (BB086) to pounds using range midpoints
label list BB086
gen weight80 = 102.5 + (BB086-2)*5 if BB086 > 1 & BB086 < 27

gen bmi80 = weight80 / height80^2 * 703



*************************
*** Post-secondary education: Seniors
*************************

* The post-secondary education information in the early waves is not really
* comparable across the sophomore and senior cohorts, because of the
* difference in time since graduation from high school. Moreover, the 
* survey questions are not cumulative, but rather about the window since
* the previous wave. So, we include PSE enrollment/degrees reported in each
* wave for the two cohorts separately, and use these as predictors in
* imputation for the educational attainment variables collected later.
* Most likely, these pse variables will not be suitable for direct analysis.

* For each survey wave (and the transcripts), code the information available
* into the following categories:
*   1 = No college, 2 = College attendance,
*   3 = 2-year degree, 4 = 4-year degree, 5 = Graduate degree

** pse82sr: Senior 1982 Have taken PSE classes
label list FE31
recode pse82sr (1 /*Yes*/ = 2 /*Some*/) (2 /*No*/ = 1 /*No college*/) (else=.)


** pse84sr: Senior 1984 Post-secondary education

* Attended PSE
label list SE15
recode SE15 (1=2 /*Some college*/) (2=1) (else=.), generate(pse84sr)

* For each school attended, was a degree obtained in this period?
label list SE18I
foreach i in 18 19 20 {
    
    * If SE15 was missing, but we have info on attendance here,
    * we can fill in the missing value with "Some college"
    replace pse84sr = 2 if missing(pse84sr) &                              ///
        (inrange(SE`i'A, 1,5) | inrange(SE`i'I, 1,9) | inrange(SE`i'J, 1,2))
    
    * Sub-item J indicates that a degree was completed
    * Sub-item I indicates what kind of degree
    
    * Completed 2-year degree (vocational or academic)
    replace pse84sr = 3 if pse84sr < 3 & SE`i'J == 1 & inlist(SE`i'I, 4, 5)
    * If degree type is missing
    *   assume it was an associate's degree if institution was "Jr/Cty Col"
    replace pse84sr = 3 if pse84sr < 3 & SE`i'J == 1 & SE`i'I > 90 & SE`i'A == 2
    
    * Completed 4-year degree
    replace pse84sr = 4 if pse84sr < 4 & SE`i'J == 1 & SE`i'I == 6
    * If degree type is missing,
    *   assume it was a bachelor's degree if institution was "college/uni"
    replace pse84sr = 4 if pse84sr < 4 & SE`i'J == 1 & SE`i'I > 90 & SE`i'A == 3
    
    * Completed grad degree
    replace pse84sr = 5 if pse84sr < 5 & SE`i'J == 1 & inlist(SE`i'I, 7, 8, 9)
    * If degree type is missing,
    *   assume it was a grad degree if institution was "grad/prof"
    replace pse84sr = 5 if pse84sr < 5 & SE`i'J == 1 & SE`i'I > 90 & SE`i'A == 5
    
    * Completion of any other kind of degree counts as only "Some College"
}


** pse86sr: Senior 1986 Post-secondary education

* Attended PSE
label list TE20
recode TE20 (1/2=2 /*Some college*/) (3=1) (else=.), generate(pse86sr)

* For each school attended, was a degree obtained in this period?
foreach i in 21 22 {
    
    * If TE20 was missing, but we have info on attendance here,
    * we can fill in the missing value with "Some college"
    replace pse86sr = 2 if missing(pse86sr) &                              ///
        (inrange(TE`i'A, 1,5) | inrange(TE`i'H, 1,9) | inrange(TE`i'I, 1,2))
    
    * Sub-item I indicates that a degree was completed
    * Sub-item H indicates what kind of degree
    
    * Completed 2-year degree (vocational or academic)
    replace pse86sr = 3 if pse86sr < 3 & TE`i'I == 1 & inlist(TE`i'H, 4, 5)
    * If degree type is missing
    *   assume it was an associate's degree if institution was "Jr/Cty Col"
    replace pse86sr = 3 if pse86sr < 3 & TE`i'I == 1 & TE`i'H > 90 & TE`i'A == 2
    
    * Completed 4-year degree
    replace pse86sr = 4 if pse86sr < 4 & TE`i'I == 1 & TE`i'H == 6
    * If degree type is missing,
    *   assume it was a bachelor's degree if institution was "college/uni"
    replace pse86sr = 4 if pse86sr < 4 & TE`i'I == 1 & TE`i'H > 90 & TE`i'A == 3
    
    * Completed grad degree
    replace pse86sr = 5 if pse86sr < 5 & TE`i'I == 1 & inlist(TE`i'H, 7, 8, 9)
    * If degree type is missing,
    *   assume it was a grad degree if institution was "grad/prof"
    replace pse86sr = 5 if pse86sr < 5 & TE`i'I == 1 & TE`i'H > 90 & TE`i'A == 5
    
    * Completion of any other kind of degree counts as only "Some College"
}


** psetransr: Senior Post-secondary transcript degree

* Code degrees
frame srtran: label list DEGREE1F
frame srtran: recode DEGREE? (5/7 = 2)   /// Transcript, no degree (some col)
                             (1 = 3)     /// 2-y degree
                             (2 = 4)     /// 4-y degree
                             (3/4 = 5)   /// Graduate degree
                             (else = .)

* Collapse degrees: Maximum level observed across transcripts
frame srtran: egen degree = rowmax(DEGREE?)
frame srtran: collapse (max) degree, by(ID)

* Link transcript frame
frlink 1:1 ID, frame(srtran)

* Pull in degree from transcript frame
frget psetransr = degree, from(srtran)


label values pse*sr edatt



*************************
*** Post-secondary edcuation: Sophomores
*************************

* See introductory note at the begining of the PSE: Senior section, above.

** pse84so: Sophomore 1984 Post-secondary education

* Attended PSE
label list SY15
recode SY15 (1=2 /*Some*/) (2=1) (else=.), generate(pse84so)

* For each school attended, was a degree obtained in this period?
foreach i in 18 19 20 {
    
    * If SY15 was missing, but we have info on attendance here,
    * we can fill in the missing value with "Some college"
    replace pse84so = 2 if missing(pse84so) &                              ///
        (inrange(SY`i'A, 1,5) | inrange(SY`i'I, 1,9) | inrange(SY`i'J, 1,2))

    * Sub-item J indicates that a degree was completed
    * Sub-item I indicates what kind of degree

    * Completed 2-year degree (vocational or academic)
    replace pse84so = 3 if pse84so < 3 & SY`i'J == 1 & inlist(SY`i'I, 4, 5)
    * If degree type is missing
    *   assume it was an associate's degree if institution was "Jr/Cty Col"
    replace pse84so = 3 if pse84so < 3 & SY`i'J == 1 & SY`i'I > 90 & SY`i'A == 2
    
    * Completed 4-year degree
    replace pse84so = 4 if pse84so < 4 & SY`i'J == 1 & SY`i'I == 6
    * If degree type is missing,
    *   assume it was a bachelor's degree if institution was "college/uni"
    replace pse84so = 4 if pse84so < 4 & SY`i'J == 1 & SY`i'I > 90 & SY`i'A == 3
    
    * Completed grad degree
    replace pse84so = 5 if pse84so < 5 & SY`i'J == 1 & inlist(SY`i'I, 7, 8, 9)
    * If degree type is missing,
    *   assume it was a grad degree if institution was "grad/prof"
    replace pse84so = 5 if pse84so < 5 & SY`i'J == 1 & SY`i'I > 90 & SY`i'A == 5
    
    * Completion of any other kind of degree counts as only "Some College"
}


** pse86so: Sophomore 1986 Post-secondary education

* Attended PSE
label list TY20
recode TY20 (1/2=2 /*Some college*/) (3=1) (else=.), generate(pse86so)

* For each school attended, was a degree obtained in this period?
foreach i in 21 22 {
    
    * If TY20 was missing, but we have info on attendance here,
    * we can fill in the missing value with "Some college"
    replace pse86so = 2 if missing(pse86so) &                              ///
        (inrange(TY`i'A, 1,5) | inrange(TY`i'H, 1,9) | inrange(TY`i'I, 1,2))
    
    * Sub-item J indicates that a degree was completed
    * Sub-item I indicates what kind of degree
    
    * Completed 2-year degree (vocational or academic)
    replace pse86so = 3 if pse86so < 3 & TY`i'I == 1 & inlist(TY`i'H, 4, 5)
    * If degree type is missing
    *   assume it was an associate's degree if institution was "Jr/Cty Col"
    replace pse86so = 3 if pse86so < 3 & TY`i'I == 1 & TY`i'H > 90 & TY`i'A == 2
    
    * Completed 4-year degree
    replace pse86so = 4 if pse86so < 4 & TY`i'I == 1 & TY`i'H == 6
    * If degree type is missing,
    *   assume it was a bachelor's degree if institution was "college/uni"
    replace pse86so = 4 if pse86so < 4 & TY`i'I == 1 & TY`i'H > 90 & TY`i'A == 3
    
    * Completed grad degree
    replace pse86so = 5 if pse86so < 5 & TY`i'I == 1 & inlist(TY`i'H, 7, 8, 9)
    * If degree type is missing,
    *   assume it was a grad degree if institution was "grad/prof"
    replace pse86so = 5 if pse86so < 5 & TY`i'I == 1 & TY`i'H > 90 & TY`i'A == 5
    
    * Completion of any other kind of degree counts as only "Some College"
}


** psetranso: Sophomore Post-secondary transcript degree

* Code degrees
frame sotran: label list DEGREE
frame sotran: recode DEGREE  (1/2 = 2)   /// Transcript, no degree, Some col
                             (3 = 3)     /// 2-y degree
                             (4 = 4)     /// 4-y degree
                             (5/7 = 5)   /// Graduate degree
                             (else = .)

* Collapse degrees: Maximum level observed across transcripts
frame sotran: egen degree = rowmax(DEGREE)
frame sotran: collapse (max) degree, by(ID)

* Link transcript frame
frlink 1:1 ID, frame(sotran)

* Pull in degree from transcript frame
frget psetranso = degree, from(sotran)


label values pse*so edatt



*************************
*** Educational Attainment
*************************

* edatt: 1 "HS or less"  2 "Some college"  3 Two-year  4 Four-year  5 Grad
* "Some college" includes any college attendance, certificate, or license

* Attainment at 1986 is constructed based on self-reports for
*   specific time periods at each wave.
*   If any wave is missing, edattain86 is missing.
* Generally, if using multiple imputation, edattain86 should not be used
*   as is, but rather be recreated from the imputed pse* variables.


** edattain86: Educational attainment (1986)

* If pse{84,86}{so,sr} are both observed, take higher value; else, missing.

* This construction is similar to HS&B:80 variable EDATTAIN,
* but differs in how to treat missing values in the source variables,
* as well as treatment of "Some college" and 2-year degrees.

* Note: This variable does not have the same meaning for sophomores/seniors.

egen edattain86 = rowmax(pse84so pse86so pse84sr pse86sr)                  ///
     if (!missing(pse84so) & !missing(pse84so)) |                          ///
        (!missing(pse84sr) & !missing(pse86sr))


label values edattain* edatt



*************************
*** Recode
*************************

** hsregion: High School Region
label list SCHREGN
recode SCHREGN                                                             ///
  (1 /* New England*/ 2 /* Mid-atlantic */       = 1 "Northeast")          ///
  (3 /* S Atl */ 4 /* E S Atl */ 5 /* W S Atl */ = 2 "South")              ///
  (6 /* E N Cen */ 7 /* W N Cen */               = 3 "Midwest")            ///
  (8 /* Mountain */ 9 /* Pacific */              = 4 "West"),              ///
  generate(hsregion)


** hsurb: High School Urbanicity
* No recode needed
* Update the case for the value labels:
label list SCHURB
label define SCHURB  1 "Urban"  2 "Suburban"  3 "Rural", replace


** hstype: High School Type
label list SCHSAMP
recode SCHSAMP (0/3 = 1 "Public") (5/7 = 2 "Catholic") (8/9 = 3 "Private"), ///
  generate(hstype)


** cohort
label list GRADE
label define cohort  1 "Senior"  0 "Sophomore"
recode cohort (2=1 /*Senior*/) (1=0 /*Sophomore*/)
label values cohort cohort


** sex
label list SEX
label define sex  1 "Male"  0 "Female"
recode sex (1=1 /*Male*/) (2=0 /*Female*/)
label values sex sex


** race
label list RACE
label define race  1 "White"  2 "Black"  3 "Hispanic"  4 "Other"
recode race        (5=1)      (4=2)      (1=3)         (2 3 6 = 4)
label values race race


** home80: Family owned home in high school
label list BB102
label define home80  1 "Owned"  0 "Not owned"
recode home80 (1=1) (2/3=0) (else = .)
label values home80 home80


** hsprog: High School Track
label list BB002
label define hsprog  1 General  2 Academic  3 Vocational
recode hsprog FY2 (1=1) (2=2) (3/9=3) (else=.)
label values hsprog hsprog
* Prefer 1982 report for sophomores
replace hsprog = FY2 if !missing(FY2)


** Math/science course taking
recode alg1 alg2 geom trig calc physics chemistry biology (1=1) (2=0) (else=.)
label values alg1 alg2 geom trig calc physics chemistry biology .

** highmath: Highest level of math
label define highmath  0 "Below Algebra 1"  1 "Algebra 1 or Geometry"      ///
                       2 "Algebra 2" 3 "Trigonometry or Calculus"
gen highmath = (alg1 == 1 | geom == 1) if !missing(alg1) | !missing(geom)
replace highmath = 2 if alg2 == 1
replace highmath = 3 if trig == 1 | calc == 1
label values highmath highmath


** gpa12, gpa10: High School GPA (self-reported, 4.0 scale)
label list BB007
recode gpa12 gpa10 (1=4) (2=3.5) (3=3) (4=2.5) (5=2) (6=1.5) (7=1) (8=0)   ///
                   (else=.)
label values gpa12 gpa10 .


** marital86: Marital status (1986)
label list TY41
label define marital  1 "Married"  2 "Previously married"  3 "Never married"
recode marital86 (5 /*Married*/ 6 /*Like married*/ = 1)     /// Married
    (2 /*Divorced*/ 3 /*Widowed*/ 4 /*Separated*/ = 2)      /// Prev married
    (1 /*Never married*/ = 3)                               /// Never married
    (else = .)
label values marital86 marital



*************************
*** Labels
*************************

frame change vars

* Iterate over variables
forv i = 1/`=_N' {
    
    * Load the metadata for this variable
    local v = variable[`i']
    local lab = label[`i']
    
    * Label the variable
    if "`v'" != "" frame out: label variable `v' "`lab'"
}

frame change out



*************************
*** Done
*************************

* Get the final variable list
frame change vars
mata: st_local("vars", invtokens(st_sdata(., "variable")'))

* Keep only the relevant variables
frame change out
keep `vars'
order `vars'

* Clean up
sort ID
notes drop _dta
compress

label data "HS&B:80 Common Variables [$dtaversion]"
char _dta[version] "$dtaversion"

* Output
save "$outdir/hsb80-common.dta", replace
