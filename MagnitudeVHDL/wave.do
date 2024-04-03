onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /magnitude_tb/clk
add wave -noupdate /magnitude_tb/enable_s
add wave -noupdate /magnitude_tb/reset_s
add wave -noupdate -radix decimal -radixshowbase 0 /magnitude_tb/input_Img
add wave -noupdate -radix decimal -radixshowbase 0 /magnitude_tb/input_Real
add wave -noupdate -radix unsigned -radixshowbase 0 /magnitude_tb/output_Magn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70850000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {432600 ns}
