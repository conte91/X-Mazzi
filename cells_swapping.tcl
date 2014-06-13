#cells_swapping {U12132} LVT

proc cells_swapping {cellName_list Vt_type} {

  puts $cellName_list

	foreach cellname $cellName_list {
		set alternatives [get_alternative_lib_cells $cellname]
		#foreach_in_collection name $alternatives {
	       		#puts "$name"
	    		#}

	  	if {[string compare $Vt_type "LVT"] == 0} {

			set refname [get_attribute $cellname ref_name]

			set fullname "CORE65LPLVT_nom_1.00V_25C.db:"
			append fullname "CORE65LPLVT/"
            		append fullname $refname
	    		regsub -- {_LH_} $fullname "_LL_" fullname2
	    		regsub -- {_LHS_} $fullname "_LLS_" fullname2			
	    		#regsub -- {_LH_|_LHS_} $fullname "_LL_|_LLS_" fullname2			

			puts -nonewline "Switching to "
			puts $fullname2

			size_cell $cellname $fullname ;# E.G.: size_cell U12519 CORE65LPHVT_nom_1.00V_25C.db:CORE65LPHVT/HS65_LH_BFX4

      puts "Cazzi"
			return

	  	}

#{}
	  	if {[string compare $Vt_type "HVT"] == 0} {

			set refname [get_attribute $cellname ref_name]

			set fullname "CORE65LPHVT_nom_1.00V_25C.db:"
			append fullname "CORE65LPHVT/"
            		append fullname $refname
	    		regsub -- {_LL_} $fullname "_LH_" fullname2
	    		regsub -- {_LLS_} $fullname "_LHS_" fullname2			

			puts -nonewline "Switching to "
			puts $fullname2

			size_cell $cellname $fullname ;# E.G.: size_cell U12519 CORE65LPHVT_nom_1.00V_25C.db:CORE65LPHVT/HS65_LH_BFX4

      puts "Cazzi"
			return

	  	}

 	}

}
