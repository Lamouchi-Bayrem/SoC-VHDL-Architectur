# Datapath Architecture

The datapath is accumulator-based.

Main elements:

- ACC stores computation results.
- PC stores the program address.
- IR stores opcode and operand address.
- ALU performs arithmetic and logical operations.
- MuxA selects the address bus source: PC or IR address.
- MuxB selects the ALU B input: zero-extended address bus or data bus.
- P3E allows the accumulator to drive the shared data bus during store operations.

## Buses

- Data bus: 16 bits
- Address bus: 12 bits

## Memory space

The 12-bit address bus allows 4096 memory locations.
