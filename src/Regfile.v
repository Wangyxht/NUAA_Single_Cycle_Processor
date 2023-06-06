module Regfile206(input clk,                //时钟信号
                  input[5-1:0] Rw,          //写入地址
                  input[5-1:0] Ra,          //A输出地址
                  input[5-1:0] Rb,          //B输出地址
                  input WrEn,               //写使能信号
                  input Jal,                //Jal控制信号
                  input[32-1:0] busW,       //写入总线
                  output[32-1:0] busA,      //A输出总线
                  output[32-1:0] busB);     //B输出总线

    reg[32-1:0] Register[32-1:0];

    assign busA = Register[Ra];
    assign busB = Register[Rb];

    always @(posedge clk) begin
        if(WrEn == 1)begin
            if(Jal == 1)begin
                Register[5'd31] <= busW;
            end
            else begin
                Register[Rw] <= busW;
            end
        end
    end
    
    initial begin
        $readmemh("RegInit.txt",Register);
    end

endmodule
