* Import ICPSR file 08085-0009

program define use_ICPSR_08085_0009

    if "$ICPSR_08085" == "" {
      display as error "Set global macro ICPSR_08085"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define COURSESF 1 "{1}" 2 "{2}" 3 "{3}" 4 "{4}" 5 "{5}" 6 "{6}" 7 "{7}" 8 "{8}" 9 "{9}" 10 "{10}" 11 "{11}" 12 "{12}" 13 "{13}" 14 "{14}" 15 "{15}" 16 "{16}" 17 "{17}" 18 "{18}" 19 "{19}" 20 "{20}" 21 "{21}" 22 "{22}" 23 "{23}" 24 "{24}" 25 "{25}" 26 "{26}" 27 "{27}" 28 "{28}" 29 "{29}" 30 "{30}" 31 "{31}" 32 "{32}" 33 "{33}" 34 "{34}" 35 "{35}" 36 "{36}" 37 "{37}" 38 "{38}" 39 "{39}" 40 "{40}" 43 "{43}" 44 "{44}" 45 "{45}" 46 "{46}" 50 "{50}" 51 "{51}"
    label define GRADCODF 1 "LETTER GRADES" 2 "NUMERIC GRADES"
    label define HIGHGRAF 1 "{1}" 4 "{4}" 5 "{5}" 100 "{100}" 800 "{800}" 999 "{MISSING}"
    label define LOWGRADF 0 "{0}" 200 "{200}" 999 "{MISSING}"
    label define PASSGRAF 1 "{1}" 2 "{2}" 4 "{4}" 55 "{55}" 60 "{60}" 65 "{65}" 70 "{70}" 74 "{74}" 75 "{75}" 80 "{80}" 200 "{200}" 400 "{400}" 999 "{MISSING}"
    label define SEASONF 1 "FALL" 2 "WINTER" 3 "SPRING" 4 "SUMMER" 9 "{MISSING}"
    label define SORTDATF 7200 "{7200}" 7299 "{7299}" 7300 "{7300}" 7399 "{7399}" 7400 "{7400}" 7499 "{7499}" 7500 "{7500}" 7599 "{7599}" 7600 "{7600}" 7699 "{7699}" 7700 "{7700}" 7799 "{7799}" 7800 "{7800}" 7801 "{7801}" 7899 "{7899}" 7900 "{7900}" 7999 "{7999}" 8000 "{8000}" 8099 "{8099}" 8100 "{8100}" 8199 "{8199}" 8200 "{8200}" 8299 "{8299}" 8399 "{8399}" 8499 "{8499}" 9900 "{9900}" 9999 "{MISSING}"
    label define TERMNUMF 1 "{1}" 2 "{2}" 3 "{3}" 4 "{4}" 5 "{5}" 6 "{6}" 7 "{7}" 8 "{8}" 9 "{9}" 10 "{10}" 11 "{11}" 12 "{12}" 13 "{13}" 14 "{14}" 15 "{15}" 16 "{16}" 17 "{17}" 18 "{18}" 19 "{19}" 20 "{20}" 21 "{21}" 22 "{22}" 23 "{23}" 24 "{24}" 25 "{25}" 26 "{26}" 27 "{27}" 28 "{28}" 29 "{29}" 30 "{30}" 31 "{31}" 32 "{32}" 33 "{33}" 34 "{34}" 35 "{35}"
    label define TERMTYPF 1 "VARIABLE LENGTH OR NONCOURSE TERM" 2 "SEMESTER" 3 "TRIMESTER" 4 "QUARTER" 5 "CREDIT BY EXAMINATION" 7 "{UNKNOWN}"
    label define TRANSFEF 0 "NOT TRANSFER" 1 "TRANSFER TERM"
    label define TRANSNUF 1 "{1}" 2 "{2}" 3 "{3}" 4 "{4}" 5 "{5}" 6 "{6}"

    infile using "$dctdir/08085-0009.dct", using("$ICPSR_08085/DS0009/08085-0009-Data.txt")
    
    label data ICPSR_08085_0009

end
