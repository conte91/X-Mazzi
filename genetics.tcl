proc genetics { } {
  set tokeep 4
  set togenerate 20
  expr {srand(60)} 

  puts "\n\n\n\n"
  report_power
  puts "\n\n\n"
  #Initialize list of possible cells
  set cells {}
  foreach_in_collection name [get_cells] {
    lappend cells [get_attribute $name full_name]
  } 
  puts $cells
  set count [llength $cells]

  #Initialize vector
  set geni {}
  for { set i 0 } { $i < $count } { incr i } {
    #puts "Executing $i"
    #puts [lindex $geni [expr $i]]
    lappend geni  {0 0}
  }
  puts $geni
  set geni [paciocca $geni $togenerate $count 0 $togenerate 1]

  for { set j 0 } { $j < 600 } { incr j } {
    for { set i 0 } { $i < $count } { incr i } {
      #puts "Executing $i"
      #puts [lindex $geni [expr $i]]
      lset geni  $i 0  [mazziPowa [lindex [lindex $geni [expr $i]] 1] $cells]
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
    lset cells $i 
  }
  lset geni [lsort -integer -index 0 $geni]
  puts "\n\n\nafter: $geni\n\n\n"
  puts "\n\n\n\n"
  report_power
  puts "\n\n\n"

}
