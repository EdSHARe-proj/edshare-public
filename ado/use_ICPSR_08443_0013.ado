* Import ICPSR file 08443-0013

program define use_ICPSR_08443_0013

    if "$ICPSR_08443" == "" {
      display as error "Set global macro ICPSR_08443"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define GRADTYPF 1 "LETTER" 2 "NUMERIC" 9 "{MISSING}"

    infile using "$dctdir/08443-0013.dct", using("$ICPSR_08443/DS0013/08443-0013-Data.txt")
    
    * Drop empty rows
    drop if missing(STUID)
    
    label data ICPSR_08443_0013

end
