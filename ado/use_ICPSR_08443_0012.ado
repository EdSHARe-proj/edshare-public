* Import ICPSR file 08443-0012

program define use_ICPSR_08443_0012

    if "$ICPSR_08443" == "" {
      display as error "Set global macro ICPSR_08443"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define TRANSFEF 0 "NO" 1 "YES"
    label define TERMTYPF 1 "VAR OR NONCOURSE" 2 "SEMESTER" 3 "TRIMESTER" 4 "QUARTER" 5 "TEST" 7 "UNDATED" 9 "{UNKNOWN}"
    label define STARTMOF 1 "JANUARY" 2 "FEBRUARY" 3 "MARCH" 4 "APRIL" 5 "MAY" 6 "JUNE" 7 "JULY" 8 "AUGUST" 9 "SEPTEMBER" 10 "OCTOBER" 11 "NOVEMBER" 12 "DECEMBER" 99 "{MISSING}"
    label define STARTYRF 78 "1978" 79 "1979" 80 "1980" 81 "1981" 82 "1982" 83 "1983" 84 "1984" 99 "{MISSING}"
    label define ENDMONF 1 "JANUARY" 2 "FEBRUARY" 3 "MARCH" 4 "APRIL" 5 "MAY" 6 "JUNE" 7 "JULY" 8 "AUGUST" 9 "SEPTEMBER" 10 "OCTOBER" 11 "NOVEMBER" 12 "DECEMBER" 99 "{MISSING}"
    label define ENDYRF 78 "1978" 79 "1979" 80 "1980" 81 "1981" 82 "1982" 83 "1983" 84 "1984" 99 "{MISSING}"
    label define SEASONF 1 "FALL" 2 "WINTER" 3 "SPRING" 4 "SUMMER" 9 "{MISSING}"
    label define GRADCODF 1 "LETTER" 2 "NUMERIC" 9 "{MISSING}"

    infile using "$dctdir/08443-0012.dct", using("$ICPSR_08443/DS0012/08443-0012-Data.txt")
    
    * Drop empty rows
    drop if missing(STUID)
    
    label data ICPSR_08443_0012

end
