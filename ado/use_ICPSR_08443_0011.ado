* Import ICPSR file 08443-0011

program define use_ICPSR_08443_0011

    if "$ICPSR_08443" == "" {
      display as error "Set global macro ICPSR_08443"
      error 601
    }
    if "$dctdir" == "" {
      display as error "Set global macro dctdir"
      error 601
    }
    
    clear
    
    label define TRNSFLAF 0 "NO" 1 "YES"
    label define TRNSFERF 0 "NO" 1 "YES" 9 "{MISSING}"
    label define FINDISPF 1 "RECEIVED" 2 "SCHOOL REFUSED" 3 "DIDN^T ATND-NO SCHL" 4 "LOST-DESTROYED" 5 "SCHL CLOSED-UNDELIV" 6 "NO RESPONSE"
    label define PSREGIOF 1 "NORTHEAST" 2 "NORTHCENTRAL" 3 "SOUTH" 4 "WEST" 5 "FOREIGN"
    label define INSTYPEF 1 "VOCATIONAL" 2 "PRIV,NON-VOC" 3 "PUB,ACA 4-YEAR" 4 "PUB,ACA 2-YEAR" 5 "FOREIGN" 8 "{UNCLASSIFIED}"
    label define DEGREE1F 1 "ASSOCIATE" 2 "BACHELORS" 3 "MASTERS" 4 "PH.D" 5 "LICENSE" 6 "CERTIFICATE" 7 "NO DEGREE" 9 "{MISSING}"
    label define HONORS1F 0 "NO" 1 "YES" 9 "{MISSING}"
    label define DEGMON1F 1 "JANUARY" 2 "FEBRUARY" 3 "MARCH" 4 "APRIL" 5 "MAY" 6 "JUNE" 7 "JULY" 8 "AUGUST" 9 "SEPTEMBER" 10 "OCTOBER" 11 "NOVEMBER" 12 "DECEMBER" 99 "{MISSING}"
    label define DEGYR1F 80 "1980" 81 "1981" 82 "1982" 83 "1983" 84 "1984" 99 "{MISSING}"
    label define DEGREE2F 1 "ASSOCIATE" 2 "BACHELORS" 3 "MASTERS" 6 "CERTIFICATE" 7 "{NO DEGREE}" 9 "{MISSING}"
    label define HONORS2F 0 "NO" 1 "YES" 9 "{MISSING}"
    label define DEGMON2F 1 "JANUARY" 2 "FEBRUARY" 4 "APRIL" 5 "MAY" 6 "JUNE" 7 "JULY" 8 "AUGUST" 10 "OCTOBER" 12 "DECEMBER" 99 "{MISSING}"
    label define DEGYR2F 82 "1982" 83 "1983" 84 "1984" 99 "{MISSING}"
    label define DEGREE3F 2 "BACHELORS" 6 "CERTIFICATE" 9 "{MISSING}"
    label define HONORS3F 1 "YES" 9 "{MISSING}"
    label define DEGMON3F 6 "JUNE" 10 "OCTOBER" 99 "{MISSING}"
    label define DEGYR3F 83 "1983" 99 "{MISSING}"

    infile using "$dctdir/08443-0011.dct", using("$ICPSR_08443/DS0011/08443-0011-Data.txt")
    
    * Remove empty lines at end of file
    drop if missing(ID)
    
    label data ICPSR_08443_0011

end
