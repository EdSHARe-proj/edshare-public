*** Remove missing value reserve codes
*    For 1-digit variables, missing values are 6 ... 9
*    For k-digit variables, missing values are 10^k-6 ... 10^k-1

program define recode_missing
    
    * Process each variable in argument list
    foreach v of local 0 {
        * Skip string variables
        if substr("`:type `v''", 1, 3) == "str"  continue
        
        * Identify the number of digits the variable uses
        quietly sum `v'
        if r(max) == 1  local d = 1
        else            local d = ceil(log10(r(max)))
        
        * Remove missing value reserve codes
        display "`v': " _continue
        if `d' == 1  replace `v' = . if `v' >= 6
        else         replace `v' = . if `v' >= 10^`d' - 6
    }
    
end
