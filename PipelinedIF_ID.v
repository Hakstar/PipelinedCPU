`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 22:06:54
// Design Name: 
// Module Name: PipelinedIF_ID
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

module PipelinedIF_ID(PC_plus4,IF_Inst,wpcir,Clk,Clrn,ID_PC_plus4,Inst,Condep);
    input [31:0]PC_plus4,IF_Inst;
    input       wpcir,Clk,Clrn,Condep;
    output [31:0]ID_PC_plus4,Inst;
    Dffe_32_Condep PCadd4(PC_plus4,Clk,Clrn,wpcir,ID_PC_plus4,Condep);//IF/IDPC+4寄存器
    Dffe_32_Condep Instmem(IF_Inst,Clk,Clrn,wpcir,Inst,Condep); //IF/ID指令寄存器
endmodule
