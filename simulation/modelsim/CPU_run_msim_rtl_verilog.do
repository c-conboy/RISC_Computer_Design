transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/and_or.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/ALU.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Add_half.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Add_full.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Add_rca_4.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Add_rca_16.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Add_rca_32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/negate.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/Sub_rca_32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/shift_right.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/shift_left.v}

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/ELEC\ 374/CPUProject {C:/altera/13.0sp1/ELEC 374/CPUProject/ALU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run 500 ns
