module IM_4K_206(input[11:2] Addr,            //指令地址
                 output[32-1:0] Dout);         //指令输出
    reg[32-1:0] IM[1024-1:0];
    assign Dout = IM[Addr];
    initial begin
        //$readmemh("Code_7.txt",IM);
        $readmemb("./Code_36.txt",IM);
    end

endmodule
