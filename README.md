# NUAA_Single_Cycle_Processor

 南京航空航天大学计算机组成原理实验——单周期CPU设计

## 指令编码与控制信号清单

### 指令 OP码 func域

#### 1. R型

|  指令  |  add   |  addu  |  sub   |  subu  |  and   |   or   |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| func域 | 100000 | 100001 | 100010 | 100011 | 100100 | 100101 |

|  指令  |  nor   |  xor   |  slt   |  sltu  |  sll   |  srl   |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| func域 | 100111 | 100110 | 101010 | 101011 | 000000 | 000010 |

|  指令  |  sra   |  sllv  |  srlv  |  srav  |   jr   |  jalr  |
| :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| func域 | 000011 | 000100 | 000110 | 000110 | 001000 | 001001 |

注：R型指令OP均为 ```000000```

#### 2. I型

| 指令  |  addi  | addiu  |  ori   |  beq   |   lw   |   sw   |
| :---: | :----: | :----: | :----: | :----: | :----: | :----: |
| OP域  | 001000 | 001001 | 001101 | 000100 | 100011 | 101011 |

| 指令  |  slti  |  lui   |   sb   |   lb   |  lbu   |  bne   |
| :---: | :----: | :----: | :----: | :----: | :----: | :----: |
| OP域  | 001010 | 001111 | 101000 | 100000 | 100100 | 000101 |

| 指令  |  bgtz  |  blez  | sltiu  |  xori  |  andi  |
| :---: | :----: | :----: | :----: | :----: | :----: |
| OP域  | 000111 | 000110 | 001011 | 001110 | 001100 |

#### 3. J型

| 指令  |   J    |  Jal   |
| :---: | :----: | :----: |
| OP域  | 000010 | 000010 |

### 指令控制信号

#### 1. R型指令控制信号表

| 控制信号 |  add  | addu  |  sub  | subu  |  and  |  or   |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   1   |   1   |   1   |   1   |   1   |   1   |
|  AluSrc  |   0   |   0   |   0   |   0   |   0   |   0   |
|  AlUCtr  | 00000 | 00001 | 00010 | 00011 | 00100 | 00101 |
| MemToReg |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegWr   |   1   |   1   |   1   |   1   |   1   |   1   |
|  MemWr   |   0   |   0   |   0   |   0   |   0   |   0   |
|  ExtOp   |   X   |   X   |   X   |   X   |   X   |   X   |
|  Rtype   |   1   |   1   |   1   |   1   |   1   |   1   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   0   |
|  Wrbyte  |   0   |   0   |   0   |   0   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  00   |  00   |

| 控制信号 |  nor  |  xor  |  slt  | sltu  |  sll  |  srl  |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   1   |   1   |   1   |   1   |   1   |   1   |
|  AluSrc  |   0   |   0   |   0   |   0   |   0   |   0   |
|  AlUCtr  | 01110 | 00110 | 01100 | 01101 | 01000 | 01001 |
| MemToReg |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegWr   |   1   |   1   |   1   |   1   |   1   |   1   |
|  MemWr   |   0   |   0   |   0   |   0   |   0   |   0   |
|  ExtOp   |   X   |   X   |   X   |   X   |   X   |   X   |
|  Rtype   |   1   |   1   |   1   |   1   |   1   |   1   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   0   |
|  Wrbyte  |   0   |   0   |   0   |   0   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  00   |  00   |

| 控制信号 |  sra  | sllv  | srlv  | srav  |  jr   | jalr  |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   1   |   1   |   1   |   1   |   0   |   1   |
|  AluSrc  |   0   |   0   |   0   |   0   |   0   |   0   |
|  AlUCtr  | 01011 | 01111 | 10000 | 10010 | 11111 | 11111 |
| MemToReg |   0   |   0   |   0   |   0   |   X   |   0   |
|  RegWr   |   1   |   1   |   1   |   1   |   0   |   1   |
|  MemWr   |   0   |   0   |   0   |   0   |   0   |   0   |
|  ExtOp   |   X   |   X   |   X   |   X   |   X   |   X   |
|  Rtype   |   1   |   1   |   1   |   1   |   1   |   1   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   1   |   1   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   1   |
|  Wrbyte  |   0   |   0   |   0   |   0   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  00   |  00   |

#### 2. I型指令控制信号表

| 控制信号 | addi  | addiu |  ori  |  beq  |  lw   |  sw   |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   0   |   0   |   0   |   1   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   0   |   0   |   0   |   X   |   0   |   X   |
|  AluSrc  |   1   |   1   |   1   |   0   |   1   |   1   |
|  AlUCtr  | 00000 | 00001 | 00101 | 00010 | 00001 | 00001 |
| MemToReg |   0   |   0   |   0   |   X   |   1   |   X   |
|  RegWr   |   1   |   1   |   1   |   0   |   1   |   0   |
|  MemWr   |   0   |   0   |   0   |   0   |   0   |   1   |
|  ExtOp   |   1   |   1   |   0   |   X   |   1   |   1   |
|  Rtype   |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   0   |
|  Wrbyte  |   0   |   0   |   0   |   0   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  00   |  00   |

| 控制信号 | slti  | bgez  |  lui  |  sb   |  lb   |  lbu  |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   0   |   1   |   0   |   0   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   0   |   X   |   0   |   0   |   0   |   0   |
|  AluSrc  |   1   |   0   |   0   |   1   |   1   |   1   |
|  AlUCtr  | 01100 | 11111 | 11110 | 00001 | 00001 | 00001 |
| MemToReg |   0   |   X   |   0   |   0   |   1   |   1   |
|  RegWr   |   1   |   0   |   1   |   0   |   1   |   1   |
|  MemWr   |   0   |   0   |   0   |   1   |   0   |   0   |
|  ExtOp   |   1   |   X   |  10   |   1   |   1   |   1   |
|  Rtype   |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   0   |
|  Wrbyte  |   0   |   0   |   0   |   1   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  11   |  10   |

| 控制信号 |  bne  | bgtz  | blez  | sltiu | xori  | andi  |
| :------: | :---: | :---: | :---: | :---: | :---: | :---: |
|  Branch  |   1   |   1   |   1   |   0   |   0   |   0   |
|   Jump   |   0   |   0   |   0   |   0   |   0   |   0   |
|  RegDst  |   0   |   0   |   0   |   0   |   0   |   0   |
|  AluSrc  |   1   |   1   |   1   |   1   |   1   |   1   |
|  AlUCtr  | 00010 | 11111 | 11111 | 01101 | 00110 | 00100 |
| MemToReg |   X   |   X   |   X   |   0   |   0   |   0   |
|  RegWr   |   0   |   0   |   0   |   1   |   1   |   1   |
|  MemWr   |   0   |   0   |   0   |   0   |   0   |   0   |
|  ExtOp   |   X   |   X   |   X   |   1   |   0   |   0   |
|  Rtype   |   0   |   0   |   0   |   0   |   0   |   0   |
|   Jal    |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_J  |   0   |   0   |   0   |   0   |   0   |   0   |
| Rtype_L  |   0   |   0   |   0   |   0   |   0   |   0   |
|  Wrbyte  |   0   |   0   |   0   |   0   |   0   |   0   |
| Loadbyte |  00   |  00   |  00   |  00   |  00   |  00   |

#### 3. J型指令控制信号表

| 控制信号 |   j   |  jal  |
| :------: | :---: | :---: |
|  Branch  |   0   |   0   |
|   Jump   |   1   |   1   |
|  RegDst  |   X   |   X   |
|  AluSrc  |   X   |   X   |
|  AlUCtr  | XXXXX | XXXXX |
| MemToReg |   X   |   X   |
|  RegWr   |   0   |   0   |
|  MemWr   |   0   |   0   |
|  ExtOp   |   X   |   X   |
|  Rtype   |   X   |   X   |
|   Jal    |   0   |   1   |
| Rtype_J  |   0   |   0   |
| Rtype_L  |   0   |   0   |
|  Wrbyte  |   0   |   0   |
| Loadbyte |  00   |  00   |

### 测试代码(基本要求)

####  代码指令

```MIPS
addiu   $1,     $0,     1           
sll     $2,     $1,     4           
addu    $3,     $2,     $1          
srl     $4,     $2,     2           
slti    $25,    $4,     5           
bgez    $25,    16          
subu    $5,     $3,     $4          
sw      $5,     20($0)          
nor     $6,     $5,     $2          
or      $7,     $6,     $3          
xor     $8,     $7,     $6          
sw      $8,     28($0)          
beq     $8,     $3,     2           
slt     $9,     $6,     $7          
addiu   $1,     $0,     8           
lw      $10,    20($1)          
bne     $10,    $5,     4           
and     $11,    $2,     $1          
sw      $11,    28($1)          
sw      $4,     16($1)          
jal     25          
lui     $12,    12          
srav    $26,    $12,    $2          
sllv    $27,    $26,    $1          
jalr    $27         
sb      $26,    5($3)           
sltu    $13,    $3,     $3          
bgtz    $13,    3           
sllv    $14,    $6,     $4          
sra     $15,    $14,    2           
srlv    $16,    $15,    $1          
blez    $16,    8           
srav    $16,    $15, $1             
addiu   $11,    $0,     140             
bltz    $16,    6           
lw      $28,    3($10)          
bne     $28,    $29,    7          
sb      $15,    8($5)           
lb      $18,    8($5)           
lbu     $19,    8($5)           
sltiu   $24,    $15,    0xFFFF          
or      $29,    $12,    $5          
jr      $11                 
andi    $20,    $15,    0xFFFF          
ori     $21,    $15,    0xFFFF          
xori    $22,    $15,    0xFFFF          
j       00H                                 
```

#### 对应指令字

```Verilog
0010_0100_0000_0001_0000_0000_0000_0001 //  addiu   $1,     $0,     1           
0000_0000_0000_0001_0001_0001_0000_0000 //  sll     $2,     $1,     4           
0000_0000_0100_0001_0001_1000_0010_0001 //  addu    $3,     $2,     $1          
0000_0000_0000_0010_0010_0000_1000_0010 //  srl     $4,     $2,     2           
0010_1000_1001_1001_0000_0000_0000_0101 //  slti    $25,    $4,     5           
0000_0111_0010_0001_0000_0000_0001_0000 //  bgez    $25,    16          
0000_0000_0110_0100_0010_1000_0010_0011 //  subu    $5,     $3,     $4          
1010_1100_0000_0101_0000_0000_0001_0100 //  sw      $5,     20($0)          
0000_0000_1010_0010_0011_0000_0010_0111 //  nor     $6,     $5,     $2          
0000_0000_1100_0011_0011_1000_0010_0101 //  or      $7,     $6,     $3          
0000_0000_1110_0110_0100_0000_0010_0110 //  xor     $8,     $7,     $6          
1010_1100_0000_1000_0000_0000_0001_1100 //  sw      $8,     28($0)          
0001_0001_0000_0011_0000_0000_0000_0010 //  beq     $8,     $3,     2           
0000_0000_1100_0111_0100_1000_0010_1010 //  slt     $9,     $6,     $7          
0010_0100_0000_0001_0000_0000_0000_1000 //  addiu   $1,     $0,     8           
1000_1100_0010_1010_0000_0000_0001_0100 //  lw      $10,    20($1)          
0001_0101_0100_0101_0000_0000_0000_0100 //  bne     $10,    $5,     4           
0000_0000_0100_0001_0101_1000_0010_0100 //  and     $11,    $2,     $1          
1010_1100_0010_1011_0000_0000_0001_1100 //  sw      $11,    28($1)          
1010_1100_0010_0100_0000_0000_0001_0000 //  sw      $4,     16($1)          
0000_1100_0000_0000_0000_0000_0001_1001 //  jal     25          
0011_1100_0000_1100_0000_0000_0000_1100 //  lui     $12,    12          
0000_0000_0100_1100_1101_0000_0000_0111 //  srav    $26,    $12,    $2          
0000_0000_0011_1010_1101_1000_0000_0100 //  sllv    $27,    $26,    $1          
0000_0011_0110_0000_1111_1000_0000_1001 //  jalr    $27         
1010_0000_0111_1010_0000_0000_0000_0101 //  sb      $26,    5($3)           
0000_0000_0110_0011_0110_1000_0010_1011 //  sltu    $13,    $3,     $3          
0001_1101_1010_0000_0000_0000_0000_0011 //  bgtz    $13,    3           
0000_0000_1000_0110_0111_0000_0000_0100 //  sllv    $14,    $6,     $4          
0000_0000_0000_1110_0111_1000_1000_0011 //  sra     $15,    $14,    2           
0000_0000_0010_1111_1000_0000_0000_0110 //  srlv    $16,    $15,    $1          
0001_1010_0000_0000_0000_0000_0000_1000 //  blez    $16,    8           
0000_0000_0010_1111_1000_0000_0000_0111 //  srav    $16,    $15, $1             
0010_0100_0000_1011_0000_0000_1000_1100 //  addiu   $11,    $0,     140             
0000_0110_0000_0000_0000_0000_0000_0110 //  bltz    $16,    6           
1000_1101_0101_1100_0000_0000_0000_0011 //  lw      $28,    3($10)          
0001_0111_1001_1101_0000_0000_0000_0111 //  bne     $28,    $29,    7          
1010_0000_1010_1111_0000_0000_0000_1000 //  sb      $15,    8($5)           
1000_0000_1011_0010_0000_0000_0000_1000 //  lb      $18,    8($5)           
1001_0000_1011_0011_0000_0000_0000_1000 //  lbu     $19,    8($5)           
0010_1101_1111_1000_1111_1111_1111_1111 //  sltiu   $24,    $15,    0xFFFF          
0000_0001_1000_0101_1110_1000_0010_0101 //  or      $29,    $12,    $5          
0000_0001_0110_0000_0000_0000_0000_1000 //  jr      $11                 
0011_0001_1111_0100_1111_1111_1111_1111 //  andi    $20,    $15,    0xFFFF          
0011_0101_1111_0101_1111_1111_1111_1111 //  ori     $21,    $15,    0xFFFF          
0011_1001_1111_0110_1111_1111_1111_1111 //  xori    $22,    $15,    0xFFFF          
0000_1000_0000_0000_0000_0000_0000_0000 //  j       00H                                 

```
