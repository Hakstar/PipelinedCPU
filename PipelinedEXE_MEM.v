`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 22:07:55
// Design Name: 
// Module Name: PipelinedEXE_MEM
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


module PipelinedEXE_MEM(EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Alu,EXE_Qb,EXE_write_reg,Clk,Clrn,
                           MEM_Wreg,MEM_Reg2reg,MEM_Wmem,MEM_Alu,MEM_Qb,MEM_write_reg);
    input [31:0]EXE_Alu,EXE_Qb;
    input [4:0] EXE_write_reg;
    input       EXE_Wreg,EXE_Reg2reg,EXE_Wmem;
    input       Clk,Clrn;
    output [31:0]MEM_Alu,MEM_Qb;
    output [4:0]MEM_write_reg;
    output      MEM_Wreg,MEM_Reg2reg,MEM_Wmem;
    reg [31:0]MEM_Alu,MEM_Qb;
    reg [4:0] MEM_write_reg;
    reg       MEM_Wmem,MEM_Reg2reg,MEM_Wreg;
    always @(negedge Clrn or posedge Clk)
        if (Clrn == 0) //清零端为0时清零
            begin
            MEM_Wreg <= 0;
            MEM_Reg2reg <= 0;
            MEM_Wmem <= 0;
            MEM_Alu <= 0;
            MEM_Qb <= 0;
            MEM_write_reg <= 0;
            end
        else//清零端不为0时进行值的传递
            begin
            MEM_Wreg <= EXE_Wreg;
            MEM_Reg2reg <= EXE_Reg2reg;
            MEM_Wmem <= EXE_Wmem;
            MEM_Alu <= EXE_Alu;
            MEM_Qb <= EXE_Qb;
            MEM_write_reg <= EXE_write_reg;
            end
endmodule
