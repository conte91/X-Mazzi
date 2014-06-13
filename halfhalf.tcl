proc halfhalf { s1 s2 n } {
  set a [string range $s1 0 [expr $n / 2 - 1]]
  append a [string range $s2 [expr $n / 2 ] [expr $n - 1]]
  if {[expr $n % 2] == 1} {
    append a [string index $s2 [expr $n - 1]]
  }
  return $a
}

