proc randString { n } {
  set chars "01"
  set range [expr {[string length $chars]}]
  set txt ""
  #puts $range
  for {set i 0} {$i < $n} {incr i} {
    set pos [expr {int(rand()*$range)}]
    append txt [string range $chars $pos $pos]
  }
  return $txt
}
