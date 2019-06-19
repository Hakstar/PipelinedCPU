`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 19:55:35
// Design Name: 
// Module Name: PipelinedEXE
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


module PipelinedEXE(EXE_Aluc,EXE_Aluqb,EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_write_reg,EXE_PC_plus4,EXE_Alu);//EXE级 执行Alu运算
    input [31:0]EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_PC_plus4;
    input [4:0] EXE_write_reg;
    input [1:0]EXE_Aluc;
    input      EXE_Aluqb;
    output [31:0]EXE_Alu;
    wire [31:0]Alu_a,Alu_b,EXE_Alu_out;
    wire       Z;
    assign Alu_a = EXE_Qa;//Alu操作数X的赋值
    MUX2X32 inAlu_b(EXE_Ext_imm,EXE_Qb,EXE_Aluqb,Alu_b);//Alu操作数Y的选择赋值
    Alu run(Alu_a,Alu_b,EXE_Aluc,EXE_Alu_out,Z);//Alu运算
    assign EXE_Alu = EXE_Alu_out;
endmodule
