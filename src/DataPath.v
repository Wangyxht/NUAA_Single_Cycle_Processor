`include "IFetchUnit.v"
`include "Regfile.v"
`include "DataMemory.v"
`include "ALU.v"
module DataPath206(input clk,
                   input rst,
                   input Branch,
                   input Jump,
                   input RegDst,
                   input ALUSrc,
                   input[5-1:0] ALUCtr,
                   input MemToReg,
                   input RegWr,
                   input MemWr,
                   input[2-1:0] ExtOp,
                   input Rtype,
                   input Jal,
                   input Rtype_J,
                   input Rtype_L,
                   input WrByte,
                   input[2-1:0] LoadByte,
                   input[32-1:0] Link_Addr,
                   output[32-1:0] Instruction);
    //ALU输出标志
    wire OF;
    wire ZF;
    wire SF;

    //寄存器组相关变量
    wire[5-1:0] Rw;//写入寄存器地址
    wire[5-1:0] Rd;
    wire[5-1:0] Rs;
    wire[5-1:0] Rt;
    wire[32-1:0] busA;
    wire[32-1:0] busB;
    wire[32-1:0] busW;


    //16位立即数（I型指令）
    wire[16-1:0] imm16;
    wire[32-1:0] imm16_Ext;

    //LoadByte相关
    wire[32-1:0] Byte_Ext;

    //ALU相关输入与输出
    wire[32-1:0] Data_B_In;
    wire[32-1:0] ALU_result;
    wire[5-1:0] shamt;

    //数据段内存输入与输出
    wire[32-1:0] DM_out;
    wire[8-1:0] DM_Byte_out;
    wire[32-1:0] DM_data_out;
    
    //中间变量
    wire[32-1:0] MUX1_out;

    //分解指令字
    assign Rs = Instruction[25:21];
    assign Rt = Instruction[20:16];
    assign Rd = Instruction[15:11];
    assign imm16 = Instruction[15:0];
    assign shamt = Instruction[10:6];



    //取指令单元
    IFetch_Unit206 IFetchUnit(
        .clk(clk),
        .rst(rst),
        .Branch(Branch),
        .Jump(Jump),
        .Zero(ZF),
        .OverFlow(OF),
        .Sign(SF),
        .Rtype_J(Rtype_J),
        .OP(Instruction[31:26]),
        .BranchFlag(Instruction[20:16]),
        .Imm16(Instruction[15:0]),
        .J_Target(Instruction[25:0]),
        .RJ_Addr(ALU_result),
        .Link_Addr(Link_Addr),
        .Instruction(Instruction)
    );


    //寄存器组写入目标数据选择器MUX_Reg
    MUX206 #5 MUX_Reg(
        .A(Rd),
        .B(Rt),
        .S(RegDst),
        .Y(Rw)
    );
    
    //寄存器组
    Regfile206 Regfile(
        .clk(clk),
        .Rw(Rw),
        .Ra(Rs),
        .Rb(Rt),
        .WrEn(RegWr & (~OF)),
        .Jal(Jal),
        .busW(busW),
        .busA(busA),
        .busB(busB)
    );

    //ALU B端数据来源选择器1(选择imm 16 与 bus B)
    MUX206 MUX_ALU_B(
        .A(imm16_Ext),
        .B(busB),
        .S(ALUSrc),
        .Y(Data_B_In)
    );

    //ALU计算器
    ALU206 ALU(
        .ALUCtr(ALUCtr),
        .A(busA),
        .B(Data_B_In),
        .shamt(shamt),
        .result(ALU_result),
        .OverFlow(OF),
        .Zero(ZF),
        .Sign(SF)  
    );

    //16位立即数扩展器
    ExtUnit_DataPath_206 ExtUnitImm(
        .in(imm16),
        .ExtOp(ExtOp),
        .out(imm16_Ext)
    );

    //数据存储器
    DM_4K_206 DM_4K(
        .clk(clk),
        .WrEn(MemWr),
        .WrByte(WrByte),
        .Addr(ALU_result[11:0]),
        .Din(busB),
        .Dout(DM_out),
        .ByteDout(DM_Byte_out)
    );

    //LB指令对Byte数据扩展
    ExtUnit_LB_206 ExtUnitByte(
        .in(DM_Byte_out),
        .ExtOp(LoadByte[0]),
        .out(Byte_Ext)
    );

    //DM输出类型选择器，选定输出Byte或Word
    MUX206 MUX_ByteData(
        .A(Byte_Ext),
        .B(DM_out),
        .S(LoadByte[1]),
        .Y(DM_data_out)
    );

    //写入寄存器数据来源选择器1 用于选择Mem或ALU来源
    MUX206 MUX_RegWirteSrc(
        .A(DM_data_out),
        .B(ALU_result),
        .S(MemToReg),
        .Y(MUX1_out)
    );

    //写入寄存器数据来源选择器2 用于选择 PC+4 或（ALU/MEM）来源
    MUX206 MUX_LinkSrc(
        .A(Link_Addr),
        .B(MUX1_out),
        .S(Rtype_L || Jal),
        .Y(busW)
    );
        
endmodule
