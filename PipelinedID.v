`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 19:55:09
// Design Name: 
// Module Name: PipelinedID
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


module PipelinedID(MEM_Wreg,MEM_write_reg,EXE_write_reg,EXE_Wreg,EXE_Reg2reg,MEM_Reg2reg,ID_PC_plus4,Inst,
                   WB_write_reg,WB_Date_in,EXE_Alu,MEM_Alu,MEM_Date_out,WB_Wreg,Clk,Clrn,
                   I_jump_PC,J_jump_PC,Pcsrc,Stall,ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluc,ID_Aluqb,
                   ID_Qa,ID_Qb,ID_Ext_imm,ID_write_reg,Condep);
    input [31:0]ID_PC_plus4,Inst,WB_Date_in,EXE_Alu,MEM_Alu,MEM_Date_out;
    input [4:0] EXE_write_reg,MEM_write_reg,WB_write_reg;
    input       MEM_Wreg,EXE_Wreg,EXE_Reg2reg,MEM_Reg2reg,WB_Wreg;
    input       Clk,Clrn;
    output [31:0]I_jump_PC,J_jump_PC,ID_Qa,ID_Qb,ID_Ext_imm;
    output [4:0] ID_write_reg;
    output [1:0] ID_Aluc;
    output [1:0] Pcsrc;
    output       Stall,Condep,ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluqb;
    wire   [5:0] Op,Func;
    wire   [4:0] rs,rt,rd;
    wire   [31:0]Qa,Qb,L_imm;
    wire   [1:0] Fwda,Fwdb;
    wire        regrt,Se,Z;
    assign      Func = Inst[5:0];
    assign      Op   = Inst[31:26];
    assign      rs   = Inst[25:21];
    assign      rt   = Inst[20:16];
    assign      rd   = Inst[15:11];
    assign      J_jump_PC = {ID_PC_plus4[31:28],Inst[25:0],2'b00};
    PipelinedControlUnit controlUnit(MEM_Wreg,MEM_write_reg,EXE_write_reg,EXE_Wreg,EXE_Reg2reg,
                                     MEM_Reg2reg,Z,Func,Op,rs,rt,ID_Wreg,ID_Reg2reg,
                                     ID_Wmem,ID_Aluc,regrt,ID_Aluqb,Fwdb,Fwda,Stall,Se,
                                     Pcsrc,Condep);
    regfile Regfiee(rs,rt,WB_Date_in,WB_write_reg,WB_Wreg,~Clk,Clrn,Qa,Qb);
    MUX2X5 chose_writeaddr(rd,rt,regrt,ID_write_reg);//选择需要写入的目的寄存器编号
    MUX4X32 Alu_b(Qb,EXE_Alu,MEM_Alu,MEM_Date_out,Fwdb,ID_Qb);
    MUX4X32 Alu_a(Qa,EXE_Alu,MEM_Alu,MEM_Date_out,Fwda,ID_Qa);
    assign     Z = (ID_Qa == ID_Qb);//beq，bne提前判断
    Extend Ext_imm(Inst[15:0],Se,ID_Ext_imm);//立即数拓展器
    assign L_imm = {ID_Ext_imm[29:0],2'b00};//移位操作
    CLA32 addr(ID_PC_plus4,L_imm,1'b0,I_jump_PC);
    
endmodule
