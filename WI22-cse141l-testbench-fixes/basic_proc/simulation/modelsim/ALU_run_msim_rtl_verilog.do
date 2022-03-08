transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/johna/Desktop/Angelica-CSE141L/CSE-141L-Project/WI22-cse141l-testbench-fixes/basic_proc {C:/Users/johna/Desktop/Angelica-CSE141L/CSE-141L-Project/WI22-cse141l-testbench-fixes/basic_proc/Definitions.sv}
vlog -sv -work work +incdir+C:/Users/johna/Desktop/Angelica-CSE141L/CSE-141L-Project/WI22-cse141l-testbench-fixes/basic_proc {C:/Users/johna/Desktop/Angelica-CSE141L/CSE-141L-Project/WI22-cse141l-testbench-fixes/basic_proc/ALU.sv}

