# Control Unit

The control unit is implemented as an FSM named `sequenceurSOC`.

## States

- `INIT`
- `FETCH`
- `EXECUTE`
- `STOP`

## Main control signals

- `raz`: reset internal registers
- `selA`: selects address source
- `selB`: selects ALU B input
- `acc_ld`: loads accumulator
- `pc_ld`: loads program counter
- `ir_ld`: loads instruction register
- `acc_oe`: enables accumulator output on data bus
- `alufs`: selects ALU operation
- `memrq`: memory request
- `rnw`: read/not-write
