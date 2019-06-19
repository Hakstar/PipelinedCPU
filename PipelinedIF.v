`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 19:51:47
// Design Name: 
// Module Name: PipelinedIF
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


module PipelinedIF(Pcsrc,PC,I_jump_PC,ID_Qa,J_jump_PC,Next_PC,PC_plus4,IF_Inst);
    input [31:0]PC,I_jump_PC,ID_Qa,J_jump_PC;
    input [1:0]Pcsrc;
    output [31:0]Next_PC,PC_plus4,IF_Inst;
    MUX4X32 after_PC(PC_plus4,I_jump_PC,ID_Qa,J_jump_PC,Pcsrc,Next_PC);//选择下一个PC地址
    CLA32 pc_add4(PC,32'h4,1'b0,PC_plus4);//PC+4
    PipelinedINSTMEM Instmem(PC,IF_Inst);//指令存储器
endmodule
