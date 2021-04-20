onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /parte2/clock
add wave -noupdate /parte2/Instruc
add wave -noupdate -radix binary -childformat {{{/parte2/step[1]} -radix binary} {{/parte2/step[0]} -radix binary}} -subitemconfig {{/parte2/step[1]} {-height 15 -radix binary} {/parte2/step[0]} {-height 15 -radix binary}} /parte2/step
add wave -noupdate {/parte2/cache1/memory[0]}
add wave -noupdate {/parte2/cache1/memory[1]}
add wave -noupdate {/parte2/cache1/memory[2]}
add wave -noupdate {/parte2/cache2/memory[0]}
add wave -noupdate {/parte2/cache2/memory[1]}
add wave -noupdate {/parte2/cache2/memory[2]}
add wave -noupdate {/parte2/Memo/memory[0]}
add wave -noupdate {/parte2/Memo/memory[1]}
add wave -noupdate {/parte2/Memo/memory[2]}
add wave -noupdate {/parte2/Memo/memory[5]}
add wave -noupdate {/parte2/cache1/memory[3]}
add wave -noupdate {/parte2/cache2/memory[3]}
add wave -noupdate {/parte2/Memo/memory[3]}
add wave -noupdate {/parte2/Memo/memory[4]}
add wave -noupdate {/parte2/Memo/memory[6]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3413 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {942 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/parte2/clock 
wave create -driver freeze -pattern constant -value 0000000000 -range 9 0 -starttime 0ps -endtime 300ps sim:/parte2/Instruc 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 0010000000 -range 9 0 -starttime 300ps -endtime 600ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1010000101 -range 9 0 -starttime 600ps -endtime 900ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1000000111 -range 9 0 -starttime 900ps -endtime 1200ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0010000000 -range 9 0 -starttime 1200ps -endtime 1500ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0010100000 -range 9 0 -starttime 1500ps -endtime 1800ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1010011001 -range 9 0 -starttime 1800ps -endtime 2100ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1001011000 -range 9 0 -starttime 2100ps -endtime 2400ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1011010110 -range 9 0 -starttime 2400ps -endtime 2700ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2700ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2700ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 10ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2700ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2700ps Edit:/parte2/clock 
wave modify -driver freeze -pattern constant -value 0000000000 -range 9 0 -starttime 100ps -endtime 400ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 3600ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 100ps -dutycycle 50 -starttime 0ps -endtime 3600ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 3600ps Edit:/parte2/clock 
wave modify -driver freeze -pattern constant -value 0000000000 -range 9 0 -starttime 0ps -endtime 350ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0000000000 -range 9 0 -starttime 0ps -endtime 350ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0010000000 -range 9 0 -starttime 350ps -endtime 750ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1010000101 -range 9 0 -starttime 750ps -endtime 1150ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1000000111 -range 9 0 -starttime 1150ps -endtime 1550ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0010000000 -range 9 0 -starttime 1550ps -endtime 1950ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 0010100000 -range 9 0 -starttime 1950ps -endtime 2350ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1010011001 -range 9 0 -starttime 2350ps -endtime 2750ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1001011000 -range 9 0 -starttime 2750ps -endtime 3150ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern constant -value 1011010110 -range 9 0 -starttime 3150ps -endtime 3550ps Edit:/parte2/Instruc 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 3550ps Edit:/parte2/clock 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 3550ps Edit:/parte2/clock 
WaveCollapseAll -1
wave clipboard restore
