`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 22:13:51
// Design Name: 
// Module Name: Pipelined_CPU_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Pipelined_CPU_sim();
    reg        Clk;
    reg        Clrn;
    wire [31:0]PC;
    wire [31:0]Inst;
    wire [31:0]EXE_Alu;
    wire [31:0]MEM_Alu;
    wire [31:0]WB_Alu;
    
    initial
        begin
        $dumpfile("test.vcd");  
        $dumpvars(0,Pipelined_CPU_sim);
        Clk=0;
        Clrn=0;
        #20 
        Clrn=~Clrn;
        #3000 $finish();
        end
        always
            begin
            #20 
            Clk=~Clk;
            end
    Top_control Top_control_sim(.Clk(Clk),.Clrn(Clrn),.PC(PC),.Inst(Inst),.EXE_Alu(EXE_Alu),.MEM_Alu(MEM_Alu),.WB_Alu(WB_Alu));
endmodule
