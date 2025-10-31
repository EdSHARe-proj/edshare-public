/* EdSHARe public data: File paths
   Set these paths for the locations appropriate for your system.
*/


* The location of this file
global repodir "."

* Where to save the constructed data files
global outdir "."

* The location of ICPSR folders
global ICPSRdir "./ICPSR"

* The location of the Stata dictionaries
global dctdir "$repodir/dct"

* The location of the Stata programs to load ICPSR data
global adodir "$repodir/ado"
adopath + "$adodir"


** The location of specific ICPSR folders

* HS&B:80
global ICPSR_07896 "$ICPSRdir/ICPSR_07896"

* HS&B:80/82
global ICPSR_08297 "$ICPSRdir/ICPSR_08297"

* HS&B:80/84
global ICPSR_08443 "$ICPSRdir/ICPSR_08443"

* HS&B:80/86
global ICPSR_08896 "$ICPSRdir/ICPSR_08896"

* NLS:72
global ICPSR_08085 "$ICPSRdir/ICPSR_08085"
