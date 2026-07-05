# Instruction Set

Instruction format:

```text
15          12 11                         0
+-------------+----------------------------+
|   opcode    |          address           |
+-------------+----------------------------+
```

| Opcode | Mnemonic | Operation |
| ------ | -------- | --------- |
| 0000 | LDA addr | ACC <= MEM[addr] |
| 0001 | STO addr | MEM[addr] <= ACC |
| 0010 | ADD addr | ACC <= ACC + MEM[addr] |
| 0011 | SUB addr | ACC <= ACC - MEM[addr] |
| 0100 | JMP addr | PC <= addr |
| 0101 | JGE addr | if ACC(15)=0 then PC <= addr |
| 0110 | JNE addr | if ACC != 0 then PC <= addr |
| 0111 | STOP | Stop execution |
| 1000 | AND addr | ACC <= ACC AND MEM[addr] |
| 1001 | OR addr | ACC <= ACC OR MEM[addr] |
| 1010 | XOR addr | ACC <= ACC XOR MEM[addr] |

## Example Encoding

```text
LDA 0x010  -> 0x0010
ADD 0x011  -> 0x2011
STO 0x012  -> 0x1012
STOP       -> 0x7000
```
