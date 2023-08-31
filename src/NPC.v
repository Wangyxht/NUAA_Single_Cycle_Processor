`include "MUX.v"
`include "ExtUnit.v"
`include "BranchCtrUnit.v"
module NPC206(input Jump,
              input Branch,
              input Zero,
              input Sign,
              input OverFlow,
              input[6-1:0] OP,
              input[5-1:0] BranchFlag,
              input[31:2] PC_Addr,
              input[16-1:0] Imm16,
              input[26-1:0] J_Target,
              output[31:2] I_Addr,
              output[31:2] Next_I_Addr);
    
    wire[31:2] PC_Plus_4;
    wire[31:2] J_Addr;
    wire[31:2] B_Addr;
    wire[31:2] imm16_Ext;
    wire[31:2] Y1;
    wire[31:2] Y2;
    wire BranchControl;
    assign PC_Plus_4 = PC_Addr + 1'b1;
    assign B_Addr = imm16_Ext + PC_Addr;
    assign I_Addr = PC_Addr;
    assign J_Addr = {PC_Addr[31:28],J_Target};

    ExtUnit_NPC_206 SEXT(
        .in(Imm16[15:0]),
        .ExtOp(1'b1), 
        .out(imm16_Ext[31:2])
    );

    Branch_Control_Unit_206 Branch_Control_Uint(
        .Branch(Branch),
        .Zero(Zero),
        .Sign(Sign),
        .OverFlow(OverFlow),
        .OP(OP),
        .BranchFlag(BranchFlag),
        .BranchCtr(BranchControl)
    );

    MUX206 #30 MUX_B(
        .A(B_Addr),
        .B(PC_Plus_4),
        .S(BranchControl),
        .Y(Y1)
    );

    MUX206 #30 MUX_J(
        .A(J_Addr),
        .B(Y1),
        .S(Jump),
        .Y(Y2)
    );
    
    assign Next_I_Addr = Y2;
endmodule
