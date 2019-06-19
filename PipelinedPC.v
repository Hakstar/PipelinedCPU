`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 19:51:24
// Design Name: 
// Module Name: PipelinedPC
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


module PipelinedPC(Next_PC,Stall,Clk,Clrn,PC);
    input [31:0]Next_PC;
    input       Stall,Clk,Clrn;
    output [31:0]PC;
    Dffe_32 PCreg(Next_PC,Clk,Clrn,Stall,PC);
endmodule
