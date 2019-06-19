`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 15:26:41
// Design Name: 
// Module Name: Alu
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


module Alu(X,Y,Aluc,R,Z);
    input [31:0]X,Y;
    input [1:0]Aluc;
    output [31:0]R;
    output Z;
    wire [31:0]d_as,d_and,d_or,d_and_or;
    ADDSUB_32 addsub0(X,Y,Aluc[0],d_as);
    assign d_and = X & Y;
    assign d_or = X | Y;
    MUX2X32 select1(d_or,d_and,Aluc[0],d_and_or);//Aluc[0]判断操作and或者or
    MUX2X32 select2(d_and_or,d_as,Aluc[1],R);//Aluc[1]判断操作位操作或者相加减
    assign Z = ~| R;
endmodule
