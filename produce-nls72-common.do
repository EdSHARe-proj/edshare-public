/* NLS:72 Common Variables
   Michael J. Culbertson
   October 30, 2025
   
   Data sources:
     nls7286.dta: NLS:72 student data through fifth follow up
     nls72-ps-trans.dta: NLS:72 post-secondary transcripts
   
   Set the global macros in the paths.do file for your system.
   Run this from the repository directory to access metadata.
   
   This dataset compiles standard operationalizations for our most commonly
   used variables, including the recommended standard minimum set of variables
   for multiple imputation. Unlike most EdSHARe internal datasets,
   this data file uses system missing values, rather than reserve codes.
   
   Universe for the file is all NLS:72 panel members (F5 selection).
   
   Notes:
   - hsg12: High School Grade 12 Enrollment
     For sampling strata, grade 12 enrollment was originally classified by:
       less than 300, 300 to 599, and 600 or more
   - Occupation codes in NLS:72 historical data are according to the
     1970 Census Occupational Classification System
     See Appendix C.1 in the NLS:72 revised data documentation.
   - Duncan socioeconomic index codes for these occupations are in
     Appendix K.1 of the original documentation (ICPSR 08085/DS0025)
     For the SEI variables, > 99.1 indicates a missing value.
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
frame vars: import delimited "$repodir/variables-nls72.csv", varnames(1)

* Socioeconomic index by 1970 Census Occupation Codes
frame create sei
frame sei: import delimited "$repodir/sei-scores.csv", varnames(1)


* Load NLS:72 panel data
frame create out
frame out: use "$dtadir/nls7286.dta"

* NLS:72 transcripts
frame create trans
frame trans: use "$dtadir/nls72-ps-trans.dta"



*************************
*** Collate variables
*************************

frame change vars

* Iterate over variables
forv i = 1/`=_N' {
    
    * Load the metadata for this variable
    local src = srcvar[`i']        // Source variable name
    local v = variable[`i']        // Destination (output) variable name
    if "`src'" != "" & "`v'" != "" & "`src'" != "`v'" {
        frame out: rename `src' `v'
    }

}

frame change out



*************************
*** High school context
*************************

** hsstate: High School State (STCODE)
*  Recode to FIPS
label list STCODEF
recode STCODE (1=1 "AL") (2=2 "AK") (3=4 "AZ") (4=5 "AR") (5=6 "CA")       ///
              (6=8 "CO") (7=9 "CT") (8=10 "DE") (9=11 "DC") (10=12 "FL")   ///
              (11=13 "GA") (12=15 "HI") (13=16 "ID") (14=17 "IL")          ///
              (15=18 "IN") (16=19 "IA") (17=20 "KS") (18=21 "KY")          ///
              (19=22 "LA") (20=23 "ME") (21=24 "MD") (22=25 "MA")          ///
              (23=26 "MI") (24=27 "MN") (25=28 "MS") (26=29 "MO")          ///
              (27=30 "MT") (28=31 "NE") (29=32 "NV") (30=33 "NH")          ///
              (31=34 "NJ") (32=35 "NM") (33=36 "NY") (34=37 "NC")          ///
              (35=38 "ND") (36=39 "OH") (37=40 "OK") (38=41 "OR")          ///
              (39=42 "PA") (40=44 "RI") (41=45 "SC") (42=46 "SD")          ///
              (43=47 "TN") (44=48 "TX") (45=49 "UT") (46=50 "VT")          ///
              (47=51 "VA") (48=53 "WA") (49=54 "WV") (50=55 "WI")          ///
              /* No Wyoming */ , generate(hsstate)
table hsstate, missing


** hsregion: High School Region (STCODE)
recode STCODE ///
  ( 7/*CT*/ 20/*ME*/ 22/*MA*/ 30/*NH*/ 40/*RI*/ 46/*VT*/ /*New England*/   ///
   31/*NJ*/ 33/*NY*/ 39/*PA*/                            /*Mid-Atlantic*/  ///
                                                      = 1 "Northeast")     ///
  ( 8/*DE*/  9/*DC*/ 10/*FL*/ 11/*GA*/ 21/*MD*/                            ///
   34/*NC*/ 41/*SC*/ 47/*VA*/ 49/*WV*/                  /*South Atlantic*/ ///
    1/*AL*/ 18/*KY*/ 25/*MS*/ 43/*TN*/                  /*E S Central*/    ///
    4/*AR*/ 19/*LA*/ 37/*OK*/ 44/*TX*/                  /*W S Central*/    ///
                                                     = 2 "South")          ///
  (14/*IL*/ 15/*IN*/ 23/*MI*/ 36/*OH*/ 50/*WI*/         /*E N Central*/    ///
   16/*IA*/ 17/*KS*/ 24/*MN*/ 26/*MO*/                                     ///
   28/*NE*/ 35/*ND*/ 42/*SD*/                           /*W N Central*/    ///
                                                     = 3 "Midwest")        /// 
  ( 3/*AZ*/  6/*CO*/ 13/*ID*/ 27/*MT*/                                     ///
   29/*NV*/ 32/*NM*/ 45/*UT*/   /*WY*/                  /*Mountain*/       ///
    2/*AK*/  5/*CA*/ 12/*HI*/ 38/*OR*/ 48/*WA*/         /*Pacific*/        ///
                                                     = 4 "West"),          ///
  generate(hsregion)
table hsregion, missing


** hstype: High School Type (PUBPRIV)
* Recode to match hsb80-common
label list PUBPRIVF
recode hstype (1=1 /*Public*/) (2=3 /*Private*/) (3=2 /*Catholic*/) (else = .)
label define hstype  1 "Public"  2 "Catholic" 3 "Private"
label values hstype hstype


** hspub: Public high school (PUBPRIV)
recode hstype (1=1 "Public") (2 3 = 0 "Not public"), generate(hspub)


** hsurb: High School Urbanicity (SCHQ40)
label list SCHQ40F
label define hsurb 1 "Urban"  2 "Suburban"  3 "Rural"
recode hsurb   (2 3 5 7 = 1)   (4 6 8 = 2)      (1=3)  (else = .)
label values hsurb hsurb
table hsurb, missing


** hscomsz: High School Community Size (COMMUNIT72)
* Remove missing values
recode hscomsz (91/99 = .)
label define hscomsz 1 "Small" 2 "Medium" 3 "Large" 4 "Very large"
label values hscomsz hscomsz
table hscomsz, missing



*************************
*** Demographics
*************************

** sex: Sex (CSEX72, TFUSEX)
label list CSEX72F
recode sex TFUSEX (1=1 /*Male*/) (2=0 /*Female*/) (91/99 = .)
* Fill in missing from third follow-up
replace sex = TFUSEX if missing(sex)

label define sex 1 "Male" 0 "Female"
label values sex sex
table sex, missing


** race: Race/ethnicity (CRACE, FI97, FI98)
label list CRACEF
recode race (7=1 /*White*/) (2=2 /*Black*/) (3/5=3 /*Hispanic*/)           ///
            (1 6 8 = 4 /*Other*/) (91/99=.)
* Fill in missing from F5
label list FI98F
label list FI97F
replace race = 1 if missing(race) & FI98 == 2 & !inlist(FI97, 2, 5)   // White
replace race = 2 if missing(race) & FI98 == 1 & !inlist(FI97, 2, 5)   // Black
replace race = 3 if missing(race) & inlist(FI97, 2, 5)             // Hispanic

table FI98 FI97 if missing(race), missing
replace race = 4 if missing(race)                       // Other (and unknown)

label define race 1 "White" 2 "Black" 3 "Hispanic" 4 "Other"
label values race race
table race, missing


** marital79: Marital status (1979, FT165)
label define marital  1 "Married"  2 "Previously married"  3 "Never married"
label list FT165F
recode marital79 (4/5=1 /*Married*/) (3=2 /*Prev*/) (1/2=3 /*Never*/) (else=.)

label values marital79 marital
table marital79, missing


** marital86: Marital status (1986, FI77)
* Note: Include "Pseudo-married" in "Married"
label list FI77F
recode marital86 (4/5=1 /*Married*/) (1/3=2 /*Prev*/) (6=3 /*Never*/) (else=.)

label values marital86 marital
table marital86, missing



*************************
*** Family socioeconomic status
*************************


** paredu: Parental education (CFAED86, CMOED86)

*  Note: BQ90{A,B} separates some grad school from grad degree attainment.
*  Items about parental education in follow-up surveys don't distinguish.
*  The NLS:72 ed composite variable includes "some grad school" from BQ90
*  in the grad school category.

* Recode
label list CFAED86F
label define edatt  1 "HS or less"  2 "Some college" ///
    3 "Two-year Degree"  4 "Four-year Degree"  5 "Graduate Degree"
recode CFAED86 CMOED86 (1/2 = 1) (3 = 2) (4 = 4) (5 = 5) (91/99 = .)
* Get highest parental education
egen paredu = rowmax(CFAED86 CMOED86)

label values paredu edatt
table paredu, missing


** sibedu: Oldest sibling's education in 1972
* Note: Combine "some grad school" with "grad degree attainment" to mirror
* handling of BQ90 in the parental education composite variable.
label list BQ90CF
recode sibedu (1=0) (2/4=1) (5/6=2) (7=4) (8/9=5) (91/99=.)

label copy edatt sibedu
label define sibedu 0 "Not applicable", modify
label values sibedu sibedu
table sibedu, missing


** parocc: Parent occupational socioeconomic index (Duncan)

* Use Duncan SEI scores for specific occupations (1970 Census codes, BQ97/101)
* Fill in missing with a score for broad categories (BQ25)

* Remove missing values
replace SEIBQ97 = . if SEIBQ97 > 99.1
replace SEIBQ101 = . if SEIBQ101 > 99.1

* Duncan scores for occupational categories (Table K.2, ICPSR 08085/DS0025)
label list BQ25BF
recode BQ25B BQ25C                                                         ///
    ( 1 = 56.58 /*Clerical*/     )                                         ///
    ( 2 = 27.41 /*Craftsman*/    )                                         ///
    ( 3 = 28.00 /*Farmer*/       )                                         ///
    ( 4 =   .   /*Homemaker*/    )                                         ///
    ( 5 =  7.33 /*Laborer*/      )                                         ///
    ( 6 = 67.73 /*Manager*/      )                                         ///
    ( 7 =   .   /*Military*/     )                                         ///
    ( 8 = 19.18 /*Operative*/    )                                         ///
    ( 9 = 70.21 /*Professional*/ )                                         ///
    (10 = 49.70 /*Proprietor*/   )                                         ///
    (11 = 38.00 /*Protective*/   )                                         ///
    (12 = 54.42 /*Sales*/        )                                         ///
    (13 = 15.90 /*Service*/      )                                         ///
    (14 = 61.40 /*Technical*/    )                                         ///
    (else = .)
* Fill in missing with the score for broad categories
replace SEIBQ97 = BQ25B if missing(SEIBQ97)
replace SEIBQ101 = BQ25C if missing(SEIBQ101)

* Take the higher parental Duncan SEI score
egen parsei = rowmax(SEIBQ97 SEIBQ101)


** income72: Family income in 1972 (BQ93)

* Use the midpoint of the response option ranges; except that the highest
* category does not have a defined mid-point.
* If we fit the data to a Normal distribution with cut points defined by the
* response option ranges, we obtain mean ~ $11k with sd ~ $6k.
* Value for category 10, below, is close to the median of the
* truncated Normal distribution corresponding to the given response option.

label list BQ93F
recode income72 (1 = 1500) (2 = 4500) (3 = 6750) (4 = 8250) (5 = 9750)     ///
                (6 = 11250) (7 = 12750) (8 = 14250) (9 = 16500)            ///
                (10 = 20250) (else = .)
label define income72  1500 "<$3k"  4500 "$3-6k"  6750 "$6-7.5k"           ///
    8250 "$7.5-9k"  9750 "$9-10.5k"  11250 "$10.5-12k"  12750 "$12-13.5k"  ///
    14250 "$13.5-15k"  16500 "$15-18k"  20250 ">$18k"
label values income72 income72
table income72, missing


** siblings: Number of siblings (SQ119/120)

* Remove missing
label list SQ119AF
recode SQ119? SQ120? (990/999 = .)

* Get total number of siblings
egen siblings = rowtotal(SQ119A SQ119B SQ120A SQ120B), missing

* Cap at "5 or more"
replace siblings = 5 if !missing(siblings) & siblings > 5

label define siblings 5 "5 or more"
label values siblings siblings
table siblings, missing


** homesei72: Household item socioeconomic index (BQ94)
* Factor model for having ten household items

* Recode to binary
recode BQ94B-BQ94K (1=1) (2=0) (else = .)

* Flag individuals with data
egen have_homesei = rownonmiss(BQ94B-BQ94K)

* Score IRT model
gsem (SEI -> BQ94B-BQ94K, logit), latent(SEI) var(SEI@1)
predict homesei72 if have_homesei > 0, latent
sum homesei72



*************************
*** High school experience
*************************

** hstransfer: Transferred to high school (SRFQ3)
label list SRFQ3F
label define hstransfer 1 "Transferred"  0 "Did not transfer"
recode hstransfer (1=0 /*No*/) (2=1 /*Yes*/) (else=.)
label values hstransfer hstransfer
table hstransfer, missing


** hsprog: High School Track (BQ2)
label list BQ2F
recode hsprog (1=1 /*General*/) (2=2 /*Academic*/) (3/8=3 /*Vocational*/)  ///
              (else = .)
label define hsprog 1 "General"  2 "Academic"  3 "Vocational"
label values hsprog hsprog
table hsprog, missing


** hsmath: Semesters of HS math
** hssci:  Semesters of HS science
recode hsmath hssci (91/99 = .)


** gpa12: Grade 12 GPA (4.0 scale)
recode gpa12 (1 = 4.0) (2 = 3.5) (3 = 3.0) (4 = 2.5) (5 = 2.0) (6 = 1.5)   ///
             (7 = 1.0) (8 = 0) (91/99 = .)
label values gpa12 .
table gpa12, missing



*************************
*** Post-secondary education
*************************

label define pse  1 "No PSE"  2 "Some college"                             ///
                  3 "Working toward Bachelor's degree"                     ///
                  4 "Earned BA"


** pse73: Post-secondary education (1973)
label list FQ23F
label list FQ26BF
label list FQ42F
recode FQ23 (1=2 /*Some*/) (2=1 /*No PSE*/) (else = .), generate(pse73)
replace pse73 = 3 if inlist(3, FQ26B, FQ32B, FQ40B) | FQ42 == 6  // Work to BA

label values pse73 pse
table pse73, missing


** pse74: Post-secondary education (1974)
label list SQ9F
label list SQ12F
recode SQ9 (1=1 /*No PSE*/) (2=2 /*Some*/) (else = .), generate(pse74)
replace pse74 = 3 if inlist(3, SQ12, SQ34)  // Working toward BA
* Earned a certificate or diploma between Oct 73 and Oct 74:
replace pse74 = 2 if (missing(pse74) | pse74 == 1) &         ///  Some college
           (SQ66BA == 2 | SQ66CA == 3 | SQ66D == 4 | SQ66E == 5 | SQ66GA == 7)
replace pse74 = 4 if SQ66F == 6             // Earned BA

label values pse74 pse
table pse74, missing


** psetran: Post-secondary transcript degree

* Code degrees
frame trans: label list DEGREE1F
frame trans: recode DEGREE? (5/8 = 2)   /// Transcript, no degree (some col)
                            (1 = 3)     /// 2-y degree
                            (2 = 4)     /// 4-y degree
                            (3/4 = 5)   /// Graduate degree
                            (else = .)

* Collapse degrees: Maximum level observed across transcripts
frame trans: egen degree = rowmax(DEGREE?)
frame trans: collapse (max) degree, by(ID)

* Link transcript frame
frlink 1:1 ID, frame(trans)

* Pull in degree from transcript frame
frget psetrans = degree, from(trans)

label values psetrans edatt
table psetrans, missing



*************************
*** Educational Attainment
*************************

* edatt: 1 "HS or less"  2 "Some college"  3 Two-year  4 Four-year  5 Grad
* "Some college" includes any college attendance, certificate, or license


** edattain76: Educational attainment (1976)
label list TQ49AF
recode edattain76 (1=1) (2/5=2) (6=4) (7/8=5) (else=.)
* Two-year degree attainment
replace edattain76 = 3 if (missing(edattain76) | edattain76 < 3) &         ///
                          (TQ48CA == 3 | TQ48DA == 4)


** edattain79: Educational attainment (1979)
label list FT67F
recode edattain79 (0=1) (1/2=2) (3=4) (4/5=5) (else=.)
* Two-year degree attainment
replace edattain79 = 3 if (missing(edattain79) | edattain79 < 3) &         ///
                          (FT76CA == 3 | FT76DA == 4)


** edattain86: Educational attainment (1986)
* Note: F5 attainment item does not include associate's degree
label list FI29F
recode edattain86 (1/2=1) (3/6=2) (7=4) (8/9=5) (else=.)


label values edattain* edatt
table edattain76, missing
table edattain79, missing
table edattain86, missing



*************************
*** Employment
*************************

label define employ  0 "Not employed"  1 "Employed"


** employ79: Employment status (1979)
label list ACT579F
recode employ79 (1/2 = 1) (4 = 0) (else = .)
label values employ79 employ
table employ79, missing


** employ86: Employment status (1986)
label list FI3AF
recode employ86 (1 = 1) (2 = 0) (else = .)
label values employ86 employ
table employ86, missing


** occsei79: Occupation socioeconomic index (1979)
* Use Duncan SEI scores for specific occupations (1970 Census codes, FT12AD)
* Remove missing values
replace occsei79 = . if occsei79 > 99.1


** occsei86: Occupation socioeconomic index (1986)
* The NCES dataset does not include the Duncan SEI scores,
* so we have to look them up based on the 1970 Census codes (FI7A).
* The Duncan scores are from Appendix K.1 (ICPSR 08085/DS0025).
frlink m:1 FI7A, frame(sei occ70)
frget occsei86 = duncan, from(sei)
drop sei
sum occsei86



*************************
*** Health
*************************

** physdisab: Limiting physical condition (BQ83)
label list BQ83F
recode physdisab (1=0 /*No*/) (2=1 /*Yes*/) (else = .)
label define physdisab                                                     ///
    1 "Limiting physical condition" 0 "No limiting phyiscal condition"
label values physdisab physdisab


** earlyhealth: Ill health interfered with education (BQ17K)
recode earlyhealth (91/99=.)
label define BQ17KF  1 "Not at all"  2 "Somewhat"  3 "A great deal", replace
table earlyhealth, missing



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

label data "NLS:72 Common Variables [$dtaversion]"
char _dta[version] "$dtaversion"

* Output
save "$outdir/nls72-common.dta", replace
