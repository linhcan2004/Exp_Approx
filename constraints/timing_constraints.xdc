# CLOCK SIGNAL (100MHz)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# SWITCHES (Dung 8 Switch SW0 -> SW7)
# Port name trong VHDL: sw (8 bit)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN F22 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[0]}]

set_property PACKAGE_PIN G22 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[1]}]

set_property PACKAGE_PIN H22 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[2]}]

set_property PACKAGE_PIN F21 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[3]}]

set_property PACKAGE_PIN H19 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[4]}]

set_property PACKAGE_PIN H18 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[5]}]

set_property PACKAGE_PIN H17 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[6]}]

set_property PACKAGE_PIN M15 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sw[7]}]

# LEDs (Dung 8 LED LD0 -> LD7)
# Port name trong VHDL: led (8 bit)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN T22 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property PACKAGE_PIN T21 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property PACKAGE_PIN U22 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]

set_property PACKAGE_PIN U21 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]

set_property PACKAGE_PIN V22 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]

set_property PACKAGE_PIN W22 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]

set_property PACKAGE_PIN U19 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]

set_property PACKAGE_PIN U14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

# BUTTONS (Nut bam dieu khien)
# ----------------------------------------------------------------------------

# Nut Center (BTNC) -> Start
set_property PACKAGE_PIN P16 [get_ports start]
set_property IOSTANDARD LVCMOS25 [get_ports start]

# Nut Up (BTNU) -> Reset
set_property PACKAGE_PIN T18 [get_ports reset]
set_property IOSTANDARD LVCMOS25 [get_ports reset]

# Nut Right (BTNR) -> Page Scroll (Xem 8 bit thap)
# Khi giu nut nay, den LED se hien thi phan thap phan chi tiet
set_property PACKAGE_PIN R18 [get_ports btn_page]
set_property IOSTANDARD LVCMOS25 [get_ports btn_page]

set_property PACKAGE_PIN Y11 [get_ports {done}]
set_property IOSTANDARD LVCMOS33 [get_ports {done}]
