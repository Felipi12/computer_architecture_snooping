transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/CEFET/Materias/AOC2/LAOC2/pratica4/computer_architecture_snooping/parte1/parte1maq1 {C:/Users/felip/Desktop/CEFET/Materias/AOC2/LAOC2/pratica4/computer_architecture_snooping/parte1/parte1maq1/parte1maq1.v}

