#!/usr/bin/env bash
set -e

mkdir -p sim/waveforms
rm -f work-obj*.cf

VHDL_FILES="
src/tristate/p3e.vhd
src/mux/mux.vhd
src/alu/alu.vhd
src/registers/acc.vhd
src/registers/pc.vhd
src/registers/ir.vhd
src/sequencer/sequenceurSOC.vhd
src/memory/mem.vhd
src/top/mu.vhd
src/top/projet.vhd
"

for f in $VHDL_FILES; do
  ghdl -a --std=08 $f
done

for tb in p3e_tb mux_tb alu_tb acc_tb pc_tb ir_tb bench_projet; do
  ghdl -a --std=08 sim/testbenches/${tb}.vhd
  ghdl -e --std=08 $tb
  ghdl -r --std=08 $tb --vcd=sim/waveforms/${tb}.vcd --stop-time=2us
done

echo "All simulations passed."
