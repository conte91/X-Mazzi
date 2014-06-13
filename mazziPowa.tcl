#Fitness stupidaa
#In string, if(s1[i]==1 ){
#  high_voltage;
#}
#else{
#  low_voltage;
#}
#
proc mazziPowa { s1 celle maxTime } {

 for {set i 0} {$i < [string length $s1]} {incr i} {
    if { [string index $s1 $i ] == 1 } {
      #high_voltage; #§§§§ 
      cells_swapping [list [ lindex $celle $i ]] "HVT"

    } else {
      #low_voltage; #§§§§
      cells_swapping [list [  lindex $celle $i ]] "LVT"
    }
  }

  set lagrazianoisready 0
  while {$lagrazianoisready == 0} {
    redirect -variable powa {report_timing -nworst 1} 
    #set lagrazianoisready [regexp -- "Cell Leakage Power\\s+=\\s+\(\[0-9.\]+\)\\s+.*$" "$powa" c  b]
    set lagrazianoisready [regexp -- "data arrival time\\s+\(\[0-9.\]+\).*$" "$powa" c t]
    if { $t > $maxTime } {
      return 10000000
    }
  }

  set lagrazianoisready 0
  while {$lagrazianoisready == 0} {
    redirect -variable powa {report_power} 
    set lagrazianoisready [regexp -- "Cell Leakage Power\\s+=\\s+\(\[0-9.\]+\)\\s+.*\(\[munp\]\)W.*$" "$powa" c  b unit]
    switch $unit m { set b [expr $b * 1000000] } u { set b [expr $b * 1000] } n { set b $b } p { set b [expr $b / 1000 ] }
  }

  return $b
}
