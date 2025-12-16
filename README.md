EdSHARe Public Datasets
=======================

[Education Studies for Healthy Aging Research](https://edshareproject.org/)
consists of two nationally representative education-turned-aging survey
cohorts: the
[National Longitudinal Study of the High School Class of 1972](https://nces.ed.gov/surveys/nls72/)
(NLS:72) and the
[High School and Beyond Study of 1980](https://nces.ed.gov/surveys/hsb/hsb80.asp)
(HS&B:80). While recent rounds of midlife data collection are available only
under a
[restricted-use data license](https://nces.ed.gov/statprog/instruct.asp)
from the [National Center for Education Statistics](https://nces.ed.gov/),
archived historical data from 1972-1986 are available publicly from the
[Inter-university Consortium for Political and Social Research](https://www.icpsr.umich.edu/sites/icpsr/home)
(ICPSR). The code in this repository cleans the ICPSR data into a more
user-friendly format.

The processed Stata datasets may be [downloaded from GitHub](https://github.com/EdSHARe-proj/edshare-public/releases).


## Source Data

The source ICPSR datasets are:
- [ICPSR 7896](https://www.icpsr.umich.edu/web/ICPSR/studies/7896): HS&B:80 Base year (1980)
- [ICPSR 8085](https://www.icpsr.umich.edu/web/ICPSR/studies/8085): NLS:72
- [ICPSR 8297](https://www.icpsr.umich.edu/web/ICPSR/studies/8297): HS&B:80 First follow-up (1982)
- [ICPSR 8443](https://www.icpsr.umich.edu/web/ICPSR/studies/8443): HS&B:80 Second follow-up (1984)
- [ICPSR 8896](https://www.icpsr.umich.edu/web/ICPSR/studies/8896): HS&B:80 Third follow-up (1986)

Refer to the documentation included with each dataset for detailed
information about the original data collection and processing.


## Data Files Generated

The file `produce-hsb80.do` generates the following Stata datasets:
- `hsb80.dta`: HS&B:80 sophomore and senior base year data (full sample), inluding language data
- `hsb82.dta`: HS&B:80 sophomore first follow-up data (full sample)
- `hsb8086.dta`: HS&B:80 base year to third follow-up data (panel sample)
- `hsb80-school.dta`: HS&B:80/82 school data
- `hsb80-teacher.dta`: HS&B:80 teacher comment data (both cohorts)
- `hsb80-hs-trans-so.dta`: HS&B:80 sophomore high school transcripts
- `hsb80-hs-course-so.dta`: HS&B:80 sophomore high school transcript courses
- `hsb80-ps-trans-sr.dta`: HS&B:80 senior post-secondary transcripts
- `hsb80-ps-trans-so.dta`: HS&B:80 sophomore post-secondary transcripts
- `hsb80-ps-course-sr.dta`: HS&B:80 senior post-secondary terms/courses
- `hsb80-ps-course-so.dta`: HS&B:80 sophomore post-secondary terms/courses

The file `produce-nls72.do` generates the following Stata datasets:
- `nls7286.dta`: NLS:72 student data through fifth follow up, including school data
- `nls72-ps-trans.dta`: NLS:72 post-secondary transcripts
- `nls72-ps-course.dta`: NLS:72 post-secondary terms/courses

The files `produce-hsb80-common.do` and `produce-nls72-common.do` further
process the data to clean several commonly used variables, producing the
Stata datasets `hsb80-common.dta` and `nls72-common.dta`. Refer to the
documentation for the
[HS&B:80 Common Variables Public Dataset](https://edshareproject.org/files/hsb80_common_variables_public_dataset.pdf)
and the
[NLS:72 Common Variables Public Dataset](https://edshareproject.org/files/nls72_common_variables_public_dataset.pdf)
for more information about the contents.


## Repository Contents

In addition to the `do` files listed above, this repository includes the
following files:
- `paths.do`: File paths for data and metadata (**Customize these for your system.**)
- `sei-scores.csv`: Otid Dudley Duncan occupational socioeconomic index scores by 1970 Census occupation classification codes, from [Appendix K](https://www.icpsr.umich.edu/web/ICPSR/studies/8085/datadocumentation) of the NLS:72 documentation
- `recode_nl7286.ado`: Stata program to normalize the coding system for NLS:72 (refer to the section on recoding NLS:72, below, for details)
- `recode_missing.ado`: Stata program to remove missing value reserve codes
- `*.dct`: Stata dictionaries for the ICPSR data files
- `use_*.ado`: Stata programs to read in and label ICSPR data files
- `variables-*.csv`: Variable metadata for construction of common variables datasets


## Recoding NLS:72

The NLS:72 student surveys were conducted on paper, with many instructions
for students to skip sections based on their responses to routing questions.
For example, a student who said they did not attend college should have
skipped the subsequent questions about their college experience. However,
respondents did not always follow the skip instructions. The original NLS:72
study team chose to maintain all student responses, even those that are
inconsistent and ignore the skip instructions. The study team applied a
complex system of codes to indicate inconsistent student responses. Refer to
the documentation for the NLS:72 data for details on the coding system.

These codes can make analyzing NLS:72 data challenging. The Stata program
recode_nls7286 simplifies the coding of the NLS:72 student data to enforce
the intended skip instructions, as if the respondent had been taking the
survey using a modern computer interface, rather than on paper. The
simplified coding scheme replaces all inconsistent responses (items a
respondent should have skipped, according to the instructions) with the code
for legitimate skip (99). In cases where a respondent failed to respond to a
routing item, the subsequent items are treated as if they should have been
skipped, following common coding practices for modern online surveys.

While the recode_nls7286 program greatly simplifies coding for the NLS:72
data, it does remove responses that some analysts may find useful. For
example, if a respondent fails to respond to the routing item asking if they
attended college, but subsequently provided information about when they were
enrolled in college, the recode_nls7286 program will remove the information
about college enrollment dates, following the logic that these items would
have been skipped in an online survey if the respondent refused to answer
the initial routing item. Some analysts may instead want to use the
subsequent information about college enrollment dates to edit the missing
response about college attendance. Analysts should study the NLS:72
instrument skip instructions carefully for the items they are analyzing and
determine whether they would prefer an alternative coding scheme, returning
to the original data to obtain relevant responses removed by recode_nls7286.
