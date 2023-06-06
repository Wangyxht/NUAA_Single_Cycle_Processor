module Branch_Control_Unit_206(input Branch,            ///跳转信号
                               input Zero,              //零标志
                               input Sign,              //符号标志
                               input OverFlow,          //溢出标志
                               input[6-1:0] OP,         //指令OP域
                               input[5-1:0] BranchFlag, //跳转功能区分
                               output BranchCtr);       //跳转控制信号
    reg BranchCtr;
    always @(*) begin
        if(Branch == 1'b1)begin
            case (OP)
                6'b000100:begin // beq:branch a=b
                    BranchCtr <= Zero;
                end
                6'b000101:begin//  bne:branch a!=b
                    BranchCtr <= ~Zero;
                end
                6'b000001:begin 
                    case(BranchFlag)
                        5'b00001:begin // bgez:branch >=0
                            BranchCtr <= Zero || (~Sign && ~OverFlow);
                        end
                        5'b00000:begin // bltz:branch < 0
                            BranchCtr <= ~Zero && Sign && ~OverFlow;
                        end
                    endcase
                end
                6'b000111:begin // bgtz:branch >0
                    BranchCtr <= ~Zero && ~Sign && ~OverFlow;
                end
                6'b000110:begin // blez:branch <=0
                    BranchCtr = Zero || (Sign && ~OverFlow);
                end
                
            endcase
        end
        else begin
            BranchCtr <= 0;
        end
    end
endmodule
