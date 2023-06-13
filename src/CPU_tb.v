`include "CPU.v"
//~ `New testbench
`timescale  1ns / 1ps  

module tb_CPU206;      

// CPU206 Parameters   
parameter PERIOD  = 10;


// CPU206 Inputs       
reg   rst                                  = 1 ;
reg   clk                                  = 1 ;

// CPU206 Outputs
integer fd;
initial 
begin
    fd = $fopen("./CPU_Output.txt","w");
end

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD+1) rst  =  0;
end

CPU206  u_CPU206 (
    .rst                     ( rst   ),
    .clk                     ( clk   )
);

integer i = 0;
integer clk_num = 0;
always @(posedge clk) begin
    #1;
    $fdisplay(fd,"-------------------------------------------");
    $fdisplay(fd,"[clock %2d↓]:", clk_num++);
    $fdisplay(fd,"#| IPC | %h |" ,u_CPU206.Instruction);
    $fdisplay(fd,"$| PC  | %h |" ,{u_CPU206.DataPath.IFetchUnit.PC.I_Addr,2'b00});
    $fdisplay(fd,"Register Status:");
    for(i = 0; i <= 31; ++i)begin
        $fdisplay(fd,"$|Reg%2d| %h |" ,i,u_CPU206.DataPath.Regfile.Register[i]);
    end
    $fdisplay(fd,"Memory Status:");
    $fdisplay(fd,"Mem|0000_0014H| %h |" ,{u_CPU206.DataPath.DM_4K.DM[20+3],u_CPU206.DataPath.DM_4K.DM[20+2],u_CPU206.DataPath.DM_4K.DM[20+1],u_CPU206.DataPath.DM_4K.DM[20+0]});
    $fdisplay(fd,"Mem|0000_001CH| %h |" ,{u_CPU206.DataPath.DM_4K.DM[28+3],u_CPU206.DataPath.DM_4K.DM[28+2],u_CPU206.DataPath.DM_4K.DM[28+1],u_CPU206.DataPath.DM_4K.DM[28+0]});
   
end

initial
begin
    $dumpfile("CPU_WAVE.vcd");
    $dumpvars(8);
    #(50*PERIOD);
    $finish;
end

endmodule