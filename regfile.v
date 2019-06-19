`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 15:14:42
// Design Name: 
// Module Name: regfile
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


module regfile(Ra,Rb,D,Wn,We,Clk,Clrn,Qa,Qb);
    input [4:0] Ra,Rb,Wn;
    input [31:0]D;
    input       We,Clk,Clrn;
    output [31:0]Qa,Qb;
    reg [31:0]register[1:31];
    assign Qa = (Ra == 0) ? 0:register[Ra];
    assign Qb = (Rb == 0) ? 0:register[Rb];
    integer i;
    always @(posedge Clk or negedge Clrn)
    begin
        if (Clrn == 0) 
        begin
         for (i = 1;i < 32 ; i = i + 1 ) 
             register[i] <= 0;
        end 
        else if((Wn != 0) && We)
        register[Wn] <= D;
    end
endmodule
