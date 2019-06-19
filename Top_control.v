`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 15:54:12
// Design Name: 
// Module Name: Top_control
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


module Top_control(Clk,Clrn,PC,Inst,EXE_Alu,MEM_Alu,WB_Alu);
    input Clk,Clrn;
    output [31:0]PC,Inst,EXE_Alu,MEM_Alu,WB_Alu;//X_Alu都是Alu输出传递
    wire   [31:0]PC,Inst,EXE_Alu,MEM_Alu,WB_Alu; 
    wire   [31:0]I_jump_PC,J_jump_PC,Next_PC,PC_plus4,IF_Inst,ID_PC_plus4,ID_Qa,ID_Qb,ID_Ext_imm;//ID级参数
    wire   [31:0]EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_PC_plus4;//EXE级参数
    wire   [31:0]MEM_Qb,MEM_Date_out;//MEM级参数
    wire   [31:0]WB_Date_out,WB_Date_in;//WB级参数
    wire   [4:0]ID_write_reg,EXE_write_reg,MEM_write_reg,WB_write_reg;//结果数据写回寄存器的地址
    wire   [1:0]ID_Aluc,EXE_Aluc;//控制Alu的操作，只需要ID、EXE级有即可
    wire   [1:0]Pcsrc;//控制Next_PC选择
    wire   wpcir,Condep;//流水线暂停、清零操作数
    wire   ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluqb;//ID级操作控制数
    wire   EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Aluqb;//EXE级操作控制数
    wire   MEM_Wreg,MEM_Reg2reg,MEM_Wmem;//MEM级操作控制数
    wire   WB_Wreg,WB_Reg2reg;//WB级操作数

    PipelinedPC PCcontrol(Next_PC,wpcir,Clk,Clrn,PC);//PC寄存器
    PipelinedIF IFcontrol(Pcsrc,PC,I_jump_PC,ID_Qa,J_jump_PC,Next_PC,PC_plus4,IF_Inst);//IF级
    PipelinedIF_ID Reg_IF_ID(PC_plus4,IF_Inst,wpcir,Clk,Clrn,ID_PC_plus4,Inst,Condep);//IF与ID之间的流水线寄存器
    PipelinedID IDcontrol(MEM_Wreg,MEM_write_reg,EXE_write_reg,EXE_Wreg,EXE_Reg2reg,MEM_Reg2reg,ID_PC_plus4,Inst,
                          WB_write_reg,WB_Date_in,EXE_Alu,MEM_Alu,MEM_Date_out,WB_Wreg,Clk,Clrn,
                          I_jump_PC,J_jump_PC,Pcsrc,wpcir,ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluc,ID_Aluqb,
                          ID_Qa,ID_Qb,ID_Ext_imm,ID_write_reg,Condep);//ID级
    PipelinedID_EXE Reg_ID_EXE(ID_Wreg,ID_Reg2reg,ID_Wmem,ID_Aluc,ID_Aluqb,ID_Qa,ID_Qb,ID_Ext_imm,
                             ID_write_reg,ID_PC_plus4,Clk,Clrn,
                             EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Aluc,EXE_Aluqb,EXE_Qa,EXE_Qb,
                             EXE_Ext_imm,EXE_write_reg,EXE_PC_plus4);//ID与EXE之间的流水线寄存器
    PipelinedEXE EXEcontrol(EXE_Aluc,EXE_Aluqb,EXE_Qa,EXE_Qb,EXE_Ext_imm,EXE_write_reg,EXE_PC_plus4,EXE_Alu);//EXE级
    PipelinedEXE_MEM Reg_EXE_MEM(EXE_Wreg,EXE_Reg2reg,EXE_Wmem,EXE_Alu,EXE_Qb,EXE_write_reg,Clk,Clrn,
                                 MEM_Wreg,MEM_Reg2reg,MEM_Wmem,MEM_Alu,MEM_Qb,MEM_write_reg);//EXE与MEM之间的流水线寄存器
    PipelinedMEM MEMcontrol(MEM_Wmem,MEM_Alu,MEM_Qb,Clk,MEM_Date_out);//MEM级
    PipelinedMEM_WB Reg_MEM_WB(MEM_Wreg,MEM_Reg2reg,MEM_Date_out,MEM_Alu,MEM_write_reg,Clk,Clrn,
                               WB_Wreg,WB_Reg2reg,WB_Date_out,WB_Alu,WB_write_reg);//MEM与WB之间的流水线寄存器
    MUX2X32 Date_in_select(WB_Date_out,WB_Alu,WB_Reg2reg,WB_Date_in);//选择改写寄存器的值，同时直接作为WB级
    

endmodule
