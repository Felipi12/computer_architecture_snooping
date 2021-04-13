onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /parte1maq1/clock
add wave -noupdate /parte1maq1/SW
add wave -noupdate /parte1maq1/estado
add wave -noupdate /parte1maq1/mensagem
add wave -noupdate /parte1maq1/action
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {81 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 189
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {800 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/parte1maq1/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 1000ps sim:/parte1maq1/SW 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 10 -range 1 0 -starttime 0ps -endtime 100ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 01 -endvalue 11 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 100ps -endtime 400ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 00 -endvalue 01 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 600ps -endtime 800ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 10 -endvalue 11 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 800ps -endtime 1000ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern constant -value 00 -range 1 0 -starttime 0ps -endtime 100ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 00 -endvalue 01 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 100ps -endtime 300ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 01 -endvalue 11 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 400ps -endtime 700ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern constant -value 00 -range 1 0 -starttime 700ps -endtime 800ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern constant -value 10 -range 1 0 -starttime 0ps -endtime 100ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 01 -endvalue 11 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 100ps -endtime 400ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern constant -value 00 -range 1 0 -starttime 400ps -endtime 600ps Edit:/parte1maq1/SW 
wave modify -driver freeze -pattern counter -startvalue 01 -endvalue 10 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 1 0 -starttime 600ps -endtime 800ps Edit:/parte1maq1/SW 
WaveCollapseAll -1
wave clipboard restore
