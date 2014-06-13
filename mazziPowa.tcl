#Fitness stupidaa
#In string, if(s1[i]==1 ){
#  high_voltage;
#}
#else{
#  low_voltage;
#}
#
proc mazziPowa { s1 celle } {

 for {set i 0} {$i < [string length $s1]} {incr i} {
    if { [string index $s1 $i ] == 1 } {
      #high_voltage; #§§§§ 
      cells_swapping [list [ lindex $celle $i ]] "HVT"

    } else {
      #low_voltage; #§§§§
      cells_swapping [list [  lindex $celle $i ]] "LVT"
    }
  }

  redirect -variable powa {report_power} 
  regexp -- "Cell Leakage Power\\s+=\\s+\(\[0-9.\]+\)\\s+.*$" "$powa" c  b
  return $b
}
