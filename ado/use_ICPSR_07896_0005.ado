* Import ICPSR file 07896-0005

program define use_ICPSR_07896_0005

    if "$ICPSR_07896" == "" {
      display as error "Set global macro ICPSR_07896"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define TBB01F 1 "YES" 2 "NO"
    label define TBB02F 1 "YES" 2 "NO"
    label define TBB03F 0 "{MISSING}" 1 "YES" 2 "NO"
    label define TBB04F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB05F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB06F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB07F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB08F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB09F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"
    label define TBB10F 1 "YES" 2 "NO" 9 "{LEGITIMATE SKIP}"

    infile using "$dctdir/07896-0005.dct", using("$ICPSR_07896/DS0005/07896-0005-Data.txt")
    
    * Fix student IDs
    gen ID = int(SCHID)*100 + int(STUDNTID)
    label variable ID "HS&B:80 Student ID"
        
    label data ICPSR_07896_0005

end
