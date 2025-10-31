* Import ICPSR file 07896-0006

program define use_ICPSR_07896_0006

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
    label define TYB11AF 1 "YES"
    label define TYB11BF 1 "YES"
    label define TYB11CF 1 "YES"
    label define TYB11DF 1 "YES"
    label define TYB11EF 1 "YES"
    label define TYB11FF 1 "YES"
    label define TYB11GF 1 "YES"
    label define TYB11HF 1 "YES"
    label define TYB11IF 1 "YES"
    label define TYB11JF 1 "YES"
    label define TYB11KF 1 "YES"
    label define TYB11LF 1 "YES"
    label define TYB11MF 1 "YES"
    label define TYB12AF 1 "ALMOST NONE" 2 "ABOUT 5%" 3 "ABOUT 10%" 4 "ABOUT 20%" 5 "30% OR MORE"
    label define TYB12BF 1 "ALMOST NONE" 2 "ABOUT 5%" 3 "ABOUT 10%" 4 "ABOUT 20%" 5 "30% OR MORE"
    label define TYB13F 1 "FEMALE" 2 "MALE"
    label define TYB14F 1 "AMER INDIAN" 2 "ASIAN" 3 "MEXICAN" 4 "CUBAN" 5 "PUERTO RICAN" 6 "OTHER LATIN" 7 "BLACK" 8 "WHITE"

    infile using "$dctdir/07896-0006.dct", using("$ICPSR_07896/DS0006/07896-0006-Data.txt")
    
    * Fix student IDs
    gen ID = int(SCHID)*100 + int(STUDNTID)
    label variable ID "HS&B:80 Student ID"
        
    label data ICPSR_07896_0006

end
