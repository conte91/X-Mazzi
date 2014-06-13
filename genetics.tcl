proc genetics { } {
  #set count [sizeof_collection [  get_cells *]]
  set count 300
  set tokeep 4
  set togenerate 20
  expr {srand(60)} 

  set geni {}
  #Initialize vector
  set geni [paciocca $geni $togenerate $count 0 $togenerate 1]
#puts "before: $geni"

  for { set j 0 } { $j < 600 } { incr j } {
    for { set i 0 } { $i < [llength $geni] } { incr i } {
      #puts "Executing $i"
      #puts [lindex $geni [expr $i]]
      lset geni  $i 0  [mazzi [lindex [lindex $geni [expr $i]] 1]]
    }

    #puts "\n\n\nbefore: $geni\n\n\n"
    set geni [lsort -integer -index 0 $geni]

    #puts "\n\n\nafter: $geni\n\n\n"

    set geni [paciocca $geni $togenerate $count $tokeep 1 2 ]
  }

  for { set i 0 } { $i < [llength $geni] } { incr i } {
    #puts "Executing $i"
    #puts [lindex $geni [expr $i]]
    lset geni  $i 0  [mazzi [lindex [lindex $geni [expr $i]] 1]]
  }
  lset geni [lsort -integer -index 0 $geni]
  puts "\n\n\nafter: $geni\n\n\n"

#  puts "\n\n\n after spaciocc: $geni \n\n\n"

}
