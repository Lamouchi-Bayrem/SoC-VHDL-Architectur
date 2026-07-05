# Basys3 constraint template
# Adapt pins depending on your exact design I/O mapping.

## Clock signal
#set_property PACKAGE_PIN W5 [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk]

## Reset
#set_property PACKAGE_PIN U18 [get_ports reset]
#set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Note:
# The current top-level entity exposes internal data/address buses.
# For real FPGA implementation, create a board wrapper mapping buses to switches/LEDs/UART/debug pins.
