`include "DataPath.v"
`include "ControlUnit.v"
module CPU206(input rst,
              input clk);
    //指令字
    wire[32-1:0] Instruction;

    // 指令控制信号
    wire Jump ;
    wire Branch ;
    wire RegDst ;
    wire ALUSrc ;
    wire[5-1:0] ALUCtr ;
    wire MemToReg ;
    wire RegWr ;
    wire MemWr ;
    wire[2-1:0] ExtOp ;
    wire Rtype ;
    wire Jal;
    wire Rtype_J;
    wire Rtype_L;
    wire WrByte;
    wire[2-1:0] LoadByte;

    DataPath206 DataPath(   //数据通路
        .clk(clk),                  //时钟信号
        .rst(rst),                  //重置
        .Branch(Branch),            //分支信号
        .Jump(Jump),                //跳转信号
        .RegDst(RegDst),            //寄存器目标选择信号
        .ALUSrc(ALUSrc),            //ALU数据源信号
        .ALUCtr(ALUCtr),            //ALU控制信号
        .MemToReg(MemToReg),        //内存->寄存器访问信号
        .RegWr(RegWr),              //寄存器写访问信号
        .MemWr(MemWr),              //内存写访问信号
        .ExtOp(ExtOp),              //扩展立即数控制信号
        .Rtype(Rtype),              //R型指令信号（弃用）
        .Jal(Jal),                  //JAL控制信号
        .Rtype_J(Rtype_J),          //R型J指令控制信号
        .Rtype_L(Rtype_L),          //R型Link控制信号
        .WrByte(WrByte),            //写字节信号
        .LoadByte(LoadByte),        //读字节信号
        .Instruction(Instruction)   //指令输入
    );

    Control_Unit206 ControlUnit( //指令控制单元（解码器）
        .Instruction(Instruction),  //指令输入
        .Branch(Branch),
        .Jump(Jump),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .ALUCtr(ALUCtr[5-1:0]),
        .MemToReg(MemToReg),
        .RegWr(RegWr),
        .MemWr(MemWr),
        .ExtOp(ExtOp),
        .Rtype(Rtype),
        .Jal(Jal),
        .Rtype_J(Rtype_J),
        .Rtype_L(Rtype_L),
        .WrByte(WrByte),
        .LoadByte(LoadByte)
    );
endmodule