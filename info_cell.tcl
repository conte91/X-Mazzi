set cell_list_name ""
set cell_ref_name ""
set cell_list_area ""
set cell_list_leakage ""
set cell_list_dynamic ""
set cell_list_type ""
set big_list ""
set chip_leakage 0
set chip_dynamic 0

foreach_in_collection point_cell [get_cells] {
  set cell_name [get_attribute $point_cell full_name ]
  set cell_refname [get_attribute $point_cell ref_name ]
  set cell_area [get_attribute $point_cell area ]
  set cell_leakage [get_attribute $point_cell leakage_power ]
  set cell_dynamic [get_attribute $point_cell dynamic_power ]
  set cell_type [get_attribute $point_cell is_combinational]
  if { $cell_type == true } {
    puts "$cell_name is combinational"
    lappend big_list [list ${cell_name} ${cell_refname} ${cell_area} ${cell_leakage} ${cell_dynamic} ]
  } else {
    puts "$cell_name is not combinational"
  }
}

set big_list [lsort -real -index 3 ${big_list}]
foreach item $big_list {
  lappend cell_list_name [lindex $item 0]
  lappend cell_ref_name [lindex $item 1]
  lappend cell_list_area [lindex $item 2]
  lappend cell_list_leakage [lindex $item 3]
  lappend cell_list_dynamic [lindex $item 4]
  lappend cell_list_type [lindex $item 5]

  set chip_leakage [ expr $chip_leakage + [lindex $item 3] ]
  set chip_dynamic [ expr $chip_dynamic + [lindex $item 4] ]
}

