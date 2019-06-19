`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 15:04:41
// Design Name: 
// Module Name: Dffe_32
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


module Dffe_32(D,Clk,Clrn,e,q);//32位寄存器，只有一个清零端
        input [31:0]D;
    input Clk,Clrn,e;
    output reg[31:0]q;
    always @(negedge Clrn or posedge Clk)
        if (Clrn ==0)
        begin 
            q<= 0;
        end
        else begin 
        if(e) q <= D;
        end
endmodule