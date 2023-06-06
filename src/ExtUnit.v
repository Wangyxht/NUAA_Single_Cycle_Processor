module ExtUnit_NPC_206 (input [16-1:0] in,
                        input ExtOp,
                        output [30-1:0] out);
    
    reg[30-1:0] out_t;
    always @(*)
    begin
        if (ExtOp == 1) begin
            out_t[15:0]     = in[15:0];
            if (in[15] == 1'b1) out_t[30-1:16]      = 16'hffff;
            else if (in[15] == 1'b0) out_t[30-1:16] = 16'h0000;
        end
        else if (ExtOp == 0) begin
            out_t[15:0]    = in[15:0];
            out_t[30-1:16] = 16'h0000;
        end
    end
            
    assign out = out_t;
            
endmodule

module ExtUnit_DataPath_206 (input [16-1:0] in,
                             input [2-1:0] ExtOp,
                             output [32-1:0] out);
    
    reg[32-1:0] out_t;
    always @(*)
    begin
        if (ExtOp == 2'b01) begin
            out_t[15:0]     = in[15:0];
            if (in[15] == 1'b1) out_t[32-1:16]      = 16'hffff;
            else if (in[15] == 1'b0) out_t[32-1:16] = 16'h0000;
        end
        else if (ExtOp == 2'b00) begin
            out_t[15:0]    = in[15:0];
            out_t[32-1:16] = 16'h0000;
        end
        else if(ExtOp == 2'b10) begin
            out_t[32-1:16] = in[15:0];
            out_t[15:0] = 16'h0000;
        end
    end
            
    assign out = out_t;
            
endmodule

module ExtUnit_LB_206 (input [8-1:0] in,
                        input ExtOp,
                        output [32-1:0] out);
    
    reg[32-1:0] out_t;
    always @(*)
    begin
        if (ExtOp == 1) begin
            out_t[7:0]     = in[7:0];
            if (in[7] == 1'b1) out_t[32-1:8]      = 32'hffffffff;
            else if (in[7] == 1'b0) out_t[32-1:8] = 32'h00000000;
        end
        else if (ExtOp == 0) begin
            out_t[7:0]    = in[7:0];
            out_t[32-1:8] = 32'h0000;
        end
    end
            
    assign out = out_t;
            
endmodule