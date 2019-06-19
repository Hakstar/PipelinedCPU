`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 22:08:23
// Design Name: 
// Module Name: PipelinedMEM_WB
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


module PipelinedMEM_WB(MEM_Wreg,MEM_Reg2reg,MEM_Date_out,MEM_Alu,MEM_write_reg,Clk,Clrn,
                             WB_Wreg,WB_Reg2reg,WB_Date_out,WB_Alu,WB_write_reg);
    input [31:0]MEM_Date_out,MEM_Alu;
    input [4:0] MEM_write_reg;
    input       MEM_Wreg,MEM_Reg2reg;
    input       Clk,Clrn;
    output [31:0]WB_Date_out,WB_Alu;
    output [4:0] WB_write_reg;
    output       WB_Wreg,WB_Reg2reg;
    reg [31:0]WB_Date_out,WB_Alu;
    reg [4:0] WB_write_reg;
    reg       WB_Wreg,WB_Reg2reg;
    always @(negedge Clrn or posedge Clk)
        if(Clrn == 0)//清零端为0，清零
          begin
            WB_Wreg <= 0;
            WB_Reg2reg <= 0;
            WB_Date_out <= 0;
            WB_Alu <= 0;
            WB_write_reg <= 0;
          end
        else
          begin//清零端不为0，进行赋值
            WB_Wreg <= MEM_Wreg;
            WB_Reg2reg <= MEM_Reg2reg;
            WB_Date_out <= MEM_Date_out;
            WB_Alu <= MEM_Alu;
            WB_write_reg <= MEM_write_reg;
          end
endmodule
