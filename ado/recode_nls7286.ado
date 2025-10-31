* recode_nls7286: Recode NLS:72 student data to enforce skip logic

program define recode_nls7286

    *Level 1 routing item
    _recode_nls7286_routing SRFQ9 // internal item is SRFQ10, which is completely missing.

    *Update values for routing items: certain values (20, 40, and 60) were added to the routing item when there is an inconsistency in the item contained within the routing pattern. 
    _recode_nls7286_routing BQ31

    **Section D
    local route "BQ31"
    local internal "BQ32 BQ33 BQ34 BQ35 BQ36"
    _recode_nls7286_skip `route' `"`internal'"' 1

    _recode_nls7286_routing BQ36

    local route "BQ36"
    local internal "BQ37A BQ37B BQ37C BQ37D BQ37E BQ37F BQ37G BQ37H BQ37I BQ37J BQ37K BQ37L BQ37M BQ37N BQ37O"
    _recode_nls7286_skip `route' `"`internal'"' 1

    **Section E (BQ31=2)
    local route "BQ31"
    local internal "BQ38 BQ39 BQ40 BQ41"
    _recode_nls7286_skip `route' `"`internal'"' 2

    _recode_nls7286_routing BQ41

    local route "BQ41"
    local internal "BQ42A BQ42B BQ42C BQ42D BQ42E BQ42F BQ42G BQ42H BQ42I BQ42J BQ42K BQ42L BQ42M BQ42N BQ42O"
    _recode_nls7286_skip `route' `"`internal'"' 1

    **Section F (BQ31=3)
    local route "BQ31"
    local internal "BQ43 BQ44 BQ45 BQ46A BQ46B BQ46C BQ46D BQ46E BQ46F BQ46G BQ46H BQ46I BQ46J BQ46K BQ46L BQ46M BQ46N BQ46O BQ46P BQ46Q BQ47 BQ48A BQ48B BQ48C BQ48D BQ48E BQ48F BQ48G BQ48H BQ48I BQ49A BQ49B BQ49C BQ49D BQ49E BQ49F BQ49G BQ49H BQ49I BQ49J BQ49K BQ49L BQ49M BQ49N BQ49O"
    _recode_nls7286_skip `route' `"`internal'"' 3

    **Section G (BQ31=4)
    local route "BQ31"
    local internal "BQ50 BQ51 BQ52A BQ52B BQ52C BQ52D BQ52E BQ52F BQ53"
    _recode_nls7286_skip `route' `"`internal'"' 4

    _recode_nls7286_routing BQ53

    local route "BQ53"
    local internal "BQ54A BQ54B BQ54C BQ54D BQ54E BQ54F BQ54G BQ54H BQ54I BQ54J BQ54K BQ54L BQ54M BQ54N"
    _recode_nls7286_skip `route' `"`internal'"' 1

    **Section H (BQ31=5)
    local internal "BQ55 BQ56 BQ57 BQ58 BQ59 BQ60 BQ61 BQ62A BQ62B BQ62C BQ62D BQ62E BQ62F BQ62G BQ62H BQ62I BQ62J BQ62K BQ62L BQ62M BQ63"
    local condition "BQ31 == 5 | BQ36 == 2 | BQ36 == 3 | BQ41 == 2 | BQ41 == 3 | BQ53 == 2 | BQ53 == 3"
    _recode_nls7286_skip_cond `"`internal'"' `"`condition'"'

    _recode_nls7286_routing BQ63

    local route "BQ63"
    local internal "BQ64A BQ64B BQ64C BQ64D BQ64E BQ64F BQ64G BQ64H BQ64I BQ64J BQ64K BQ64L BQ64M BQ64N BQ64O"
    _recode_nls7286_skip `route' `"`internal'"' 1

    **Section I (BQ31=6,7,8)
    local internal "BQ65 BQ66 BQ67 BQ68A BQ68B BQ68C BQ68D BQ68E BQ68F BQ68G BQ68H BQ68I BQ68J BQ68K BQ68L BQ68M BQ69A BQ69B BQ70 BQ71 BQ72 BQ73 BQ74A BQ74B BQ74C BQ74D BQ74E BQ74F BQ74G BQ74H BQ74I BQ74J BQ74K BQ74L BQ74M BQ74N BQ75 BQ76"
    local condition "BQ31 == 6 | BQ31 == 7 | BQ31 == 8 | BQ31 == 11 | BQ36 == 4 | BQ36 == 5 | BQ41 == 4 | BQ41 == 5 | BQ53 == 4 | BQ53 == 5"
    _recode_nls7286_skip_cond `"`internal'"' `"`condition'"'

    **Section J (BQ31=9, BQ63=2)

    local internal "BQ77 BQ78 BQ79 BQ80A BQ80B BQ80C BQ80D BQ80E BQ80F BQ80G BQ80H BQ80I BQ80J BQ80K BQ80L BQ80M BQ80N BQ80O"
    local condition "BQ31 == 9 | BQ63 == 2"
    _recode_nls7286_skip_cond `"`internal'"' `"`condition'"'

    **********************************************
    ** First Follow Up (FQ)
    **********************************************

    **********************************************
    **Section A - General information
    **********************************************
    *Update values for routing item: certain values (20, 40, and 60) were added to the routing item when there is an inconsistency in the item contained within the routing pattern. 
    *Level 1 routing item
    _recode_nls7286_routing FQ2

    *Routing (FQ2) Internal (FQ3A FA3B)
    local route "FQ2"
    local internal "FQ3A FQ3B"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4
    quietly replace FQ3A = 94 if inrange(FQ3A, 15, 36) // seems to be entry errors, out of range. These respondents reported in FQ2 that they graduated. Not clear whether (if then why) 10 was added. 

    *Level 1 routing item
    _recode_nls7286_routing FQ7A

    *Routing (FQ7A) Internal (FQ7B FQ7C FQ8A FQ8B)
    local route "FQ7A"
    local internal "FQ7B FQ7C FQ8A"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 4
    quietly replace FQ7B = 95 if inrange(FQ7B, 19, 19) // seems to be entry errors, out of range. These respondents reported in FQ7A that separated, divorced, or widowed. Not clear whether (if then why) 10 was added to 9.
    quietly replace FQ7C = 66 if inrange(FQ7C, 10, 10) // label as 66
    quietly replace FQ8A = 99 if inrange(FQ8A, 3, 3) // seems to be entry errors. Code 3 (pregnant) is not an option. 
                    
    *Level 2 routing item
    _recode_nls7286_routing FQ8A
                    
    *Routing (FQ8A=2) Internal (FQ8B)
    local route "FQ8A"
    local internal "FQ8B"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    *Level 1 routing item
    _recode_nls7286_routing FQ13B
            
    *Routing (FQ13B) Internal (FQ13C)	
    local route "FQ13B"
    local internal "FQ13C"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    **********************************************
    **Section B - Education and Training
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FQ21

    *Routing (FQ21) Internal (FQ22A-E)
    local route "FQ21"
    local internal "FQ22AA FQ22AB FQ22AC FQ22AD FQ22AE FQ22AF FQ22AG FQ22AH FQ22AI FQ22C FQ22D FQ22E"
    _recode_nls7286_skip `route' `"`internal'"' 2
    local route "FQ21"
    local internal "FQ22B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FQ23	

    *Routing (FQ23:2, attend any, No ) Internal (FQ24A-FQ24Q)
    local route "FQ23"
    local internal "FQ24A FQ24B FQ24C FQ24D FQ24E FQ24F FQ24G FQ24H FQ24I FQ24J FQ24K FQ24L FQ24M FQ24N FQ24O FQ24P FQ24Q"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Routing (FQ23:1, attend any, Yes) Internal (FQ25:1, not attend in 1973)
    local route "FQ23"
    local internal "FQ25"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing FQ25
            
    *Routing (FQ23:1, attend any, Yes; FQ25:2, attend in 1973) Internal (FQ26AA-28BC)
    // keep institution and city names as they are. 

    local route "FQ25"
    local internal "FQ26AC FQ26B FQ26C FQ27AA FQ27AB FQ27B FQ27C FQ27D FQ28B"
    _recode_nls7286_skip `route' `"`internal'"' 2
    quietly replace FQ26AC = 95 if FQ26AC == 0
            
    local route "FQ25"
    local internal "FQ26AA FQ28A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FQ28B
            
    local route "FQ28B"
    local internal "FQ28C"
    local condition "inrange(`route', 1, 8) | inrange(`route', 10, 15)"
    _recode_nls7286_skip_cond `"`internal'"' `"`condition'"'
            
    *Routing (FQ23:1, attend any, Yes) Internal (FQ29A)
    local route "FQ23"
    local internal "FQ29A"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing FQ29A
            
    *Routing (FQ23:1, attend any, Yes; FQ29A:2, not attend in 1972) Internal (FQ29BA-FQ29BR)
    local route "FQ29A"
    local internal "FQ29BA FQ29BB FQ29BC FQ29BD FQ29BE FQ29BF FQ29BG FQ29BH FQ29BI FQ29BJ FQ29BK FQ29BL FQ29BM FQ29BN FQ29BO FQ29BP FQ29BQ FQ29BR"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    *Routing (FQ23:1, attend any, Yes; FQ29A:, attend in 1972) Internal (FQ30-FQ38K)
    local route "FQ29A"
    local internal "FQ30"
    _recode_nls7286_skip `route' `"`internal'"' 1
            
    *Level 3 routing item
    _recode_nls7286_routing FQ30

    local route "FQ30"
    local internal "FQ31A FQ31B FQ31C FQ31D FQ31E FQ31F FQ31G FQ31H FQ31I FQ31J FQ31K"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FQ30"
    local internal "FQ32AA"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 3

    local route "FQ30"
    local internal "FQ32AC FQ32B FQ32C FQ33AA FQ33AB"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3
                    
    local route "FQ29A"
    local internal "FQ33B FQ33C FQ34"
    _recode_nls7286_skip `route' `"`internal'"' 1
            
    *Level 3 routing item
    _recode_nls7286_routing FQ34
            
    local route "FQ34"
    local internal "FQ35A FQ35B FQ35C FQ35D FQ35E FQ35F FQ35G FQ35H FQ35I"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FQ34"
    local internal "FQ36A" 
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 4

    local route "FQ34"
    local internal "FQ36B"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4
                    
    *Level 4 routing item
    _recode_nls7286_routing FQ36B
            
    local route "FQ36B"
    local internal "FQ36C"
    local condition "inrange(`route', 1, 8) | inrange(`route', 10, 15)"
    _recode_nls7286_skip_cond `"`internal'"' `"`condition'"'
            
    local route "FQ34"
    local internal "FQ37"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4
            
    *Level 4 routing item
    _recode_nls7286_routing FQ37

    local route "FQ37"
    local internal "FQ38A FQ38B FQ38C FQ38D FQ38E FQ38F FQ38G FQ38H FQ38I FQ38J FQ38K"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FQ23"
    local internal "FQ39"
    _recode_nls7286_skip `route' `"`internal'"' 1
            
    *Level 4 routing item
    _recode_nls7286_routing FQ39

    local route "FQ39"
    local internal "FQ40AA"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FQ39"
    local internal " FQ40AC FQ40B FQ40CA FQ40CB FQ40DA"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    *Level 3 routing item
    _recode_nls7286_routing FQ40DA
            
    local route "FQ40DA"
    local internal "FQ40DB FQ40DC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FQ23"
    local internal "FQ41A FQ41B"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 3 routing item
    _recode_nls7286_routing FQ41B
            
    local route "FQ41B"
    local internal "FQ41CA FQ41CC" 
    _recode_nls7286_skip_93 `route' `"`internal'"' 3
    quietly replace FQ41CC = 998 if missing(FQ41CC)
                    
    local route "FQ41B"
    local internal "FQ41CB" 
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FQ23"
    local internal "FQ42 FQ43A"
    _recode_nls7286_skip `route' `"`internal'"' 1
            
    *Level 3 routing item
    _recode_nls7286_routing FQ43A
            
    local route "FQ43A"
    local internal "FQ43B" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FQ23"
    local internal "FQ44A"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 3 routing item
    _recode_nls7286_routing FQ44A

    local route "FQ44A"
    local internal "FQ44BE"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FQ44A"
    local internal "FQ44BB FQ44BC FQ44BD FQ44BG" 
    _recode_nls7286_skip `route' `"`internal'"' 3
            
    local route "FQ23"
    local internal "FQ45A FQ45B FQ45C FQ45D FQ45E FQ46AB FQ47AA FQ47BA FQ47CA FQ47DA FQ47EA FQ47FA FQ47GA FQ48A"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FQ23"
    local internal "FQ46AA FQ46BA FQ46BB FQ46BC FQ46BD FQ46BE FQ46BF FQ46BG FQ47AB FQ47BB FQ47CB FQ47DB FQ47EB FQ47FB FQ47GB"
    _recode_nls7286_skip_94 `route' `"`internal'"' 1
    quietly replace FQ46BG = 9998 if missing(FQ46BG)

    *Level 2 routing item
    _recode_nls7286_routing FQ48A
            
    local route "FQ48A"
    local internal "FQ48BA FQ48BB FQ48BC FQ48BD FQ48BE FQ48BF FQ48BG FQ48BH FQ48BI FQ48BJ FQ48BK FQ48BL FQ48BM FQ48BN FQ48C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FQ48A"
    local internal " FQ49E FQ49FA FQ49FB FQ49G FQ50A FQ51A FQ51B FQ51C FQ51D FQ51E FQ51F FQ51G FQ51H FQ52A FQ52B FQ53"
    _recode_nls7286_skip `route' `"`internal'"' 1
    quietly replace FQ49FA = 95 if FQ49FA == 72 // month, out of range
    quietly replace FQ49FB = 95 if inrange(FQ49FB, 1, 23) // starting year, out of range
    quietly replace FQ53 = 95 if FQ53 == 3 // out of range

    local route "FQ48A"
    local internal "FQ49A"
    _recode_nls7286_skip_93 `route' `"`internal'"' 1

    local route "FQ48A"
    local internal "FQ50B"
    _recode_nls7286_skip_94 `route' `"`internal'"' 1

    *Level 1 routing item
    _recode_nls7286_routing FQ54A
            
    local route "FQ54A"
    local internal "FQ54BA FQ54BB FQ54BC FQ54BD FQ54BE FQ54BF FQ54BG FQ54BH FQ54BI FQ54BJ FQ54BK FQ54BL FQ54BM FQ54BN FQ54C"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FQ54A"
    local internal "FQ55A"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FQ54A"
    local internal "FQ55E FQ55FA FQ55FB FQ55GA"
    _recode_nls7286_skip `route' `"`internal'"' 2
    quietly replace FQ55FA = 95 if FQ55FA == 0 | FQ55FA == 72 // month, out of range
    quietly replace FQ55FB = 95 if inrange(FQ55FB, 1, 23) // starting year, out of range

    *Level 2 routing item
    _recode_nls7286_routing FQ55GA
     
    local route "FQ55GA"
    local internal "FQ55GB FQ55GC" 
    _recode_nls7286_skip `route' `"`internal'"' 2
    quietly replace FQ55GB = 95 if inrange(FQ55GB, 20, 73) // month, out of range
    quietly replace FQ55GC = 95 if inrange(FQ55GC, 1, 20) // starting year, out of range
     
    local route "FQ54A"
    local internal "FQ56A FQ57" 
    _recode_nls7286_skip_r `route' `"`internal'"' 1 2

    local route "FQ54A"
    local internal "FQ56B"
    _recode_nls7286_skip_r94 `route' `"`internal'"' 1 2

    *Level 2 routing item
    _recode_nls7286_routing FQ60A
            
    local route "FQ60A"
    local internal "FQ60B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FQ60A"
    local internal "FQ61"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FQ61

    local route "FQ61"
    local internal "FQ62A FQ62B FQ62C FQ62D FQ62E FQ62F FQ62G FQ62H FQ62I FQ62J FQ62K FQ62L"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FQ61"
    local internal "FQ63A FQ63B FQ63C FQ63D FQ63E FQ63F FQ63G FQ63H"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    **********************************************
    **Section D - Military Service
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FQ64

    local route "FQ64"
    local internal "FQ65 FQ66A"
    _recode_nls7286_skip `route' `"`internal'"' 3
            
    *Level 2 routing item
    _recode_nls7286_routing FQ66A

    local route "FQ66A"
    local internal "FQ66B FQ66C"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    local route "FQ66A"
    local internal "FQ66D FQ66E"
    _recode_nls7286_skip `route' `"`internal'"' 3
            
    local route "FQ66A"
    local internal "FQ67A FQ67B FQ68"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3
    quietly replace FQ67B = 95 if inrange(FQ67B, 0, 2) // starting year, out of range

    *Level 3 routing item
    _recode_nls7286_routing FQ68

    local route "FQ68"
    local internal "FQ69A" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FQ66A"
    local internal "FQ70A FQ71A FQ71B FQ71C"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    local route "FQ64"
    local internal "FQ72 FQ73A FQ73B FQ73C FQ73D FQ73E FQ73F FQ73G FQ73H FQ74A"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing FQ74A
            
    local route "FQ74A"
    local internal "FQ74B FQ74C"
    _recode_nls7286_skip `route' `"`internal'"' 1
    quietly replace FQ74B = 95 if FQ74B == 74 // out of range, month

    local route "FQ74A"
    local internal "FQ75 FQ76A FQ76B FQ76C FQ76D FQ76E FQ76F FQ76G"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section E - Information About the Past
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FQ81

    local route "FQ81"
    local internal "FQ82AA"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FQ81"
    local internal "FQ82AC FQ82B FQ82C" 
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    *Level 2 routing item
    _recode_nls7286_routing FQ82C
                    
    local route "FQ82C"
    local internal "FQ82DA FQ82DB FQ82DC"
    _recode_nls7286_skip_94 `route' `"`internal'"' 3
            
    local route "FQ81"
    local internal "FQ83AA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FQ83AA
                    
    local route "FQ83AA"
    local internal "FQ83AB" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FQ83AA"
    local internal "FQ83AD FQ83B FQ83C" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FQ83C

    local route "FQ83C"
    local internal "FQ83DA FQ83DB FQ83DC"
    _recode_nls7286_skip_94 `route' `"`internal'"' 3

    local route "FQ83AA"
    local internal "FQ84AA"
    _recode_nls7286_skip `route' `"`internal'"' 2
            
    *Level 3 routing item
    _recode_nls7286_routing FQ84AA

    local route "FQ84AA"
    local internal "FQ84AB" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FQ84AA"
    local internal "FQ84AD FQ84B FQ84C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 4 routing item
    _recode_nls7286_routing FQ84C

    local route "FQ84C"
    local internal "FQ84DA FQ84DB FQ84DC"
    _recode_nls7286_skip_94 `route' `"`internal'"' 3

    **********************************************
    ** Second Follow Up (SQ)
    **********************************************


    **********************************************
    **Section A - General information
    **********************************************
    *Update values for routing item: certain values (20, 40, and 60) were added to the routing item when there is an inconsistency in the item contained within the routing pattern. 
    *Level 1 routing item
    _recode_nls7286_routing SQ5

    local route "SQ5"
    local internal "SQ6 SQ7"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ9

    local route "SQ9"
    local internal "SQ10"
    _recode_nls7286_skip `route' `internal' 2
            
    *Level 2 routing item
    _recode_nls7286_routing SQ10

    local route "SQ10"
    local internal " SQ11B SQ12 SQ13 SQ14A SQ14B SQ15A SQ16 SQ18 SQ21 SQ23A SQ23BA" // 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ10"
    local internal " SQ17" 
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ15A

    local route "SQ15A"
    local internal "SQ15B SQ15C" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ10"
    local internal "SQ11A SQ19 " 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ10"
    local internal "SQ20A SQ22" 
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ20A

    local route "SQ20A"
    local internal "SQ20B" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 14

    *Level 3 routing item
    _recode_nls7286_routing SQ23BA
    quietly replace SQ23BA = 98 if SQ23BA == 8 // out of range, answer can be 1-7

    local route "SQ23BA"
    local internal "SQ23BB"
    _recode_nls7286_skip_96 `route' `internal' 2

    local route "SQ23BA"
    local internal "SQ23BC"
    _recode_nls7286_skip `route' `internal' 2
            
    local route "SQ10"
    local internal "SQ23CA SQ23DA SQ23EA SQ23FA SQ23GA"
    foreach item in `internal'{
            quietly replace `item' = 98 if `item' == 28 // out of range, answer can be 1-7
    }	
    _recode_nls7286_skip `route' `"`internal'"' 2
    //Level 3 routing item
    _recode_nls7286_routing `internal'
            
    local route "SQ23CA"
    local internal "SQ23CB"
    _recode_nls7286_skip_96 `route' `internal' 3
        
    local route "SQ23CA"
    local internal "SQ23CC"
    _recode_nls7286_skip `route' `internal' 3
                    
    local route "SQ23DA"
    local internal "SQ23DB"
    _recode_nls7286_skip `route' `internal' 4

    local route "SQ23EA"
    local internal "SQ23EB"
    _recode_nls7286_skip `route' `internal' 5

    local route "SQ23FA"
    local internal "SQ23FB"
    _recode_nls7286_skip `route' `internal' 6

    local route "SQ23GA"
    local internal "SQ23GB"
    _recode_nls7286_skip_96 `route' `internal' 7	

    local route "SQ23GA"
    local internal "SQ23GC"
    _recode_nls7286_skip `route' `internal' 7

    local route "SQ10"
    local internal "SQ24"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ24

    local route "SQ24"
    local internal "SQ25A SQ25B SQ25C SQ25D SQ25E SQ25F SQ25G SQ25H SQ25I SQ25J" 
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "SQ24"
    local internal "SQ26" 
    _recode_nls7286_skip_l `route' `"`internal'"' 1 2 4 

    *Level 4 routing item
    _recode_nls7286_routing SQ26

    local route "SQ26"
    local internal "SQ27A SQ27B SQ27C SQ27D SQ27E SQ27F SQ27G SQ27H SQ27I SQ27J SQ27K SQ27L SQ27M SQ27N SQ27O SQ27P SQ27Q SQ27R SQ27S SQ27T SQ27U" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ10"
    local internal "SQ28"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ28

    local route "SQ28"
    local internal "SQ29"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ28"
    local internal "SQ30 SQ31"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ9"
    local internal "SQ32"
    _recode_nls7286_skip `route' `internal' 2

    *Level 2 routing item
    _recode_nls7286_routing SQ32

    local route "SQ32"
    local internal "SQ33A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ32"
    local internal "SQ33B SQ34 SQ35AA SQ35AB SQ35BA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ35BA

    local route "SQ35BA"
    local internal "SQ35BB SQ35BC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ32"
    local internal "SQ36"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ36

    local route "SQ36"
    local internal "SQ37A SQ37B SQ37C SQ37D SQ37E SQ37F SQ37G SQ37H SQ37I SQ37J"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4

    local route "SQ9"
    local internal "SQ38A SQ38B SQ38C SQ38D SQ38E SQ38F SQ38G SQ38H SQ38I SQ40 SQ41"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ9"
    local internal "SQ39"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing SQ41

    local route "SQ41"
    local internal "SQ42A SQ42B SQ42C"
    _recode_nls7286_skip_94 `route' `"`internal'"' 3

    local route "SQ41"
    local internal "SQ43A SQ43B SQ43C SQ43D SQ43E SQ43F SQ43G SQ43H SQ43I SQ43J"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "SQ9"
    local internal "SQ44BX"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing SQ44BX
    quietly replace SQ44BX = 98 if SQ44BX == 8 // out of range for this box item, original value 48, maybe a fluke?
    *quietly replace SQ44BX = 99 if SQ44BX == 1 // none should mark this box (11122024) actually we cannot verify these people, who could have been in school during Sep/Oct 1974 but not in school fall 1973 - summer 1974.
            
    local route "SQ44BX"
    local internal "SQ44A SQ44B SQ44C SQ44D SQ44E"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ44FA"
    _recode_nls7286_skip_94 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ44FB SQ44FC"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ45"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ46"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ46

    local route "SQ46"
    local internal "SQ47A SQ47B SQ47C SQ47D SQ47E SQ47F SQ47G SQ47H SQ47I SQ47J SQ47K SQ47L SQ47M SQ47N SQ47O SQ47P"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ46"
    local internal "SQ48"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ49"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ49

    local route "SQ49"
    local internal "SQ50A SQ50B SQ50C SQ50D SQ50E SQ50F SQ50G SQ50H SQ50I SQ50J"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ49"
    local internal "SQ51"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ52"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ52

    local route "SQ52"
    local internal "SQ53A SQ53B SQ53C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ52"
    local internal "SQ54"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "SQ44BX"
    local internal "SQ55"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing SQ55

    local route "SQ55"
    local internal "SQ56A SQ56B SQ56C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ55"
    local internal "SQ57"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ58

    local route "SQ58"
    local internal "SQ59A SQ59B SQ59C SQ59D SQ59E SQ59F SQ59G SQ59H SQ59I SQ59J SQ59K SQ59L SQ59M SQ60"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ60

    local route "SQ60"
    local internal "SQ61"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ58"
    local internal "SQ62"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ58"
    local internal "SQ63 SQ64 SQ65"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ66BA
    quietly replace SQ66BA = 98 if SQ66BA == 8 // out of range

    local route "SQ66BA"
    local internal "SQ66BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ66CA
    quietly replace SQ66CA = 98 if SQ66CA == 8 // out of range

    local route "SQ66CA"
    local internal "SQ66CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing SQ66GA
    quietly replace SQ66GA = 98 if SQ66GA == 8 // out of range

    local route "SQ66GA"
    local internal "SQ66GB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 7

    *Level 1 routing item
    _recode_nls7286_routing SQ67

    local route "SQ67"
    local internal "SQ68"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing SQ68

    local route "SQ68"
    local internal "SQ69A SQ69B SQ69C SQ69D SQ69E"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ67"
    local internal "SQ70 SQ71"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing SQ71

    local route "SQ71"
    local internal "SQ72"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 4 

    local route "SQ71"
    local internal "SQ73"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4 

    **********************************************
    **Section C - Work Experience
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing SQ74

    local route "SQ74"
    local internal "SQ75"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing SQ75

    local route "SQ75"
    local internal "SQ76A"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3 

    local route "SQ75"
    local internal "SQ76E SQ76FA SQ76FB SQ76GA"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3 

    *Level 3 routing item
    _recode_nls7286_routing SQ76GA

    local route "SQ76GA"
    local internal "SQ76GB SQ76GC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ75"
    local internal "SQ77"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3 

    local route "SQ75"
    local internal "SQ78"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 2 3 

    local route "SQ75"
    local internal "SQ79A SQ79B SQ79C SQ79D SQ79E SQ79F SQ79G SQ79H SQ79I SQ79J SQ79K SQ80"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3 

    *Level 3 routing item
    _recode_nls7286_routing SQ80

    local route "SQ80"
    local internal "SQ81A SQ81B SQ81C SQ81D SQ81E SQ81F SQ82A SQ82B SQ82C SQ82D SQ82E SQ82F SQ82G SQ82H SQ82I SQ83 SQ84"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ75"
    local internal "SQ85"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3 

    *Level 3 routing item
    _recode_nls7286_routing SQ85

    local route "SQ85"
    local internal "SQ86 SQ87"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ75"
    local internal "SQ88"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3 

    *Level 3 routing item
    _recode_nls7286_routing SQ88

    local route "SQ88"
    local internal "SQ89"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ88"
    local internal "SQ90"
    _recode_nls7286_skip_94 `route' `"`internal'"' 2

    local route "SQ88"
    local internal "SQ91ABX"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 4 routing item
    _recode_nls7286_routing SQ91ABX
    quietly replace SQ91ABX = 98 if SQ91ABX == 8 // out of range for this box item, original value 48, maybe a fluke?

    local route "SQ91ABX"
    local internal "SQ91AA SQ91AB SQ91AC SQ91AD SQ91AE SQ91AF SQ91AG SQ91AH SQ91AI SQ91AJ SQ91AK SQ91AL SQ91AM SQ91AN SQ91AO SQ91B"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Level 5 routing item
    _recode_nls7286_routing SQ91B

    local route "SQ91B"
    local internal "SQ92"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 4 

    *Level 5 routing item
    _recode_nls7286_routing SQ92

    local route "SQ92"
    local internal "SQ93C SQ94"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ92"
    local internal "SQ95"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "SQ92"
    local internal "SQ93EA SQ93EB SQ93FA SQ93FB SQ96A SQ96B SQ96C SQ96D SQ96E SQ96F SQ96G SQ96H SQ96I SQ96J SQ96K SQ96L SQ96M SQ96N SQ96O SQ96P"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "SQ91B"
    local internal "SQ97 SQ98 SQ99"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 3 4 

    local route "SQ91B"
    local internal "SQ100A"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 4 

    *Level 1 routing item
    _recode_nls7286_routing SQ100B

    local route "SQ100B"
    local internal "SQ101"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing SQ103

    local route "SQ103"
    local internal "SQ104A SQ104B SQ104C SQ104D SQ104E SQ104F SQ104G SQ104H SQ104I SQ104J SQ104K SQ104L"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section D - Family Status
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing SQ105

    local route "SQ105"
    local internal "SQ106A SQ106B SQ107A SQ107B SQ107C SQ107D SQ107E SQ107F SQ107G SQ108BX"
    _recode_nls7286_skip `route' `"`internal'"' 4

    *Level 2 routing item
    _recode_nls7286_routing SQ108BX
    quietly replace SQ108BX = 98 if SQ108BX == 8 // out of range for this box item, original value 48, maybe a fluke?
            
    local route "SQ108BX"
    local internal "SQ108C"
    _recode_nls7286_skip_n93 `route' `"`internal'"' 1

    local route "SQ105"
    local internal "SQ109"
    _recode_nls7286_skip_93 `route' `"`internal'"' 4


    **********************************************
    **Section E - Military Service
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing SQ121

    local route "SQ121"
    local internal "SQ122 SQ123A SQ123B SQ124 "
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing SQ124

    local route "SQ124"
    local internal "SQ125"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ121"
    local internal "SQ126A SQ127A SQ127B SQ127C SQ128A"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "SQ121"
    local internal "SQ126B"
    _recode_nls7286_skip_93 `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing SQ128A

    local route "SQ128A"
    local internal "SQ128B SQ128C"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "SQ128A"
    local internal "SQ129"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "SQ128A"
    local internal "SQ130A SQ130B SQ130C SQ130D SQ130E SQ130F SQ130G"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section F - Activities and Opinions
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing SQ143

    local route "SQ143"
    local internal "SQ144A SQ144B SQ144C SQ144D SQ144E SQ144F"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    *Level 1 routing item
    _recode_nls7286_routing SQ145

    local route "SQ145"
    local internal "SQ146A SQ146B SQ147"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 1 routing item
    _recode_nls7286_routing SQ152C

    local route "SQ152C"
    local internal "SQ152A SQ152B"
    _recode_nls7286_skip_n `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing SQ152A

    local route "SQ152A"
    local internal "SQ152C"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing SQ152B

    **********************************************
    ** Third Follow Up (TQ)
    **********************************************

    **********************************************
    **Section A - General information
    **********************************************
    *Update values for routing item: certain values (20, 40, and 60) were added to the routing item when there is an inconsistency in the item contained within the routing pattern. 
    *Level 1 routing item
    _recode_nls7286_routing TQ5

    local route "TQ5"
    local internal "TQ6 TQ7"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section B - Work Experience
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing TQ10

    local route "TQ10"
    local internal "TQ11A TQ11B TQ11C TQ11D TQ11E TQ11F TQ11G TQ11H TQ11I TQ11J TQ11K TQ11L TQ11M TQ12"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "TQ10"
    local internal "TQ13AD"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 1 3

    local route "TQ10"
    local internal "TQ13E TQ13FA TQ13FB TQ13GA"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 1 routing item
    _recode_nls7286_routing TQ13GA

    local route "TQ13GA"
    local internal "TQ13GB TQ13GC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ10"
    local internal "TQ14A TQ14B TQ14C TQ14D TQ14E TQ14F TQ14G TQ14H TQ14I TQ14J TQ14K TQ14L TQ16 TQ17A TQ17B TQ17C TQ17D TQ18A TQ18B TQ19 TQ21A TQ21B TQ21C TQ21D TQ21E TQ21F TQ21G TQ21H TQ21I TQ21J TQ21K TQ22"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    local route "TQ10"
    local internal "TQ15"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 1 3

    local route "TQ10"
    local internal "TQ20"
    _recode_nls7286_skip_r94 `route' `"`internal'"' 1 3

    *Level 1 routing item
    _recode_nls7286_routing TQ22

    local route "TQ22"
    local internal "TQ23A TQ23B TQ23C TQ23D TQ23E TQ23F TQ24A TQ24B TQ24C TQ24D TQ24E TQ24F TQ24G TQ24H TQ24I TQ25 TQ26"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ10"
    local internal "TQ27"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing TQ27

    local route "TQ27"
    local internal "TQ28"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "TQ10"
    local internal "TQ29"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing TQ29

    local route "TQ29"
    local internal "TQ30"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "TQ29"
    local internal "TQ31"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing TQ32

    local route "TQ32"
    local internal "TQ33"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "TQ32"
    local internal "TQ34"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing TQ34

    local route "TQ34"
    local internal "TQ35AD"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    local route "TQ34"
    local internal "TQ35E TQ35FA TQ35FB"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    local route "TQ32"
    local internal "TQ36"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 1 3

    local route "TQ32"
    local internal "TQ37"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 1 3

    local route "TQ32"
    local internal "TQ38A"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing TQ38A

    local route "TQ38A"
    local internal "TQ38B TQ38C TQ39A TQ39B TQ39C TQ39D TQ39E TQ39F TQ39G TQ39H TQ39I TQ39J TQ39K TQ39L TQ39M TQ39N TQ39O TQ39P TQ39Q TQ39R TQ39S TQ39T TQ39U"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ32"
    local internal "TQ40"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    *Level 1 routing item
    _recode_nls7286_routing TQ43NY

    local route "TQ43NY"
    local internal "TQ43A TQ43B"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    **********************************************
    **Section C - Education and Training
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing TQ47

    local route "TQ47"
    local internal "TQ48AA TQ48BA TQ48CA TQ48DA TQ48EA TQ48FA TQ48GA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ48AA
    quietly replace TQ48AA = 98 if TQ48AA == 8

    local route "TQ48AA"
    local internal "TQ48AB TQ48AC"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "TQ48AA"
    local internal "TQ48AD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing TQ48BA
    quietly replace TQ48BA = 98 if TQ48BA == 8

    local route "TQ48BA"
    local internal "TQ48BB TQ48BC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ48BA"
    local internal "TQ48BD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ48CA
    quietly replace TQ48CA = 98 if TQ48CA == 8

    local route "TQ48CA"
    local internal "TQ48CB TQ48CC"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "TQ48CA"
    local internal "TQ48CD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing TQ48DA
    quietly replace TQ48DA = 98 if TQ48DA == 8

    local route "TQ48DA"
    local internal "TQ48DB TQ48DC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "TQ48DA"
    local internal "TQ48DD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    *Level 2 routing item
    _recode_nls7286_routing TQ48EA
    quietly replace TQ48EA = 98 if TQ48EA == 8

    local route "TQ48EA"
    local internal "TQ48EB TQ48EC"
    _recode_nls7286_skip `route' `"`internal'"' 5

    local route "TQ48EA"
    local internal "TQ48ED"
    _recode_nls7286_skip_96 `route' `"`internal'"' 5

    *Level 2 routing item
    _recode_nls7286_routing TQ48FA
    quietly replace TQ48FA = 98 if TQ48FA == 8

    local route "TQ48FA"
    local internal "TQ48FB TQ48FC"
    _recode_nls7286_skip `route' `"`internal'"' 6

    local route "TQ48FA"
    local internal "TQ48FD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 6

    *Level 2 routing item
    _recode_nls7286_routing TQ48GA
    quietly replace TQ48GA = 98 if TQ48GA == 8

    local route "TQ48GA"
    local internal "TQ48GB TQ48GC"
    _recode_nls7286_skip `route' `"`internal'"' 7

    local route "TQ48GA"
    local internal "TQ48GD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 7

    *Level 1 routing item
    _recode_nls7286_routing TQ51

    local route "TQ51"
    local internal "TQ52"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ52

    local route "TQ52"
    local internal "TQ53FICE"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "TQ52"
    local internal " TQ53C TQ54 TQ55A TQ55B TQ56A" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ56A

    local route "TQ56A"
    local internal "TQ56B TQ56C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ52"
    local internal "TQ57"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ57

    local route "TQ57"
    local internal "TQ58A TQ58B TQ58C TQ58D TQ58E TQ58F TQ58G TQ58H TQ58I TQ58J"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "TQ52"
    local internal "TQ59"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "TQ52"
    local internal "TQ60"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ52"
    local internal "TQ61"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "TQ52"
    local internal "TQ62"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ62

    local route "TQ62"
    local internal "TQ62FS"
    _recode_nls7286_skip_96 `route' `"`internal'"' 15

    local route "TQ52"
    local internal "TQ63 TQ64A TQ64BA TQ64CA TQ64D TQ64E TQ64F TQ64G TQ64H TQ64IA TQ64JA "
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ64BA
    quietly replace TQ64BA = 98 if TQ64BA == 8

    local route "TQ64BA"
    local internal "TQ64BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ64CA

    local route "TQ64CA"
    local internal "TQ64CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 3 routing item
    _recode_nls7286_routing TQ64IA
    quietly replace TQ64IA = 98 if TQ64IA == 8

    local route "TQ64IA"
    local internal "TQ64IB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 9

    *Level 3 routing item
    _recode_nls7286_routing TQ64JA
    quietly replace TQ64JA = 98 if TQ64JA == 8

    local route "TQ64JA"
    local internal "TQ64JB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 10

    local route "TQ52"
    local internal "TQ65"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "TQ51"
    local internal "TQ66"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ66

    local route "TQ66"
    local internal "TQ67FICE"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "TQ66"
    local internal "TQ67C TQ68 TQ69A TQ69B" 
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "TQ66"
    local internal "TQ70 TQ72 TQ73"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    local route "TQ66"
    local internal "TQ71 "
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    *Level 3 routing item
    _recode_nls7286_routing TQ73

    local route "TQ73"
    local internal "TQ74"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 3

    local route "TQ73"
    local internal "TQ75"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    *Level 4 routing item
    _recode_nls7286_routing TQ75
    local route "TQ75"
    local internal "TQ75FS"
    _recode_nls7286_skip_96 `route' `"`internal'"' 15

    local route "TQ73"
    local internal "TQ76"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    local route "TQ66"
    local internal "TQ77A TQ77BA TQ77CA TQ77D TQ77E TQ77F TQ77G TQ77H TQ77IA TQ77JA TQ78"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    *Level 3 routing item
    _recode_nls7286_routing TQ77BA
    quietly replace TQ77BA = 98 if TQ77BA == 8

    local route "TQ77BA"
    local internal "TQ77BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing TQ77CA
    quietly replace TQ77CA = 98 if TQ77CA == 8

    local route "TQ77CA"
    local internal "TQ77CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 3 routing item
    _recode_nls7286_routing TQ77IA
    quietly replace TQ77IA = 98 if TQ77IA == 8

    local route "TQ77IA"
    local internal "TQ77IB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 9

    *Level 3 routing item
    _recode_nls7286_routing TQ77JA

    local route "TQ77JA"
    local internal "TQ77JB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 10

    local route "TQ51"
    local internal "TQ79"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 1 routing item
    _recode_nls7286_routing TQ79

    local route "TQ79"
    local internal "TQ80A TQ80B TQ80C TQ80D TQ80E TQ80F TQ80G TQ80H TQ80I TQ80J TQ80K"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    local route "TQ51"
    local internal "TQ81"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 1 routing item
    _recode_nls7286_routing TQ81

    local route "TQ81"
    local internal "TQ82A TQ82B TQ82C TQ82D TQ82E TQ82F TQ82G TQ82H TQ82I TQ82J TQ82K TQ82L TQ82M TQ82N TQ82O"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    local route "TQ51"
    local internal "TQ83"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 1 routing item
    _recode_nls7286_routing TQ83

    local route "TQ83"
    local internal "TQ84A TQ84B TQ84C TQ84D TQ84E TQ84F TQ84G TQ84H TQ84I TQ84J TQ84K"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 4

    local route "TQ51"
    local internal "TQ85A TQ85B TQ86"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ86

    local route "TQ86"
    local internal "TQ87A TQ87B TQ87C"
    _recode_nls7286_skip_94 `route' `"`internal'"' 3

    local route "TQ51"
    local internal "TQ88AA"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ88AA

    local route "TQ88AA"
    local internal "TQ88AB"
    _recode_nls7286_skip_93 `route' `"`internal'"' 1 

    local route "TQ51"
    local internal "TQ88BA"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ88BA

    local route "TQ88BA"
    local internal "TQ88BB"
    _recode_nls7286_skip_93 `route' `"`internal'"' 1 

    local route "TQ51"
    local internal "TQ89AA TQ89AB TQ89BA TQ89BB TQ89CA TQ89CB TQ89DA TQ89DB TQ89EA TQ89EB TQ89FA TQ89FB"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2 

    local route "TQ51"
    local internal "TQ89GAA TQ89GBA TQ90"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    local route "TQ51"
    local internal "TQ89GAB TQ89GBB TQ89HA TQ89HB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ90

    local route "TQ90"
    local internal "TQ91AA TQ91AB TQ91BA TQ91BB TQ91CA TQ91CB TQ91DA TQ91DB TQ91EA TQ91EB TQ91FA TQ91FB TQ91GA TQ91GB TQ91HA TQ91HB TQ91IA TQ91IB TQ91JA TQ91JB TQ91KA TQ91KB"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 4

    *Incorporate logical skip patterns
    local route "TQ90"
    local internal "TQ91AA TQ91BA TQ91CA TQ91DA TQ91EA TQ91FA TQ91GA TQ91HA TQ91IA TQ91JA TQ91KA"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 2 4

    local route "TQ90"
    local internal "TQ91AB TQ91BB TQ91CB TQ91DB TQ91EB TQ91FB TQ91GB TQ91HB TQ91IB TQ91JB TQ91KB"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 3 4

    local route "TQ51"
    local internal "TQ92"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ92

    local route "TQ92"
    local internal "TQ93AA TQ93AB TQ93BA TQ93BB TQ93CA TQ93CB TQ93DA TQ93DB TQ93EA TQ93EB TQ93FA TQ93FB TQ93GA TQ93GB TQ93HA TQ93HB TQ93IA TQ93IB"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 4

    *Incorporate logical skip patterns
    local route "TQ92"
    local internal "TQ93AA TQ93BA TQ93CA TQ93DA TQ93EA TQ93FA TQ93GA TQ93HA TQ93IA"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 2 4

    local route "TQ92"
    local internal "TQ93AB TQ93BB TQ93CB TQ93DB TQ93EB TQ93FB TQ93GB TQ93HB TQ93IB"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 3 4

    local route "TQ51"
    local internal "TQ94"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ94

    local route "TQ94"
    local internal "TQ95AA TQ95AB TQ95BA TQ95BB TQ95CA TQ95CB TQ95DA TQ95DB"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 4

    *Incorporate logical skip patterns
    local route "TQ94"
    local internal "TQ95AA TQ95BA TQ95CA TQ95DA"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 2 4

    local route "TQ94"
    local internal "TQ95AB TQ95BB TQ95CB TQ95DB"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 3 4

    local route "TQ51"
    local internal "TQ96"
    _recode_nls7286_skip `route' `"`internal'"' 2 

    *Level 2 routing item
    _recode_nls7286_routing TQ96

    local route "TQ96"
    local internal "TQ97AA TQ97AB TQ97BA TQ97BB TQ97CA TQ97CB TQ97DA TQ97DB TQ97EA TQ97EB"
    _recode_nls7286_skip_r96 `route' `"`internal'"' 2 4

    *Incorporate logical skip patterns
    local route "TQ96"
    local internal "TQ97AA TQ97BA TQ97CA TQ97DA TQ97EA"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 2 4

    local route "TQ96"
    local internal "TQ97AB TQ97BB TQ97CB TQ97DB TQ97EB"
    _recode_nls7286_skip_l96 `route' `"`internal'"' 3 4

    *Level 1 routing item
    _recode_nls7286_routing TQ98

    local route "TQ98"
    local internal "TQ99A TQ99B TQ99C TQ99D TQ99E TQ99F"
    _recode_nls7286_skip_95 `route' `"`internal'"' 3

    local route "TQ98"
    local internal "TQ99GB TQ99H TQ100A TQ100B TQ100C TQ100D TQ100E TQ100F TQ100G TQ100H TQ100I TQ100J TQ100K"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "TQ98"
    local internal "TQ99GA"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing TQ101

    local route "TQ101"
    local internal "TQ102"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ102

    local route "TQ102"
    local internal "TQ103AIN TQ103BIN TQ103CIN"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ103AIN

    local route "TQ103AIN"
    local internal "TQ103AFC TQ103AFS" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    local route "TQ103AIN"
    local internal "TQ103AST TQ103AA TQ103AB TQ103AC TQ103AD" 
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing TQ103BIN

    local route "TQ103BIN"
    local internal "TQ103BFC TQ103BFS" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    local route "TQ103BIN"
    local internal "TQ103BST TQ103BA TQ103BB TQ103BC TQ103BD" 
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing TQ103CIN
    quietly replace TQ103CIN = 98 if TQ103CIN == 8

    local route "TQ103CIN"
    local internal "TQ103CFC TQ103CFS"
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    local route "TQ103CIN"
    local internal "TQ103CST TQ103CA TQ103CB TQ103CC TQ103CD" 
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "TQ101"
    local internal "TQ104"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ104

    local route "TQ104"
    local internal "TQ105A TQ105B TQ105C TQ105D TQ105E TQ105F TQ105G TQ105H TQ105I TQ105J TQ105K TQ105L"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "TQ104"
    local internal "TQ106A TQ106B TQ106C TQ106D TQ106E TQ106F TQ106G TQ107A TQ107B TQ107C TQ107D TQ107E TQ107F TQ107G TQ107H TQ107I TQ107J"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 2

    *Level 1 routing item
    _recode_nls7286_routing TQ108

    local route "TQ108"
    local internal "TQ109A TQ109B TQ109C TQ109D TQ109E TQ109F TQ109G TQ109H TQ109I TQ109J TQ109K TQ109L TQ110 TQ112 TQ113 TQ114 TQ115"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing TQ110

    local route "TQ110"
    local internal "TQ111"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing TQ116

    local route "TQ116"
    local internal "TQ117"
    _recode_nls7286_skip `route' `"`internal'"' 3

    **********************************************
    **Section D - Military Service
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing TQ118

    local route "TQ118"
    local internal "TQ119 TQ120A TQ120B TQ121 TQ124 TQ125A TQ125B TQ125C TQ126A"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing TQ121
    local route "TQ121"
    local internal "TQ122"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "TQ118"
    local internal "TQ123"
    _recode_nls7286_skip_93 `route' `"`internal'"' 3

    *Level 2 routing item
    _recode_nls7286_routing TQ126A

    local route "TQ126A"
    local internal "TQ126B TQ126C"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "TQ126A"
    local internal "TQ127 TQ128A TQ128B TQ128C TQ128D TQ128E TQ128F TQ128G TQ128H"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section E - Family Status
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing TQ129

    local route "TQ129"
    local internal "TQ130A TQ130B TQ131BOX"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 4

    *Level 2 routing item
    _recode_nls7286_routing TQ131BOX
    quietly replace TQ131BOX = 98 if TQ131BOX == 8 // out of range for this box item, original value 48, maybe a fluke?

    local route "TQ131BOX"
    local internal "TQ131A TQ131B TQ131C TQ131D TQ131E TQ131F TQ131G TQ131H TQ132BOX"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing TQ132BOX
    quietly replace TQ132BOX = 98 if TQ132BOX == 8 // out of range for this box item, original value 48, maybe a fluke?
            
    local route "TQ132BOX"
    local internal "TQ132AD TQ133"
    _recode_nls7286_skip_n93 `route' `"`internal'"' 1

    local route "TQ132BOX"
    local internal "TQ132E"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    local route "TQ132BOX"
    local internal "TQ134"
    _recode_nls7286_skip_n95 `route' `"`internal'"' 1

    local route "TQ131BOX"
    local internal "TQ135"
    _recode_nls7286_skip_n93 `route' `"`internal'"' 1

    local route "TQ129"
    local internal "TQ136BOX"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 4

    *Level 2 routing item
    _recode_nls7286_routing TQ136BOX
    quietly replace TQ136BOX = 98 if TQ136BOX == 8 // out of range for this box item, original value 48, maybe a fluke?

    local route "TQ136BOX"
    local internal "TQ136A TQ136B TQ136C TQ136D TQ136E TQ136F TQ136G TQ136H"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 1 routing item
    _recode_nls7286_routing TQ144

    local route "TQ144"
    local internal "TQ145A TQ145B TQ146"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    ** Fourth Follow Up (FT)
    **********************************************

    **********************************************
    **Section A - General information
    **********************************************

    **********************************************
    **Section B - Work Experience
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FT11

    local route "FT11"
    local internal "FT12AD"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT11"
    local internal "FT12E FT12FA FT12FB FT12GA FT13A FT13B FT13C FT13D FT13E FT13F FT13G FT13H FT13I FT13J FT13K FT13L FT14A FT14B FT14C FT14D FT14E FT14F FT14G FT14H FT14I FT14J FT14K FT14L FT15A FT15B FT15C FT15D FT15E FT15F FT15G FT15H FT15I FT15J FT16A FT16B FT16C FT16D FT16E FT16F FT16G FT16H FT16I FT17 FT18"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT12GA

    local route "FT12GA"
    local internal "FT12GB FT12GC "
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT18

    local route "FT18"
    local internal "FT19"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    local route "FT18"
    local internal "FT20"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 2 3

    local route "FT11"
    local internal "FT21"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT21

    local route "FT21"
    local internal "FT22"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT21"
    local internal "FT23A FT23B FT23C FT23D FT23E FT23F FT23G FT23H FT23I FT23J FT23K FT23L FT25A FT25B FT25C FT25D FT26 FT27 FT28 FT30"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT21"
    local internal "FT24"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT21"
    local internal "FT29"
    _recode_nls7286_skip_94 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT30

    local route "FT30"
    local internal "FT31A FT31B FT31C FT31D FT31E FT31F FT31G FT31H FT32 FT33"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT21"
    local internal "FT34"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT34

    local route "FT34"
    local internal "FT35"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT21"
    local internal "FT36"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT36

    local route "FT36"
    local internal "FT37"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT36"
    local internal "FT38"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT21"
    local internal "FT39"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT11"
    local internal "FT40 FT41"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT41

    local route "FT41"
    local internal "FT42"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT41"
    local internal "FT43"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT41"
    local internal "FT44"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT44

    local route "FT44"
    local internal "FT45AD"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT44"
    local internal "FT45E FT45FA FT45FB FT45GA FT45GB"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT41"
    local internal "FT46"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT46

    local route "FT46"
    local internal "FT47"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT46"
    local internal "FT48"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT41"
    local internal "FT49"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT11"
    local internal "FT50 FT51"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT51

    local route "FT51"
    local internal "FT52"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT51"
    local internal "FT53"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT51"
    local internal "FT54"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT54

    local route "FT54"
    local internal "FT55AD"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT54"
    local internal "FT55E FT55FA FT55FB FT55GA FT55GB"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT51"
    local internal "FT56"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT56

    local route "FT56"
    local internal "FT57"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT56"
    local internal "FT58"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT51"
    local internal "FT59"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT11"
    local internal "FT60A FT60B FT60C FT61A FT61B FT61C FT62A FT62B FT62C"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    **********************************************
    **Section C - Education and Training
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FT75

    local route "FT75"
    local internal "FT76AA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76AA
    quietly replace FT76AA = 98 if FT76AA == 8

    local route "FT76AA"
    local internal "FT76AB FT76AC"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FT76AA"
    local internal "FT76AD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    local route "FT75"
    local internal "FT76BA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76BA
    quietly replace FT76BA = 98 if FT76BA == 8

    local route "FT76BA"
    local internal "FT76BB FT76BC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT76BA"
    local internal "FT76BD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT75"
    local internal "FT76CA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76CA
    quietly replace FT76CA = 98 if FT76CA == 8

    local route "FT76CA"
    local internal "FT76CB FT76CC"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT76CA"
    local internal "FT76CD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FT75"
    local internal "FT76DA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76DA
    quietly replace FT76DA = 98 if FT76DA == 8

    local route "FT76DA"
    local internal "FT76DB FT76DC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FT76DA"
    local internal "FT76DD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    local route "FT75"
    local internal "FT76EA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76EA
    quietly replace FT76EA = 98 if FT76EA == 8

    local route "FT76EA"
    local internal "FT76EB FT76EC"
    _recode_nls7286_skip `route' `"`internal'"' 5

    local route "FT76EA"
    local internal "FT76ED"
    _recode_nls7286_skip_96 `route' `"`internal'"' 5

    local route "FT75"
    local internal "FT76FA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76FA
    quietly replace FT76FA = 98 if FT76FA == 8

    local route "FT76FA"
    local internal "FT76FB FT76FC"
    _recode_nls7286_skip `route' `"`internal'"' 6

    local route "FT76FA"
    local internal "FT76FD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 6

    local route "FT75"
    local internal "FT76GA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT76GA
    quietly replace FT76GA = 98 if FT76GA == 8

    local route "FT76GA"
    local internal "FT76GB FT76GC"
    _recode_nls7286_skip `route' `"`internal'"' 7

    local route "FT76GA"
    local internal "FT76GD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 7

    *Level 1 routing item
    _recode_nls7286_routing FT78

    local route "FT78"
    local internal "FT79"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT79

    local route "FT79"
    local internal "FT80A FT80B FT80C FT80D FT80E FT80F FT80G FT80H FT80I FT80J FT80K FT80L"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT79"
    local internal "FT81A FT86" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT79"
    local internal "FT81C FT82 FT83 FT85 FT87 FT88 FT89A FT89BA FT89CA FT89D FT89E FT89F FT89G FT89H FT89IA FT89JA FT90"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT79"
    local internal "FT84"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT87

    local route "FT87"
    local internal "FT87SP" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 15

    *Level 3 routing item
    _recode_nls7286_routing FT89BA
    quietly replace FT89BA = 98 if FT89BA == 8

    local route "FT89BA"
    local internal "FT89BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT89CA
    quietly replace FT89CA = 98 if FT89CA == 8

    local route "FT89CA"
    local internal "FT89CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 3 routing item
    _recode_nls7286_routing FT89IA

    local route "FT89IA"
    local internal "FT89IB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 9

    *Level 3 routing item
    _recode_nls7286_routing FT89JA
    quietly replace FT89JA = 98 if FT89JA == 8

    local route "FT89JA"
    local internal "FT89JB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 10

    local route "FT78"
    local internal "FT91"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT91

    local route "FT91"
    local internal "FT92A FT92B FT92C FT92D FT92E FT92F FT92G FT92H FT92I FT92J FT92K FT92L"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT91"
    local internal "FT93A FT98" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT91"
    local internal "FT93C FT94 FT95 FT97 FT99 FT100 FT101A FT101BA FT101CA FT101D FT101E FT101F FT101G FT101H FT101IA FT101JA FT102"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT91"
    local internal "FT96"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT99

    local route "FT99"
    local internal "FT99SP" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 15

    *Level 3 routing item
    _recode_nls7286_routing FT101BA
    quietly replace FT101BA = 98 if FT101BA == 8

    local route "FT101BA"
    local internal "FT101BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT101CA
    local route "FT101CA"
    local internal "FT101CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 3 routing item
    _recode_nls7286_routing FT101IA
    quietly replace FT101IA = 98 if FT101IA == 8

    local route "FT101IA"
    local internal "FT101IB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 9

    *Level 3 routing item
    _recode_nls7286_routing FT101JA
    quietly replace FT101JA = 98 if FT101JA == 8

    local route "FT101JA"
    local internal "FT101JB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 10

    local route "FT78"
    local internal "FT103"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT103

    local route "FT103"
    local internal "FT104A FT104B FT104C FT104D FT104E FT104F FT104G FT104H FT104I FT104J FT104K FT104L"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT103"
    local internal "FT105A FT110" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT103"
    local internal "FT105C FT106 FT107 FT109 FT111 FT112 FT113A FT113BA FT113CA FT113D FT113E FT113F FT113G FT113H FT113IA FT113JA FT114"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT103"
    local internal "FT108"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT111

    local route "FT111"
    local internal "FT111SP" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 15

    *Level 3 routing item
    _recode_nls7286_routing FT113BA
    quietly replace FT113BA = 98 if FT113BA == 8

    local route "FT113BA"
    local internal "FT113BB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT113CA

    local route "FT113CA"
    local internal "FT113CB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 3 routing item
    _recode_nls7286_routing FT113IA
    quietly replace FT113IA = 98 if FT113IA == 8

    local route "FT113IA"
    local internal "FT113IB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 9

    *Level 3 routing item
    _recode_nls7286_routing FT113JA

    local route "FT113JA"
    local internal "FT113JB"
    _recode_nls7286_skip_96 `route' `"`internal'"' 10

    local route "FT78"
    local internal "FT115 FT118"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT78"
    local internal "FT116 FT117"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 3 routing item
    _recode_nls7286_routing FT118

    local route "FT118"
    local internal "FT119"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 4

    local route "FT78"
    local internal "FT120A FT120B FT120C"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT78"
    local internal "FT121A FT121B FT121C"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT78"
    local internal "FT122A"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT122A
    quietly replace FT122A = 98 if FT122A == 8

    local route "FT122A"
    local internal "FT122B FT122C FT122D FT123AA FT123AB FT123AC FT123BA FT123BB FT123BC FT123CA FT123CB FT123CC FT123DA FT123DB FT123DC FT123EA FT123EB FT123EC FT123FA FT123FB FT123FC FT123GA FT123GB FT123GC FT123HA FT123HB FT123HC FT123IA FT123IB FT123IC FT123JA FT123JB FT123JC FT123KA FT123KB FT123KC"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Incorporate logical skip patterns
    local route "FT122B"
    local internal "FT123AA FT123BA FT123CA FT123DA FT123EA FT123FA FT123GA FT123HA FT123IA FT123JA FT123KA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT122C"
    local internal "FT123AB FT123BB FT123CB FT123DB FT123EB FT123FB FT123GB FT123HB FT123IB FT123JB FT123KB"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT122D"
    local internal "FT123AC FT123BC FT123CC FT123DC FT123EC FT123FC FT123GC FT123HC FT123IC FT123JC FT123KC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FT122B"
    local internal "FT124A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT122C"
    local internal "FT124B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FT122D"
    local internal "FT124C"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    local route "FT78"
    local internal "FT125A"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT125A
    quietly replace FT125A = 98 if FT125A == 8

    local route "FT125A"
    local internal "FT125B FT125C FT125D FT126AA FT126AB FT126AC FT126BA FT126BB FT126BC FT126CA FT126CB FT126CC FT126DA FT126DB FT126DC FT126EA FT126EB FT126EC FT126FA FT126FB FT126FC FT126GA FT126GB FT126GC FT126HA FT126HB FT126HC FT126IA FT126IB FT126IC"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Incorporate logical skip patterns
    local route "FT125B"
    local internal "FT126AA FT126BA FT126CA FT126DA FT126EA FT126FA FT126GA FT126HA FT126IA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT125C"
    local internal "FT126AB FT126BB FT126CB FT126DB FT126EB FT126FB FT126GB FT126HB FT126IB"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT125D"
    local internal "FT126AC FT126BC FT126CC FT126DC FT126EC FT126FC FT126GC FT126HC FT126IC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FT125B"
    local internal "FT127A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT125C"
    local internal "FT127B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FT125D"
    local internal "FT127C"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    local route "FT78"
    local internal "FT128A"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT128A
    quietly replace FT128A = 98 if FT128A == 8

    local route "FT128A"
    local internal "FT128B FT128C FT128D FT129AA FT129AB FT129AC FT129BA FT129BB FT129BC FT129CA FT129CB FT129CC"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Incorporate logical skip patterns
    local route "FT128B"
    local internal "FT129AA FT129BA FT129CA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT128C"
    local internal "FT129AB FT129BB FT129CB"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT128D"
    local internal "FT129AC FT129BC FT129CC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FT128B"
    local internal "FT130A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT128C"
    local internal "FT130B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FT128D"
    local internal "FT130C"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    local route "FT78"
    local internal "FT131A"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT131A
    quietly replace FT131A = 98 if FT131A == 8

    local route "FT131A"
    local internal "FT131B FT131C FT131D FT132AA FT132AB FT132AC FT132BA FT132BB FT132BC FT132CA FT132CB FT132CC FT132DA FT132DB FT132DC FT132EA FT132EB FT132EC"
    _recode_nls7286_skip_n `route' `"`internal'"' 1

    *Incorporate logical skip patterns
    local route "FT131B"
    local internal "FT132AA FT132BA FT132CA FT132DA FT132EA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT131C"
    local internal "FT132AB FT132BB FT132CB FT132DB FT132EB"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FT131D"
    local internal "FT132AC FT132BC FT132CC FT132DC FT132EC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FT131B"
    local internal "FT133A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT131C"
    local internal "FT133B"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    local route "FT131D"
    local internal "FT133C"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    *Level 1 routing item
    _recode_nls7286_routing FT134

    local route "FT134"
    local internal "FT135 FT137A FT137B "
    _recode_nls7286_skip_95 `route' `"`internal'"' 3

    local route "FT134"
    local internal "FT136 FT137C FT137D FT137E FT137F FT137G FT137H"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing FT138

    local route "FT138"
    local internal "FT139A FT139APG FT139B FT139BPG FT139CPG FT139C" 
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FT138"
    local internal "FT139BC" 
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT138"
    local internal "FT139AST FT139AA FT139AB FT139AC FT139AD FT139BST FT139BA FT139BB FT139BD FT139CST FT139CA FT139CB FT139CC FT139CD"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FT140

    local route "FT140"
    local internal "FT141 FT143A FT143B FT143C"
    _recode_nls7286_skip_r94 `route' `"`internal'"' 2 3

    local route "FT140"
    local internal "FT142"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    *Level 1 routing item
    _recode_nls7286_routing FT144

    local route "FT144"
    local internal "FT145A FT145B FT145C FT145D FT145E FT145F FT145G FT145H FT145I FT145J FT145K FT145L FT146 FT148 FT149 FT150 FT151 FT152"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT146

    local route "FT146"
    local internal "FT147"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    *Level 2 routing item
    _recode_nls7286_routing FT152

    local route "FT152"
    local internal "FT153"
    _recode_nls7286_skip `route' `"`internal'"' 3

    **********************************************
    **Section D - Military Service
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FT154

    local route "FT154"
    local internal "FT155 FT156A FT156B FT157 "
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing FT157

    local route "FT157"
    local internal "FT158"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT154"
    local internal "FT159"
    _recode_nls7286_skip_93 `route' `"`internal'"' 3

    local route "FT154"
    local internal "FT160 FT161A FT161B FT161C FT162A"
    _recode_nls7286_skip `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing FT162A

    local route "FT162A"
    local internal "FT162B FT162C"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FT162A"
    local internal "FT163 FT164A FT164B FT164C FT164D FT164E FT164F FT164G FT164H FT164I"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    **Section E - Family Status
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FT165

    local route "FT165"
    local internal "FT166A FT166B FT167A"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 5

    *Level 2 routing item
    _recode_nls7286_routing FT167A
    quietly replace FT167A = 98 if FT167A == 8

    local route "FT167A"
    local internal "FT167B FT167C FT167D FT167E FT167F FT167G FT167H FT167I FT168"
    _recode_nls7286_skip_n `route' `"`internal'"' 0

    *Level 3 routing item
    _recode_nls7286_routing FT168

    local route "FT168"
    local internal "FT169AD"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT168"
    local internal "FT169E FT169FA FT169FB FT169GA"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 4 routing item
    _recode_nls7286_routing FT169GA

    local route "FT169GA"
    local internal "FT169GB FT169GC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT168"
    local internal "FT170"
    _recode_nls7286_skip_93 `route' `"`internal'"' 2

    local route "FT168"
    local internal "FT171"
    _recode_nls7286_skip_95 `route' `"`internal'"' 2

    local route "FT167A"
    local internal "FT172"
    _recode_nls7286_skip_n93 `route' `"`internal'"' 0

    local route "FT165"
    local internal "FT173A FT173B FT173C FT173D FT173E FT173F FT173G FT173H FT173I FT174A FT174B FT174C FT174D FT174E FT174F FT174G FT174H FT174I"
    _recode_nls7286_skip_r `route' `"`internal'"' 3 5

    *Level 1 routing item
    _recode_nls7286_routing FT176

    local route "FT176"
    local internal "FT177 FT178 FT179AA FT179AB FT179BA FT179BB FT179CA FT179CB FT179DA FT179DB FT179EA FT179EB FT179FA FT179FB FT180"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FT184

    local route "FT184"
    local internal "FT185A FT185B"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FT184"
    local internal "FT186"
    _recode_nls7286_skip_97 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FT191

    local route "FT191"
    local internal "FT192A FT192B FT193"
    _recode_nls7286_skip `route' `"`internal'"' 2

    **********************************************
    ** Fourth Supplemental (FSQ)
    **********************************************

    **********************************************
    **Section A - General information
    **********************************************
    *Level 1 routing item
    _recode_nls7286_routing FSQA1

    local route "FSQA1"
    local internal "FSQA2A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    local route "FSQA1"
    local internal "FSQA2C FSQA3 FSQA4A FSQA4B FSQA5A FSQA5B FSQA6 FSQA7"
    _recode_nls7286_skip `route' `"`internal'"' 1

    *Level 1 routing item
    _recode_nls7286_routing FSQB1

    local route "FSQB1"
    local internal "FSQB2AD FSQB3"
    _recode_nls7286_skip_93 `route' `"`internal'"' 1

    local route "FSQB1"
    local internal "FSQB2EA FSQB2EB FSQB2FA"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FSQB1"
    local internal "FSQB4"
    _recode_nls7286_skip_95 `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing FSQB2FA

    local route "FSQB2FA"
    local internal "FSQB2FB FSQB2FC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQC1

    local route "FSQC1"
    local internal "FSQC2A"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FSQC1"
    local internal "FSQC2C FSQC3 FSQC4A FSQC4B FSQC5A FSQC5B FSQC6 FSQC7 FSQC8"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQD1

    local route "FSQD1"
    local internal "FSQD2AD FSQD3"
    _recode_nls7286_skip_93 `route' `"`internal'"' 1

    local route "FSQD1"
    local internal "FSQD2EA FSQD2EB FSQD2FA"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FSQD1"
    local internal "FSQD4"
    _recode_nls7286_skip_95 `route' `"`internal'"' 1

    *Level 2 routing item
    _recode_nls7286_routing FSQD2FA

    local route "FSQD2FA"
    local internal "FSQD2FB FSQD2FC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQE1 

    local route "FSQE1"
    local internal "FSQE2A" // FSQE2SCH
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FSQE1" 
    local internal "FSQE2C FSQE3 FSQE4 FSQE5A FSQE5B FSQE6A FSQE6B FSQE7 FSQE8 FSQE9"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQF1

    local route "FSQF1"
    local internal "FSQF2AD FSQF3"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 2 3

    local route "FSQF1"
    local internal "FSQF2EA FSQF2EB FSQF2FA"
    _recode_nls7286_skip_r `route' `"`internal'"' 2 3

    local route "FSQF1"
    local internal "FSQF4"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 2 3

    *Level 2 routing item
    _recode_nls7286_routing FSQF2FA

    local route "FSQF2FA"
    local internal "FSQF2FB FSQF2FC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQG1 

    local route "FSQG1"
    local internal "FSQG2A" // FSQG2SCH FSQG2B
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FSQG1" 
    local internal "FSQG2C FSQG3 FSQG4 FSQG5A FSQG5B FSQG6A FSQG6B FSQG7 FSQG8 FSQG9"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQH1

    local route "FSQH1"
    local internal "FSQH2AD FSQH3"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 1 3

    local route "FSQH1"
    local internal "FSQH2EA FSQH2EB FSQH5A"
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    local route "FSQH1"
    local internal "FSQH4"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing FSQH5A

    local route "FSQH5A"
    local internal "FSQH5B FSQH5C"
    _recode_nls7286_skip `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQI1 

    local route "FSQI1"
    local internal "FSQI2A" // FSQI2SCH FSQI2B
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    local route "FSQI1" 
    local internal "FSQI2C FSQI3 FSQI4A FSQI4B FSQI5A FSQI5B FSQI6 FSQI7 FSQI8 FSQI9"
    _recode_nls7286_skip `route' `"`internal'"' 2
     
    *Level 1 routing item
    _recode_nls7286_routing FSQJ1

    local route "FSQJ1"
    local internal "FSQJ2AD FSQJ3"
    _recode_nls7286_skip_r93 `route' `"`internal'"' 1 3

    local route "FSQJ1"
    local internal "FSQJ2EA FSQJ2EB FSQJ2FA "
    _recode_nls7286_skip_r `route' `"`internal'"' 1 3

    local route "FSQJ1"
    local internal "FSQJ4"
    _recode_nls7286_skip_r95 `route' `"`internal'"' 1 3

    *Level 2 routing item
    _recode_nls7286_routing FSQJ2FA

    local route "FSQJ2FA"
    local internal "FSQJ2FB FSQJ2FC"
    _recode_nls7286_skip `route' `"`internal'"' 2
     
    *Level 1 routing item
    _recode_nls7286_routing FSQK2AA 
    quietly replace FSQK2AA = 98 if FSQK2AA == 8

    local route "FSQK2AA"
    local internal "FSQK2AB FSQK2AC"
    _recode_nls7286_skip `route' `"`internal'"' 1

    local route "FSQK2AA"
    local internal "FSQK2AD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 1

    *Level 1 routing item
    _recode_nls7286_routing FSQK2BA 
    quietly replace FSQK2BA = 98 if FSQK2BA == 8

    local route "FSQK2BA"
    local internal "FSQK2BB FSQK2BC"
    _recode_nls7286_skip `route' `"`internal'"' 2

    local route "FSQK2BA"
    local internal "FSQK2BD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 2

    *Level 1 routing item
    _recode_nls7286_routing FSQK2CA 
     
    local route "FSQK2CA"
    local internal "FSQK2CB FSQK2CC"
    _recode_nls7286_skip `route' `"`internal'"' 3

    local route "FSQK2CA"
    local internal "FSQK2CD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 3

    *Level 1 routing item
    _recode_nls7286_routing FSQK2DA 

    local route "FSQK2DA"
    local internal "FSQK2DB FSQK2DC"
    _recode_nls7286_skip `route' `"`internal'"' 4

    local route "FSQK2DA"
    local internal "FSQK2DD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 4

    *Level 1 routing item
    _recode_nls7286_routing FSQK2EA 
    quietly replace FSQK2EA = 98 if FSQK2EA == 8

    local route "FSQK2EA"
    local internal "FSQK2EB FSQK2EC"
    _recode_nls7286_skip `route' `"`internal'"' 5


    local route "FSQK2EA"
    local internal "FSQK2ED"
    _recode_nls7286_skip_96 `route' `"`internal'"' 5

    *Level 1 routing item
    _recode_nls7286_routing FSQK2FA 

    local route "FSQK2FA"
    local internal "FSQK2FB FSQK2FC"
    _recode_nls7286_skip `route' `"`internal'"' 6

    local route "FSQK2FA"
    local internal "FSQK2FD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 6

    *Level 1 routing item
    _recode_nls7286_routing FSQK2GA 
    quietly replace FSQK2GA = 98 if FSQK2GA == 8

    local route "FSQK2GA"
    local internal "FSQK2GB FSQK2GC"
    _recode_nls7286_skip `route' `"`internal'"' 7

    local route "FSQK2GA"
    local internal "FSQK2GD"
    _recode_nls7286_skip_96 `route' `"`internal'"' 7

end


**********************************************
** Routing items
**********************************************
*Update values for routing items: certain values (20, 40, and 60) were added to the routing item when there is an inconsistency in the item contained within the routing pattern. For values within the 20-39, 40-59, and 60-79 ranges introduced during routing checks, it deducts 20, 40, and 60 units, respectively.

program define _recode_nls7286_routing
    syntax varlist(numeric) [if] [in]
    
    foreach routing in `varlist'{
        quietly replace `routing' = `routing' - 20 if inrange(`routing', 20, 39)
        quietly replace `routing' = `routing' - 40 if inrange(`routing', 40, 59)
        quietly replace `routing' = `routing' - 60 if inrange(`routing', 60, 79)		
        *quietly replace `routing' = mod(`routing', 10) if inrange(`routing', 21, 69) // this approach does not handle items that have >10 values, e.g., month
        *tab `routing', nol
    }	
end

**********************************************
** Internal items
**********************************************
*Internal items: Adjust item values according to whether they meet a predefined routing condition. The program handles both valid and invalid items distinctly. The `_recode_nls7286_skip', `_recode_nls7286_skip_n', and their variants (`_recode_nls7286_skip_93', `_recode_nls7286_skip_n94', etc.) programs are specifically tailored to accommodate various cases based on the legitimate skip codes assigned to internal items that were not applicable or were _recode_nls7286_skipped in the survey response process. 
*The default legitimate skip code is 99, but the programs are flexible enough to deal with a broader range of skip codes, including 999, 9999, 99999, and 999999, for which specialized versions of the programs (such as `_recode_nls7286_skip_93',`_recode_nls7286_skip_94', etc.) have been developed. The additional programs, such as `_recode_nls7286_skip_r', `_recode_nls7286_skip_l', and their variants, are designed to accommodate different inclusion conditions, specifically for items that must be adjusted based on whether they fall within a certain range (`_recode_nls7286_skip_r') or include any of a set of discrete, specified values (`_recode_nls7286_skip_l'). 

**********************************************
* Condition: include a distinct survey response (e.g., yes)
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 99 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' - 100 if (`route' ==  `condition') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if (`route' ==  `condition') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip; legitimate skip = 999
program define _recode_nls7286_skip_93
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 999 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' -  800 if (`route' ==  `condition') & inrange(`item',  800,  899) // valid item
        quietly replace `item' = `item' - 1000 if (`route' ==  `condition') & inrange(`item', 1000, 1999) // valid item
        quietly replace `item' = `item' - 2000 if (`route' ==  `condition') & inrange(`item', 2000, 2999) // valid item
        quietly replace `item' = `item' -  800 if (`route' ==  `condition') & inrange(`item',  800,  899) // valid item
        assert !inrange(`item', 1000, 2999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip; legitimate skip = 9999
program define _recode_nls7286_skip_94
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 9999 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' -  8000 if (`route' ==  `condition') & inrange(`item',  8000,  8999) // valid item
        quietly replace `item' = `item' - 10000 if (`route' ==  `condition') & inrange(`item', 10000, 19999) // valid item
        quietly replace `item' = `item' - 20000 if (`route' ==  `condition') & inrange(`item', 20000, 29999) // valid item
        quietly replace `item' = `item' -  8000 if (`route' ==  `condition') & inrange(`item',  8000,  8999) // valid item
        assert !inrange(`item', 10000, 29999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip; legitimate skip = 99999
program define _recode_nls7286_skip_95
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 99999 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' -  80000 if (`route' ==  `condition') & inrange(`item',  80000,  89999) // valid item
        quietly replace `item' = `item' - 100000 if (`route' ==  `condition') & inrange(`item', 100000, 199999) // valid item
        quietly replace `item' = `item' - 200000 if (`route' ==  `condition') & inrange(`item', 200000, 299999) // valid item
        quietly replace `item' = `item' -  80000 if (`route' ==  `condition') & inrange(`item',  80000,  89999) // valid item    	
        assert !inrange(`item', 100000, 299999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip; legitimate skip = 999999
program define _recode_nls7286_skip_96
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 999999 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' -  800000 if (`route' ==  `condition') & inrange(`item',  800000,  899999) // valid item
        quietly replace `item' = `item' - 1000000 if (`route' ==  `condition') & inrange(`item', 1000000, 1999999) // valid item
        quietly replace `item' = `item' - 2000000 if (`route' ==  `condition') & inrange(`item', 2000000, 2999999) // valid item
        quietly replace `item' = `item' -  800000 if (`route' ==  `condition') & inrange(`item',  800000,  899999) // valid item
        assert !inrange(`item', 1000000, 2999999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip; legitimate skip = 9999999
program define _recode_nls7286_skip_97
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 9999999 if `route' != `condition' // invalid item 
        
        quietly replace `item' = `item' -  8000000 if (`route' ==  `condition') & inrange(`item',  8000000,  8999999) // valid item
        quietly replace `item' = `item' - 10000000 if (`route' ==  `condition') & inrange(`item', 10000000, 19999999) // valid item
        quietly replace `item' = `item' - 20000000 if (`route' ==  `condition') & inrange(`item', 20000000, 29999999) // valid item
        quietly replace `item' = `item' -  8000000 if (`route' ==  `condition') & inrange(`item',  8000000,  8999999) // valid item
        assert !inrange(`item', 10000000, 29999999)
        *tab `item', nol
    }
end

**********************************************
* Condition: exclude a distinct survey response (e.g., no)
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip_n
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 99 if `route' == `condition' // invalid item 
        
        quietly replace `item' = `item' - 100 if (`route' !=  `condition') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if (`route' !=  `condition') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip_n; legitimate skip = 999
program define _recode_nls7286_skip_n93
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 999 if `route' == `condition' // invalid item 
        
        quietly replace `item' = `item' -  800 if (`route' !=  `condition') & inrange(`item',  800,  899) // valid item
        quietly replace `item' = `item' - 1000 if (`route' !=  `condition') & inrange(`item', 1000, 1999) // valid item
        quietly replace `item' = `item' - 2000 if (`route' !=  `condition') & inrange(`item', 2000, 2999) // valid item
        quietly replace `item' = `item' -  800 if (`route' !=  `condition') & inrange(`item',  800,  899) // valid item
        assert !inrange(`item', 1000, 2999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip_n; legitimate skip = 9999
program define _recode_nls7286_skip_n94
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 9999 if `route' == `condition' // invalid item 
        
        quietly replace `item' = `item' -  8000 if (`route' !=  `condition') & inrange(`item',  8000,  8999) // valid item
        quietly replace `item' = `item' - 10000 if (`route' !=  `condition') & inrange(`item', 10000, 19999) // valid item
        quietly replace `item' = `item' - 20000 if (`route' !=  `condition') & inrange(`item', 20000, 29999) // valid item
        quietly replace `item' = `item' -  8000 if (`route' !=  `condition') & inrange(`item',  8000,  8999) // valid item
        assert !inrange(`item', 10000, 29999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip_n; legitimate skip = 99999
program define _recode_nls7286_skip_n95
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 99999 if `route' == `condition' // invalid item 
        
        quietly replace `item' = `item' -  80000 if (`route' !=  `condition') & inrange(`item',  80000,  89999) // valid item
        quietly replace `item' = `item' - 100000 if (`route' !=  `condition') & inrange(`item', 100000, 199999) // valid item
        quietly replace `item' = `item' - 200000 if (`route' !=  `condition') & inrange(`item', 200000, 299999) // valid item
        quietly replace `item' = `item' -  80000 if (`route' !=  `condition') & inrange(`item',  80000,  89999) // valid item
        assert !inrange(`item', 100000, 299999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip_n; legitimate skip = 999999
program define _recode_nls7286_skip_n96
    args route internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 999999 if `route' == `condition' // invalid item 
        
        quietly replace `item' = `item' -  800000 if (`route' !=  `condition') & inrange(`item',  800000,  899999) // valid item
        quietly replace `item' = `item' - 1000000 if (`route' !=  `condition') & inrange(`item', 1000000, 1999999) // valid item
        quietly replace `item' = `item' - 2000000 if (`route' !=  `condition') & inrange(`item', 2000000, 2999999) // valid item
        quietly replace `item' = `item' -  800000 if (`route' !=  `condition') & inrange(`item',  800000,  899999) // valid item
        assert !inrange(`item', 1000000, 2999999)
        *tab `item', nol
    }
end

**********************************************
* Condition: include survey responses within a certain range (e.g., 3 to 5)
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip_r
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 99 if !inrange(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' - 100 if inrange(`route', `c1', `c2') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if inrange(`route', `c1', `c2') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end    

// special case of _recode_nls7286_skip_r; legitimate skip = 999
program define _recode_nls7286_skip_r93
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 999 if !inrange(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  800 if inrange(`route', `c1', `c2') & inrange(`item',  800,  899) // valid item
        quietly replace `item' = `item' - 1000 if inrange(`route', `c1', `c2') & inrange(`item', 1000, 1999) // valid item
        quietly replace `item' = `item' - 2000 if inrange(`route', `c1', `c2') & inrange(`item', 2000, 2999) // valid item
        quietly replace `item' = `item' -  800 if inrange(`route', `c1', `c2') & inrange(`item',  800,  899) // valid item        
        assert !inrange(`item', 1000, 299)
        *tab `item', nol
    }
end    

// special case of _recode_nls7286_skip_r; legitimate skip = 9999
program define _recode_nls7286_skip_r94
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 9999 if !inrange(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  8000 if inrange(`route', `c1', `c2') & inrange(`item',  8000,  8999) // valid item
        quietly replace `item' = `item' - 10000 if inrange(`route', `c1', `c2') & inrange(`item', 10000, 19999) // valid item
        quietly replace `item' = `item' - 20000 if inrange(`route', `c1', `c2') & inrange(`item', 20000, 29999) // valid item
        quietly replace `item' = `item' -  8000 if inrange(`route', `c1', `c2') & inrange(`item',  8000,  8999) // valid item        
        assert !inrange(`item', 10000, 2999)
        *tab `item', nol
    }
end    

// special case of _recode_nls7286_skip_r; legitimate skip = 99999
program define _recode_nls7286_skip_r95
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 99999 if !inrange(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  80000 if inrange(`route', `c1', `c2') & inrange(`item',  80000,  89999) // valid item
        quietly replace `item' = `item' - 100000 if inrange(`route', `c1', `c2') & inrange(`item', 100000, 199999) // valid item
        quietly replace `item' = `item' - 200000 if inrange(`route', `c1', `c2') & inrange(`item', 200000, 299999) // valid item
        quietly replace `item' = `item' -  80000 if inrange(`route', `c1', `c2') & inrange(`item',  80000,  89999) // valid item        
        assert !inrange(`item', 100000, 29999)
        *tab `item', nol
    }
end    

// special case of _recode_nls7286_skip_r; legitimate skip = 999999
program define _recode_nls7286_skip_r96
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 999999 if !inrange(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  800000 if inrange(`route', `c1', `c2') & inrange(`item',  800000,  899999) // valid item
        quietly replace `item' = `item' - 1000000 if inrange(`route', `c1', `c2') & inrange(`item', 1000000, 1999999) // valid item
        quietly replace `item' = `item' - 2000000 if inrange(`route', `c1', `c2') & inrange(`item', 2000000, 2999999) // valid item
        quietly replace `item' = `item' -  800000 if inrange(`route', `c1', `c2') & inrange(`item',  800000,  899999) // valid item        
        assert !inrange(`item', 1000000, 299999)
        *tab `item', nol
    }
end    

**********************************************
* Condition: include two discrete specified survey responses (e.g., 2 and 5)
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip_l2
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 99 if !inlist(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' - 100 if inlist(`route', `c1', `c2') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if inlist(`route', `c1', `c2') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end    

// special case of _recode_nls7286_skip_l2; legitimate skip = 999
program define _recode_nls7286_skip_l93
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 999 if !inlist(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  800 if inlist(`route', `c1', `c2') & inrange(`item',  800,  899) // valid item
        quietly replace `item' = `item' - 1000 if inlist(`route', `c1', `c2') & inrange(`item', 1000, 1999) // valid item
        quietly replace `item' = `item' - 2000 if inlist(`route', `c1', `c2') & inrange(`item', 2000, 2999) // valid item
        quietly replace `item' = `item' -  800 if inlist(`route', `c1', `c2') & inrange(`item',  800,  899) // valid item
        assert !inrange(`item', 1000, 2999)
        *tab `item', nol
    }
end

// special case of _recode_nls7286_skip_l2; legitimate skip = 999999
program define _recode_nls7286_skip_l96
    args route internal c1 c2
    
    foreach item in `internal'{
        quietly replace `item' = 999999 if !inlist(`route', `c1', `c2') // invalid item 
        
        quietly replace `item' = `item' -  800000 if inlist(`route', `c1', `c2') & inrange(`item',  800000,  899999) // valid item
        quietly replace `item' = `item' - 1000000 if inlist(`route', `c1', `c2') & inrange(`item', 1000000, 1999999) // valid item
        quietly replace `item' = `item' - 2000000 if inlist(`route', `c1', `c2') & inrange(`item', 2000000, 2999999) // valid item
        quietly replace `item' = `item' -  800000 if inlist(`route', `c1', `c2') & inrange(`item',  800000,  899999) // valid item
        assert !inrange(`item', 1000000, 2999999)
        *tab `item', nol
    }
end

**********************************************
* Condition: include three discrete specified survey responses (e.g., 2, 3, and 5)
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip_l
    args route internal c1 c2 c3
    
    foreach item in `internal'{
        quietly replace `item' = 99 if !inlist(`route', `c1', `c2', `c3') // invalid item 
        
        quietly replace `item' = `item' - 100 if inlist(`route', `c1', `c2', `c3') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if inlist(`route', `c1', `c2', `c3') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end    
    
**********************************************
* Condition: use the expression provided
**********************************************
// default: legitimate skip = 99
program define _recode_nls7286_skip_cond
    args internal condition
    
    foreach item in `internal'{
        quietly replace `item' = 99 if !(`condition') // invalid item 
        
        quietly replace `item' = `item' - 100 if (`condition') & inrange(`item', 100, 199) // valid item
        quietly replace `item' = `item' - 200 if (`condition') & inrange(`item', 200, 299) // valid item
        assert !inrange(`item', 100, 299)
        *tab `item', nol
    }
end
