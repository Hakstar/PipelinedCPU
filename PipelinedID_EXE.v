`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 22:07:25
// Design Name: 
// Module Name: PipelinedID_EXE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:4
// 
//////////////////////////////////////////////////////////////////////////////////


module PipelinedID_EXE(ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluc,ID_Aluqb,ID_Qa,ID_Qb,ID_Ext_imm,
                       ID_write_reg,ID_PC_plus4,Clk,Clrn,
                       EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Aluc,EXE_Aluqb,EXE_Qa,EXE_Qb,
                       EXE_Ext_imm,EXE_write_reg,EXE_PC_plus4);
    input [31:0]ID_Qa,ID_Qb,ID_Ext_imm,ID_PC_plus4;
    input [4:0] ID_write_reg;
    input [1:0] ID_Aluc;
    input       ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluqb;
    input       Clk,Clrn;
    output [31:0]EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_PC_plus4;
    output [4:0] EXE_write_reg;
    output [1:0] EXE_Aluc;
    output       EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Aluqb;
    reg [31:0]   EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_PC_plus4;
    reg [4:0]    EXE_write_reg;
    reg [1:0]    EXE_Aluc;
    reg          EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Aluqb;
    always @(negedge Clrn or posedge Clk)
        if(Clrn == 0)//清零端为0，清零
            begin
            EXE_Wreg <= 0;
            EXE_Reg2reg <= 0;
            EXE_Wmem <= 0;
            EXE_Aluc <= 0;
            EXE_Aluqb <= 0;
            EXE_Qa <= 0;
            EXE_Qb <= 0;
            EXE_Ext_imm <= 0;
            EXE_write_reg <= 0;
            EXE_PC_plus4 <= 0;
            end
        else
            begin//清零端不为0，值传递
            EXE_Wreg <= ID_Wreg;
            EXE_Reg2reg <= ID_Reg2reg;
            EXE_Wmem <= ID_Wmem;
            EXE_Aluc <= ID_Aluc;
            EXE_Aluqb <= ID_Aluqb;
            EXE_Qa <= ID_Qa;
            EXE_Qb <= ID_Qb;
            EXE_Ext_imm <= ID_Ext_imm;
            EXE_write_reg <= ID_write_reg;
            EXE_PC_plus4 <= ID_PC_plus4;
            end
endmodule
