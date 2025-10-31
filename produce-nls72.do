/* National Longitudinal Study of class of 1972: Clean public data files
   Michael J. Culbertson
   October 30, 2025
   
   Data sources:
     ICPSR 08085: NLS:72
   
   Set the global macros in the paths.do file for your system.
   Run this from the repository directory to access the utility programs.
   
   Produces the following Stata data files:
     nls7286.dta: NLS:72 student data through fifth follow up
                  - includes school data
     nls72-ps-trans.dta: NLS:72 post-secondary transcripts
     nls72-ps-course.dta: NLS:72 post-secondary terms/courses
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
*** nls7286.dta: NLS:72 student data through fifth follow up
*************************

** Load ICPSR 08085 DS0002: NLS:72 school data
use_ICPSR_08085_0002

* Standardize ID names
rename SCHCODE SCHID

* Drop variables redundant with student data file
drop MAJSTNO MINSTNO FINSTNO SRIFWT

* Write out temporary file
tempfile sch
save "`sch'" 


** Load ICPSR 08085 DS0001: NLS:72 student data through fourth follow up
*               and DS0012: NLS:72 fifth follow up
use_ICPSR_08085_student

* Keep only those in the panel
keep if !missing(RAWWT) & RAWWT > 0

* Standardize ID name
rename SCHCODE SCHID

* Normalize codes
recode_nls7286

* Merge in the school data
merge m:1 SCHID using "`sch'", nogenerate


** Code missing values

* Exclude variables with no missing value codes
unab exclude: ID SCHID RAWWT MAJSTNO MINSTNO W? W?? *WT SEI* NNONPART
unab vars: *
local vars: list vars - exclude

recode_missing `vars'

* For the SEI variables, > 99.1 indicates a missing value.
foreach v of varlist SEI* {
    display "`v': " _continue
    replace `v' = . if `v' > 99.1
}


** Save the dataset
label data "NLS:72 Panel [$dtaversion]"
char _dta[version] "$dtaversion"
sort ID
compress
save "$outdir/nls7286.dta", replace



*************************
*** nls72-ps-trans.dta: NLS:72 post-secondary transcripts
*************************

** Load ICPSR 08085 DS0010: NLS:72 post-secondary transcripts
use_ICPSR_08085_0010


** Code missing values

* Exclude variables with no missing value codes
unab exclude: ID COFCON ITYPE
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "NLS:72 Post-secondary Transcripts [$dtaversion]"
char _dta[version] "$dtaversion"
order ID TRANSNUM
sort ID TRANSNUM
compress
save "$outdir/nls72-ps-trans.dta", replace



*************************
*** nls72-ps-course.dta: NLS:72 post-secondary courses
*************************

** Load ICPSR 08085 DS0009: NLS:72 post-secondary terms
use_ICPSR_08085_0009

* Write out temporary file
tempfile term
save "`term'" 


** Load ICPSR 08085 DS0006: NLS:72 post-secondary courses
use_ICPSR_08085_0006

* Merge in term data
merge m:1 STUID TRANSNUM TERMNUM using "`term'", nogenerate

* The institution type variables in the course file don't seem to be reliable.
* (User who need them should pull them from the transcript file, instead.)
drop INSTYPE ITYPE TYPE

* Standardize ID names
rename STUID ID


** Code missing values

* Exclude variables with no missing value codes
unab exclude: ID TRANSNUM TERMNUM
unab vars: *
local vars: list vars - exclude

recode_missing `vars'


** Save the dataset
label data "NLS:72 Post-secondary Courses [$dtaversion]"
char _dta[version] "$dtaversion"
order ID TRANSNUM
sort ID TRANSNUM
compress
save "$outdir/nls72-ps-course.dta", replace



*************************
*** Done
*************************
