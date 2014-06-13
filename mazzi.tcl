#Fitness stupidaa
proc mazzi { s1 } {
  #return [expr [ string length $s1 ] - [expr {[llength [split $s1 "1"]] - 1}]]
  return [expr [ string length $s1 ] - [ regsub -all 1 $s1 {} ignore ]]
}
