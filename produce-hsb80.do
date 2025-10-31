/* High School & Beyond 1980: Clean public data files
   Michael J. Culbertson
   October 30, 2025
   
   Data sources:
     ICPSR 07896: HS&B:80 Base year (1980)
     ICPSR 08297: HS&B:80 First follow-up (1982)
     ICPSR 08443: HS&B:80 Second follow-up (1984)
     ICPSR 08896: HS&B:80 Third follow-up (1986)
   
   Set the global macros in the paths.do file for your system.
   Run this from the repository directory to access the utility programs.
   
   Produces the following Stata data files:
     hsb80.dta: HS&B:80 sophomore and senior base year data (full sample)
                - includes language data
     hsb82.dta: HS&B:80 sophomore first follow-up data (full sample)
     hsb8086.dta: HS&B:80 base year to third follow-up data (panel sample)
     hsb80-school.dta: HS&B:80/82 school data
     hsb80-teacher.dta: HS&B:80 teacher comment data (both cohorts)
     hsb80-hs-trans-so.dta: HS&B:80 sophomore high school transcripts
     hsb80-hs-course-so.dta: HS&B:80 sophomore high school transcript courses
     hsb80-ps-trans-sr.dta: HS&B:80 senior post-secondary transcripts
     hsb80-ps-trans-so.dta: HS&B:80 sophomore post-secondary transcripts
     hsb80-ps-course-sr.dta: HS&B:80 senior post-secondary terms/courses
     hsb80-ps-course-so.dta: HS&B:80 sophomore post-secondary terms/courses
*/


* Location of this file
global dodir "."

* Load the path macros
do "$dodir/paths.do"


clear all
set maxvar 6000

* Data version
global dtaversion "2025-10-30"



*************************
*** hsb80.dta: HS&B:80 base year data (full sample)
*************************

** Load ICPSR 07896 DS0004: HS&B:80 base year language data
use_ICPSR_07896_0004

* Standardize ID names
rename CASEID ID
drop SCHOOLID STUDNTID

* Write out temporary file
tempfile lang
save "`lang'" 


** Load ICPSR 07896 DS0002: HS&B:80 base year student file
use_ICPSR_07896_0002

* Standardize ID names
rename CASEID ID
rename SCHOOLID SCHID

* Merge in language data
merge 1:1 ID using "`lang'", nogenerate


** Code missing values

* Exclude variables with no missing value codes
local exclude ID SCHID STUDNTID DESIGNWT CENRGN SCHLTYPE
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "HS&B:80 Base Year [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID
compress
save "$outdir/hsb80.dta", replace



*************************
*** hsb82.dta: HS&B:80 sophomore first follow-up data (full sample)
*************************

** Load ICPSR 08297 DS0001: HS&B:80 first follow-up sophomore data file
use_ICPSR_08297_0001

* Standardize ID names
rename SCHLID SCHID


** Code missing values

* Exclude variables with no missing value codes
local exclude SCHSAMP SCHREGN RACE
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "HS&B:80/82 Sophomores [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID
compress
save "$outdir/hsb82.dta", replace



*************************
*** hsb8086.dta: HS&B:80 sophomore and senior panel data to third follow-up
*************************

** Load ICPSR 08896 DS0001: HS&B:80 senior panel data to third follow-up
use "$ICPSR_08896/DS0001/08896-0001-Data.dta", clear

* Run the ICPSR code to remove missing value reserve codes
do "$ICPSR_08896/DS0001/08896-0001-Supplemental_syntax.do"

* Fix missing value labels
foreach v of varlist FE24?12 {
    label define `v' 1 "YES" 2 "NO" 3 "STILL HAVE JOB", modify
}

* Fill in missing cohort
replace GRADE = 2 if missing(GRADE)  // Senior

* Write out temporary file
tempfile sr
save "`sr'"


** Load ICPSR 08896 DS0002: HS&B:80 sophomore panel data to third follow-up
use "$ICPSR_08896/DS0002/08896-0002-Data.dta", clear

* Run the ICPSR code to remove missing value reserve codes
do "$ICPSR_08896/DS0002/08896-0002-Supplemental_syntax.do"

* Fill in missing cohort
replace GRADE = 1 if missing(GRADE)  // Sophomore

* Append senior data
append using "`sr'"

* Fix value labels
label define GRADE 2 "SENIOR", modify


** Save the dataset
label data "HS&B:80/86 Panel [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID
compress
save "$outdir/hsb8086.dta", replace



*************************
*** hsb80-school.dta: HS&B:80/82 school data
*************************

** Load ICPSR 08297 DS0010: HS&B:80 course offerings and enrollment
use_ICPSR_08297_0011_school


** Code missing values

* Exclude variables with no missing value codes
local exclude SCHSAMP SCHREGN
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "HS&B:80/82 Schools [$dtaversion]"
char _dta[version] "$dtaversion"
sort SCHID
compress
save "$outdir/hsb80-school.dta", replace



*************************
*** hsb80-teacher.dta: HS&B:80 teacher comment data (both cohorts)
*************************

** Load ICPSR 07896 DS0005: Teacher comment, seniors
use_ICPSR_07896_0005

* Flag cohort
gen cohort = 1  // Seniors

* Write out temporary file
tempfile sr
save "`sr'" 


** Load ICPSR 07896 DS0006: Teacher comment, sophomores
use_ICPSR_07896_0006

* Flag cohort
gen cohort = 0  // Sophomores

* Append senior data
append using "`sr'"


** Code missing values

* Exclude variables with no missing value codes
local exclude SCHID STUDNTID ID TEACHID
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Fix labels

* Unique teacher ID
gen long TID = int(SCHID)*1000 + int(cohort)*500 + int(TEACHID)
label variable TID "Unique Teacher ID"

label define cohort 0 "Sophomore" 1 "Senior"
label values cohort cohort
label variable cohort "Cohort"


** Save the dataset
label data "HS&B:80 Teacher Comment [$dtaversion]"
char _dta[version] "$dtaversion"
order ID TID SCHID STUDNT cohort TEACHID
sort ID TID
compress
save "$outdir/hsb80-teacher.dta", replace



*************************
*** hsb80-hs-trans-so.dta: HS&B:80 sophomore high school transcripts
*************************

** Load ICPSR 08297 DS0006: HS&B:80 sophomore high school transcripts
use_ICPSR_08297_0006_transcript


** Code missing values

* Exclude variables with no missing value codes
unab exclude: ID SCHSAMP SCHREGN FSCHID COURS*
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "HS&B:80 Sophomore High School Transcripts [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID TRANSNUM
compress
save "$outdir/hsb80-hs-trans-so.dta", replace



*************************
*** hsb80-hs-course-so.dta: HS&B:80 sophomore high school transcript courses
*************************

** Load ICPSR 08297 DS0006: HS&B:80 sophomore high school transcript courses
use_ICPSR_08297_0006_course

* Fix coding
recode YEAR (19=96 /*Uncodable verbatim*/)


** Code missing values
unab vars: *
recode_missing `vars'


** Save the dataset
label data "HS&B:80 Sophomore High School Transcript Courses [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID
compress
save "$outdir/hsb80-hs-course-so.dta", replace



*************************
*** hsb80-ps-trans-sr.dta: HS&B:80 senior post-secondary transcripts
*************************

** Load ICPSR 08443 DS0011: HS&B:80 senior post-secondary transcripts
use_ICPSR_08443_0011

* Drop cases with missing student ID
drop if missing(ID)


** Code missing values
unab vars: *
recode_missing `vars'


** Save the dataset
label data "HS&B:80 Senior Post-secondary Transcripts [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID TRANSNUM
compress
save "$outdir/hsb80-ps-trans-sr.dta", replace



*************************
*** hsb80-ps-trans-so.dta: HS&B:80 sophomore post-secondary transcripts
*************************

** Load ICPSR 08896 DS0006: HS&B:80 sophomore post-secondary transcripts
use "$ICPSR_08896/DS0006/08896-0006-Data.dta", clear

* Standardize ID names
rename STUID ID

* Run the ICPSR code to remove missing value reserve codes
do "$ICPSR_08896/DS0006/08896-0006-Supplemental_syntax.do"


** Save the dataset
label data "HS&B:80 Sophomore Post-secondary Transcripts [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID TRANSNUM
compress
save "$outdir/hsb80-ps-trans-so.dta", replace



*************************
*** hsb80-ps-course-sr.dta: HS&B:80 senior post-secondary terms/courses
*************************

** Load ICPSR 08443 DS0012: HS&B:80 senior post-secondary terms
use_ICPSR_08443_0012

* Write out temporary file
tempfile sr
save "`sr'" 


** Load ICPSR 08443 DS0013: HS&B:80 senior post-secondary courses
use_ICPSR_08443_0013

* Merge in term data
merge m:1 STUID TRANSNUM TERMNUM using "`sr'", nogenerate

* Standardize ID names
rename STUID ID


** Code missing values

* Exclude variables with no missing value codes
local exclude ID SORTDATE
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "HS&B:80 Senior Post-secondary Courses [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID TRANSNUM TERMNUM
compress
save "$outdir/hsb80-ps-course-sr.dta", replace



*************************
*** hsb80-ps-course-so.dta: HS&B:80 sophomore post-secondary terms/courses
*************************

** Load ICPSR 08896 DS0003: HS&B:80 sophomore post-secondary courses
use "$ICPSR_08896/DS0003/08896-0003-Data.dta", clear


** Merge ICPSR 08896 DS0005: HS&B:80 sophomore post-secondary terms
merge m:1 STUID TRANSNUM TERMNUM                                           ///
      using "$ICPSR_08896/DS0005/08896-0005-Data.dta", nogenerate

* Standardize ID names
rename STUID ID

* Run the ICPSR code to remove missing value reserve codes
do "$ICPSR_08896/DS0003/08896-0003-Supplemental_syntax.do"
do "$ICPSR_08896/DS0005/08896-0005-Supplemental_syntax.do"


** Save the dataset
label data "HS&B:80 Sophomore Post-secondary Courses [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID TRANSNUM TERMNUM
compress
save "$outdir/hsb80-ps-course-so.dta", replace



*************************
*** Done
*************************
