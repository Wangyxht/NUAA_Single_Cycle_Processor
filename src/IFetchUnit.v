`include "PC.v"
`include "NPC.v"
`include "InstrucionMemory.v"
module IFetch_Unit206(input clk,          
                      input rst,
                      input Branch,       
                      input Jump,
                      input Zero,
                      input OverFlow,
                      input Sign,
                      input Rtype_J,
                      input[6-1:0] OP,
                      input[5-1:0] BranchFlag,
                      input[16-1:0] Imm16,
                      input[26-1:0] J_Target,
                      input[32-1:0] RJ_Addr,
                      output[32-1:0] Link_Addr,
                      output[32-1:0] Instruction);
    wire[32-1:2] PC_cur;
    wire[32-1:2] NPC_next;
    wire[32-1:2] PC_input_Addr;
    wire[32-1:2] I_Addr;

    assign Link_Addr = {PC_cur + 1'b1, 2'b00};

    //PC下地址来源数据选择器
    MUX206 #30 MUX_PCSrc(
        .A(RJ_Addr[32-1:2]),
        .B(NPC_next),
        .S(Rtype_J),
        .Y(PC_input_Addr)
    );

    //下地址逻辑
    NPC206 NPC(
        .Jump(Jump),                //跳转控制
        .Branch(Branch),            //分支控制
        .Zero(Zero),                //ALU结果是否为0
        .Sign(Sign),
        .OverFlow(OverFlow),
        .OP(OP),
        .BranchFlag(BranchFlag),
        .PC_Addr(PC_cur),           //PC地址输入
        .Imm16(Imm16),              //Branch 16位立即数
        .J_Target(J_Target),        //J指令立即数
        .I_Addr(I_Addr),            //当前地址输出
        .Next_I_Addr(NPC_next)       //输出下一条指令地址
    );

    //PC寄存器
    PC206 PC(
        .clk(clk),              //时钟信号
        .rst(rst),              //复位端
        .Next_I_Addr(PC_input_Addr),  //下一指令地址输入
        .I_Addr(PC_cur)         //当前指令地址输出
    );

    //指令存储器
    IM_4K_206 Im(
        .Addr(I_Addr[11:2]),        //PC地址
        .Dout(Instruction)          //输出指令
    );

      
endmodule
