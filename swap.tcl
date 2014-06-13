proc cells_swapping (name vth) {
  set celltype [get_attr [get_cell my_design/core/dsp/counter_reg_1_1] ref_name]
  puts ${celltype}
}
