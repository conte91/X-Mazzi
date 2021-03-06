proc paciocca { geni length lofstring tokeep tocreate paciocno } {
  #First tokeep elements are kept
  #Then, next ones are pacioccated
  #Finally, last tocreate are recreated from new

  set functions [list halfhalf cambiacar cambiablocco]
  set nfunctions [llength $functions ]
  set newgeni $geni
  #paciocching
  for { set i $tokeep } { $i < [expr $length - $tocreate] } { incr i } {
    for { set j 0 } { $j < $paciocno } { incr j } {
      #Set this element to the value given by random shuffling a random value with another

      set stringRand [lindex $geni [ random 0 [llength $geni ] ] 1 ]
      set stringRand2 [lindex $geni [ random 0 [ llength $geni ]] 1 ]
      set funcname [lindex $functions [ random 0 $nfunctions ] ]
      lset newgeni $i [list 0 [$funcname $stringRand $stringRand2 $lofstring ]]
    }
  }

  for { set i [expr $length-$tocreate] } { $i < $length } { incr i } {
    lset newgeni $i [list $i [randString $lofstring]]
  }

  return $newgeni
}
