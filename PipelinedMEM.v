`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 19:54:14
// Design Name: 
// Module Name: PipelinedMEM
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


module PipelinedMEM(We,Addr,Date_in,Clk,Date_out);//MEM级—DATAMEM
    input [31:0]Addr;
    input       Clk,We;
    input [31:0]Date_in;
    output [31:0]Date_out;
    wire write_in = We & ~Clk;//写入信号
    reg [31:0]Ram [0:31];

    assign Date_out = Ram[Addr[6:2]];
    always @(posedge write_in)
        begin
            if(We)Ram[Addr[6:2]] <= Date_in;
        end

    integer i;
    initial begin
        for(i = 0;i < 32; i = i + 1)
            Ram[i] = 0;
        end
endmodule
