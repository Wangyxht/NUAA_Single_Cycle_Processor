module DM_4K_206(input clk,             //时钟控制信号
                 input WrEn,            //写使能
                 input WrByte,          //字节写使能
                 input[11:0] Addr,      //数据地址
                 input[31:0] Din,       //数据访问输出端口
                 output[31:0] Dout,     //数据输出
                 output[7:0] ByteDout); //字节输出
    reg[7:0] DM[1023:0];
    assign Dout = {DM[Addr + 3], DM[Addr + 2], DM[Addr + 1], DM[Addr + 0]};
    assign ByteDout = DM[Addr];
    always @(posedge clk) begin
        if (WrEn) begin
            if(WrByte) begin
                DM[Addr + 0] <= Din[7:0];
            end
            else begin
                DM[Addr + 0] <= Din[7:0];
                DM[Addr + 1] <= Din[15:8];
                DM[Addr + 2] <= Din[23:16];
                DM[Addr + 3] <= Din[31:24];
            end

        end
    end
endmodule
