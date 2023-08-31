module ALU206 (input[5-1:0] ALUCtr,     // ALU控制信号
               input[32-1:0] A,         // busA 
               input[32-1:0] B,         // B端信号
               input[5-1:0] shamt,      // 移位数
               output reg[32-1:0] result,   // 输出结果
               output reg OverFlow,         // 溢出标志
               output reg Zero,             // 零标志
               output reg Sign);            // 符号标志


    reg[32:0] temp;
    integer t1;
    integer t2;

    always @(*) begin
        case(ALUCtr)
            5'd0:begin          // add 00000
                temp <= {A[31],A[31:0]} + {B[31],B[31:0]};            
                result <= A + B;
                t1 = temp[32:0];
                t2 = temp[31:0];
                OverFlow <= (t1 != t2);
            end 
            5'd1:begin          // addu 00001
                result   <= A + B;
                OverFlow <= 0;
            end 
            5'd2:begin          // sub 00010
                temp <= {A[31],A[31:0]} - {B[31],B[31:0]};
                result <= A - B;
                t1 = temp[32:0];
                t2 = temp[31:0];
                OverFlow <= (t1 != t2);
            end
            5'd3:begin          // subu 00011
                result   <= A - B;
                OverFlow <= 0;
            end 
            5'd4:begin          // and 00100 
                result <= A & B;
                OverFlow <= 0;
            end 
            5'd5:begin          // or 00101 
                result <= A | B;
                OverFlow <= 0;
            end 
            5'd6:begin          // xor 00110
                result <= A ^ B;
                OverFlow <= 0;
            end 
            5'd7:begin          // not 00111
                result <= ~ A;
                OverFlow <= 0;
            end 
            5'd8:begin          // sll 01000
                result <= B << shamt;
                OverFlow <= 0;
            end 
            5'd9:begin          // srl 01001
                result <= B >> shamt;
                OverFlow <= 0;
            end     
            5'd10:begin         // sla 01010 (abandoned)
                result <= $signed(B) <<< shamt;
                OverFlow <= 0;
            end     
            5'd11:begin         // sra 01011
                result <= $signed(B) >>> shamt;
                OverFlow <= 0;
            end
            5'd12:begin         // compare signed 01100 (set less than)
                result <= ($signed(A) < $signed(B));
                OverFlow <= 0;
            end    
            5'd13:begin         // compare unsigned 01101   
                result <= (A < B);
                OverFlow <= 0;
            end 
            5'd14:begin         // nor 01110
                result <= ~(A | B);
                OverFlow <= 0;
            end
            5'd15:begin         // sllv 01111 (shift left by variable)
                result <= B << A;
                OverFlow <= 0;
            end
            5'd16:begin         // srlv 10000 (shift right by variable)
                result <= B >> A;
                OverFlow <= 0;
            end
            5'd17:begin         // slav 10001 (abandoned) 
                result <= $signed(B) <<< A;
                OverFlow <= 0;
            end
            5'd18:begin         // srav 10010 
                result <= $signed(B) >>> A;
                OverFlow <= 0;
            end
            5'd30:begin         //none B 11110
                result   <= B;
                OverFlow <= 0;
            end
            5'd31:begin         //none A 11111
                result   <= A;
                OverFlow <= 0;
            end
            default: begin
                result <= 8'd0;
                OverFlow <= 0;
                Zero <= 0;
            end
        endcase

    // ZF
        if (result == 0) Zero <= 1;
        else Zero <= 0;

    //SF
        if ($signed(result) >= 0) Sign <= 0;
        else Sign <= 1;
    end
endmodule
