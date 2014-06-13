proc genetics { } {
  set count [sizeof_collection [  get_cells *]]
  set tokeep 5
  set togenerate 10
  expr {srand(0)} 

  set geni {}
  set geni [paciocca $geni $togenerate $count 0 $togenerate 1]
  puts "before: $geni"

  for { set i 0 } { $i < [llength $geni] } { incr i } {
    puts "Executing $i"
    puts [lindex $geni [expr $i]]
    lset geni  $i 0  [mazzi [lindex [lindex $geni [expr $i]] 1]]
  }

#  puts "\n\n\nbefore: $geni\n\n\n"
  set geni [lsort -index 0 $geni]

   puts "\n\n\nafter: $geni\n\n\n"

  set geni [paciocca $geni $togenerate $count $tokeep 1 1 ]

#  puts "\n\n\n after spaciocc: $geni \n\n\n"

}
