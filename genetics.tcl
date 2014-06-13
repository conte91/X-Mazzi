proc genetics {arrivalTime {effortOpt low}} {

  set starttime [ clock seconds ]

  set tokeep 3
  set togenerate 20

  #Effort
  set mode 0
  if {[string compare $effortOpt "high"]==0} {
    puts "High effort mode (take a coffee)"
    set mode 1 
  }

  expr {srand(60)} 

  #Initialize list of possible cells
  set cells {}
  foreach_in_collection name [get_cells] {
    lappend cells [get_attribute $name full_name]
  } 
  set count [llength $cells]
  puts "Optimizing $count cells with $togenerate individuals per generation...\n"
  
  #Initialize starting value and evaluate starting power
  set lagrazianoisready 0
  while {$lagrazianoisready == 0} {
    redirect -variable powa {report_power} 
    set lagrazianoisready [regexp -- "Cell Leakage Power\\s+=\\s+\(\[0-9.\]+\)\\s+.*\(\[munp\]\)W.*$" "$powa" c  b unit]
    switch $unit m { set b [expr $b * 1000000] } u { set b [expr $b * 1000] } n { set b $b } p { set b [expr $b / 1000 ] }
  }
  set startpower $b

  #Initialize vector
  set geni {}
  for { set i 0 } { $i < $togenerate } { incr i } {
    lappend geni  {0 0}
  }
  set geni [paciocca $geni $togenerate $count 0 $togenerate 1]
  for { set i 0 } { $i < $togenerate } { incr i } {
    lset geni  $i 0  [mazziPowa [lindex [lindex $geni $i] 1] $cells $arrivalTime]
  }

  set niterations 50

  if { $count < 100 } {
    set niterations 100
  } else {
    set niterations $count
  }

  set oldmax 0
  set newmax 0

  set count 0

  for { set j 0 } { $j < $niterations && ($mode==1 || $count < 20 || $j < 50)} { incr j } {

    for { set i $tokeep } { $i < $togenerate } { incr i } {
      lset geni  $i 0  [mazziPowa [lindex [lindex $geni $i] 1] $cells $arrivalTime]
    }

    set geni [lsort -real -index 0 $geni]

    set oldmax $newmax
    set newmax [lindex [lindex $geni 0] 0]

    if { $newmax == $oldmax } {
      incr count
    } else {
      set count 0
    }
    puts "Oldmax: $oldmax Newmax: $newmax"

    puts "Running at iteration $j with best leakage of [lindex [lindex $geni 0] 0]..."
    set geni [paciocca $geni $togenerate $count $tokeep 4 1 ]
  }

  #Sort again the individuals
  for { set i 0 } { $i < [llength $geni] } { incr i } {
    lset geni  $i 0  [mazziPowa [lindex [lindex $geni [expr $i]] 1] $cells $arrivalTime] 
  }

  lset geni [lsort -real -index 0 $geni]
  
  #Reset the circuit to the final vth values
  set finalpowa [ mazziPowa [lindex [lindex $geni 0] 1] $cells $arrivalTime]

  puts "Finished. New leakage of [lindex [lindex $geni $i] 0]."

  set power_savings [expr 100.0*(1.0 - $finalpowa / $startpower)]
  set exTime [expr [clock seconds] - $starttime]
  
  #Initialize starting value and evaluate starting power
  set lagrazianoisready 0
  while {$lagrazianoisready == 0} {
    redirect -variable powa {report_threshold_voltage_group} 
    set lagrazianoisready [regexp -- "HVT\\s+\[0-9\]+\\s+\\\(\[0-9.\]+\\\)%\\s.*$" "$powa" c  b percentageH]
    puts "waiting for voltage report to finish.. $lagrazianoisready\n"
  }

  set lagrazianoisready 0
  while {$lagrazianoisready == 0} {
    redirect -variable powa {report_threshold_voltage_group} 
    set lagrazianoisready [regexp -- "LVT\\s+\[0-9\]+\\s+\(\[0-9.\]+\)%\\s.*$" "$powa" c percentageL]
    puts "waiting for voltage report to finish.. $lagrazianoisready\n"
  }
  return { $power_savings $exTime $percentageL $percentageH }

}
