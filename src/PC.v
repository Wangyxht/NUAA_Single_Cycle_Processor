module PC206(input clk,
             input rst,
             input[31:2] Next_I_Addr,
             output reg[31:2] I_Addr);

    parameter Init_Addr =32'h0000_0000;
    always @(posedge clk) begin
        if (rst == 1) begin
            I_Addr <= Init_Addr[31:2];
        end
        else begin
            I_Addr <= Next_I_Addr;
        end
    end
endmodule
