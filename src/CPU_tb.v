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
always @(negedge clk) begin
    //$display("[clock %2d↓]:", i++);
    //$display("$| PC  | %h |" ,{u_CPU206.DataPath.IFetchUnit.PC.I_Addr,2'b00});
    //$display("#| IPC | %h |" ,u_CPU206.Instruction);
    //$display("$|t0/08| %h |" ,u_CPU206.DataPath.Regfile.Register[8]);
    //$display("$|t1/09| %h |" ,u_CPU206.DataPath.Regfile.Register[9]);
    //$display("$|t2/10| %h |" ,u_CPU206.DataPath.Regfile.Register[10]);
    //$display("$|t3/11| %h |" ,u_CPU206.DataPath.Regfile.Register[11]);
    //$display("$|t4/12| %h |" ,u_CPU206.DataPath.Regfile.Register[12]);
    //$display("$|t5/13| %h |" ,u_CPU206.DataPath.Regfile.Register[13]);
    //$display("$|t6/14| %h |" ,u_CPU206.DataPath.Regfile.Register[14]);
    //$display("M| 200 | %h |" ,{u_CPU206.DataPath.DM_4K.DM[203],u_CPU206.DataPath.DM_4K.DM[202],u_CPU206.DataPath.DM_4K.DM[201],u_CPU206.DataPath.DM_4K.DM[200]});
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