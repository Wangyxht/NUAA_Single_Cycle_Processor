module Control_Unit206(input[32-1:0] Instruction,
                       input clk,
                       output Branch,
                       output Jump,
                       output RegDst,
                       output ALUSrc,
                       output[5-1:0] ALUCtr,
                       output MemToReg,
                       output RegWr,
                       output MemWr,
                       output[2-1:0] ExtOp,
                       output Rtype,
                       output Jal,
                       output Rtype_J,
                       output Rtype_L,
                       output WrByte,
                       output[2-1:0] LoadByte);
    //控制信号
    reg Branch;
    reg Jump;
    reg RegDst;
    reg ALUSrc;
    reg[5-1:0] ALUCtr;
    reg MemToReg;
    reg RegWr;
    reg MemWr;
    reg ExtOp;
    reg Rtype;
    reg Jal;
    reg Rtype_J;
    reg Rtype_L;
    reg WrByte;
    reg[2-1:0] LoadByte;

    //指令分割
    wire[6-1:0] OP = Instruction[31:26];
    wire[6-1:0] func = Instruction[5:0];


    always @(*) begin
//  R型指令
        if (OP == 6'b000000) begin 
            case (func)
                6'b100000://add
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00000;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;

                end
                6'b100001://addu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00001;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;         
                    WrByte   = 0;
                    LoadByte = 2'b00;                              
                end
                6'b100010://sub
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00010;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;                    
                end
                6'b100011://subu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00011;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;            
                end
                6'b100100://and
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00100;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00; 
                end
                6'b100101://or
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00101;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;      
                    WrByte   = 0;
                    LoadByte = 2'b00;              
                end
                6'b100111://nor
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01110;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;         
                    WrByte   = 0;
                    LoadByte = 2'b00;                 
                end
                6'b100110://xor
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00110;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b101010://slt
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01100;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b101011://sltu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01101;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;            
                end
                6'b000000://sll
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01000;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;               
                end
                6'b000010://srl
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01001;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;               
                end
                6'b000011://sra
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01011;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;               
                end
                6'b000100://sllv
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b01111;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;              
                end
                6'b000110://srlv
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b10000;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;              
                end
                6'b000111://srav
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b10010;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;              
                end
                6'b001001://Jalr
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b11111;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 1;
                    Rtype_L  = 1;    
                    WrByte   = 0;
                    LoadByte = 2'b00;                    
                end
                6'b001000://Jr
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b11111;
                    MemToReg = 0;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 1; 
                    Jal      = 0;
                    Rtype_J  = 1;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;                    
                end
            endcase
        end
//  I/J指令：
        else begin // 以下为非R型指令译码
            case (OP)
//      ALU立即数I型指令
                6'b001000://addi
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00000;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;              
                end
                6'b001001://addiu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b001101://Ori
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00101;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 0;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b001100://andi
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00100;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 0;
                    Rtype    = 0; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b001110://xori
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00110;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 0;
                    Rtype    = 0; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b001010://slti
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b01100;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b001011://sltiu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b01101;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end                                
//      Branch-I型指令
                6'b000100://beq
                begin
                    Branch   = 1;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00010;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b000101://bne
                begin
                    Branch   = 1;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b00010;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;                    
                end
                6'b000001://bgez or bltz
                begin
                    Branch   = 1;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b11111;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end 
                6'b000110://blez
                begin
                    Branch   = 1;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b11111;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end 
                6'b000111://bgtz
                begin
                    Branch   = 1;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 0;
                    ALUCtr   = 5'b11111;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end  
//      Save/Load-I型指令
                6'b100011://lw
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 1;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b101011://sw
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 1'bX;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 0;
                    RegWr    = 0;
                    MemWr    = 1;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end
                6'b101000://sb
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 1;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 1;
                    LoadByte = 2'b00;
                end     
                6'b100000://lb
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 1;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b11;
                end   
                6'b100100://lbu
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b00001;
                    MemToReg = 1;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b10;
                end     
//      其他
                6'b001111://lui
                begin
                    Branch   = 0;
                    Jump     = 0;
                    RegDst   = 0;
                    ALUSrc   = 1;
                    ALUCtr   = 5'b11110;
                    MemToReg = 0;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 2'b10;
                    Rtype    = 0;
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;
                    WrByte   = 0;
                    LoadByte = 2'b00;
                end                     
//      JUMP-J型指令
                6'b000010://J
                begin
                    Branch   = 0;
                    Jump     = 1;
                    RegDst   = 1'bX;
                    ALUSrc   = 1'bX;
                    ALUCtr   = 5'bXXXXX;
                    MemToReg = 1'bX;
                    RegWr    = 0;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0; 
                    Jal      = 0;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;            
                end          
                6'b000011://Jal
                begin
                    Branch   = 0;
                    Jump     = 1;
                    RegDst   = 1'bX;
                    ALUSrc   = 1'bX;
                    ALUCtr   = 5'bXXXXX;
                    MemToReg = 1'bX;
                    RegWr    = 1;
                    MemWr    = 0;
                    ExtOp    = 1'bX;
                    Rtype    = 0; 
                    Jal      = 1;
                    Rtype_J  = 0;
                    Rtype_L  = 0;    
                    WrByte   = 0;
                    LoadByte = 2'b00;            
                end          
            endcase
        end
    end  
//  end always
endmodule
