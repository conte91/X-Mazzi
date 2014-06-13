proc paciocca { geni length lofstring tokeep tocreate paciocno } {
  #First tokeep elements are kept
  #Then, next ones are pacioccated
  #Finally, last tocreate are recreated from new

  puts "Sto entrando in paciocca"
  set functions [list halfhalf cambiacar cambiablocco]
  set nfunctions [llength $functions ]
  puts $nfunctions
  set newgeni $geni
  #paciocching
  for { set i $tokeep } { $i < [expr $length - $tocreate] } { incr i } {
    for { set j 0 } { $j < $paciocno } { incr j } {
      #Set this element to the value given by random shuffling a random value with another
      #puts "Spaciocching $i"

      puts $i
      puts $newgeni
      lset newgeni $i [list $i [[lindex $functions [ random 0 $nfunctions ] ]  [lindex $geni [ random 0 [llength $geni ] ] 1 ] [lindex $geni [ random 0 [ llength $geni ]] 1 ] $lofstring ]]
    }
  }

  for { set i [expr $length-$tocreate] } { $i < $length } { incr i } {
    #puts "Recreating $i"
    puts $i
    puts $newgeni
    lset newgeni $i [list $i [randString $lofstring]]
  }

  return $newgeni
}
