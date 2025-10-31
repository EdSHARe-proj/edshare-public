* Import ICPSR file 08297-0011, Course Records (Type 2)

program define use_ICPSR_08297_0011_course

    if "$ICPSR_08297" == "" {
      display as error "Set global macro ICPSR_08297"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define PGMF 0 "NOT CODED" 1 "SPECIAL EDUCATION" 2 "BILINGUAL EDUCATION" 3 "GIFTED EDUCATION" 4 "SPECIAL ED & BILINGL"
    label define SEM1F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define SEM2F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define TRI1F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define TRI2F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define TRI3F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define QUARTR1F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define QUARTR2F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define QUARTR3F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define QUARTR4F 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"
    label define FULLYRF 0 "NOT OFFERED" 1 "OFFERED" 8 "{MISSING}"

    infile using "$dctdir/08297-0011-2.dct" if RECTYPE == 2, using("$ICPSR_08297/DS0011/08297-0011-Data.txt")
    
    label data ICPSR_08297_0011_course

end
