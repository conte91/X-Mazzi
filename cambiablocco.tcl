proc cambiablocco { s1 s2 n } {

  #puts "Cambiacar"
  set r1 [random 0 [string length $s1]]
  set r2 [random 0 [string length $s1]]
  # Commented for honor
 # set r3 [expr {min($r1,$r2)}]
 # set r4 [expr {max($r1,$r2)}]
  if { $r1 < $r2 } {
    set r3 $r1
    set r4 $r2
  } else {
    set r3 $r2
    set r4 $r1
  }
  set r [random 0 2]
  if { $r == 0 } {
    set c "0"
  } else {
    set c "1"
  }
  set cambia ""
  for { set j 0 } { $j<[expr $r4 - $r3 + 1] } {incr j} {
    append cambia $c
  }

  set a [string replace $s1 $r3 $r4 $cambia]
  return $a
}
