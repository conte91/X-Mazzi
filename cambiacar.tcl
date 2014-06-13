proc cambiacar { s1 s2 n } {

  #puts "Cambiacar"
  set r [random 0 [string length $s1]]
  if { [string index $s1 $r] == 0 } {
    set cambia 1
  } else {
    set cambia 0
  }

  set a [string replace $s1 $r $r $cambia]
  return $a
}
