`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 15:38:45
// Design Name: 
// Module Name: controlUnit
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


module PipelinedControlUnit(MEM_Wreg,MEM_write_reg,EXE_write_reg,EXE_Wreg,EXE_Reg2reg,
                            MEM_Reg2reg,Z,Func,Op,rs,rt,ID_Wreg,ID_Reg2reg,
                            ID_Wmem,ID_Aluc,regrt,ID_Aluqb,Fwdb,Fwda,Stall,Se,
                            Pcsrc,Condep);
    input MEM_Wreg,EXE_Wreg,EXE_Reg2reg,MEM_Reg2reg,Z;
    input [4:0]MEM_write_reg,EXE_write_reg,rs,rt;
    input [5:0]Func,Op;
    output     ID_Wreg,ID_Reg2reg,ID_Wmem,regrt,ID_Aluqb,Se;
    output [1:0]ID_Aluc;
    output [1:0]Pcsrc;
    output [1:0]Fwdb,Fwda;
    output      Stall,Condep;
    reg [1:0]Fwdb,Fwda;
    wire R_type,I_add,I_sub,I_and,I_or;
    wire I_addi,I_andi,I_ori,I_lw,I_sw,I_beq,I_bne,I_J;
    wire I_rs = I_add | I_sub | I_and | I_or | I_addi | I_andi | I_ori | I_lw | I_sw | I_beq | I_bne;
    wire I_rt = I_add | I_sub | I_and | I_or | I_sw | I_beq | I_bne; 
    assign R_type = ~|Op;
    assign Stall = ~(EXE_Wreg & EXE_Reg2reg & (EXE_write_reg != 0) & (I_rs & (EXE_write_reg == rs) | I_rt & (EXE_write_reg == rt)));
    assign Condep = (I_beq & Z) | (I_bne & ~Z);

    //R型指令
    assign I_add = R_type & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] & ~Func[1] & ~Func[0];
    assign I_sub = R_type & Func[5] & ~Func[4] & ~Func[3] & ~Func[2] &  Func[1] & ~Func[0];
    assign I_and = R_type & Func[5] & ~Func[4] & ~Func[3] &  Func[2] & ~Func[1] & ~Func[0];
    assign I_or  = R_type & Func[5] & ~Func[4] & ~Func[3] &  Func[2] & ~Func[1] &  Func[0];
    
    //I型指令
    assign I_addi = ~Op[5] & ~Op[4] &  Op[3] & ~Op[2] & ~Op[1] & ~Op[0];
    assign I_andi = ~Op[5] & ~Op[4] &  Op[3] &  Op[2] & ~Op[1] & ~Op[0];
    assign I_ori  = ~Op[5] & ~Op[4] &  Op[3] &  Op[2] & ~Op[1] &  Op[0];
    assign I_lw   =  Op[5] & ~Op[4] & ~Op[3] & ~Op[2] &  Op[1] &  Op[0];
    assign I_sw   =  Op[5] & ~Op[4] &  Op[3] & ~Op[2] &  Op[1] &  Op[0];
    assign I_beq  = ~Op[5] & ~Op[4] & ~Op[3] &  Op[2] & ~Op[1] & ~Op[0];
    assign I_bne  = ~Op[5] & ~Op[4] & ~Op[3] &  Op[2] & ~Op[1] &  Op[0];
    
    //J型指令
    assign I_J = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] &  Op[1] & ~Op[0];
    
    //ָ操作数赋值
    assign regrt = I_addi | I_andi | I_ori | I_lw | I_sw | I_beq | I_bne | I_J;
    assign Se = I_addi |  I_lw | I_sw | I_beq | I_bne;
    assign ID_Wreg = (I_add | I_sub | I_or | I_and | I_addi | I_andi | I_ori | I_lw ) & Stall;
    assign ID_Aluqb = I_addi | I_andi | I_ori |  I_J | I_lw | I_sw;
    assign ID_Wmem = I_sw & Stall;
    assign ID_Reg2reg = I_lw;
    assign Pcsrc[0] = I_beq & Z | I_bne & ~Z | I_J;
    assign Pcsrc[1] = I_J;
    assign ID_Aluc[1] = I_and | I_or | I_andi | I_ori;
    assign ID_Aluc[0] = I_sub | I_or | I_ori | I_beq | I_bne;
    always @(EXE_write_reg , MEM_write_reg , EXE_Wreg , MEM_Wreg , MEM_Reg2reg , EXE_Reg2reg , rs , rt)//前推判断
        begin
            Fwda = 2'b00;//无数据冒险
            if((rs == EXE_write_reg) & (EXE_write_reg != 0) & (EXE_Wreg == 1) & ~EXE_Reg2reg)
                begin
                    Fwda = 2'b01;//前推EXE_Alu
                end
            else if((rs == MEM_write_reg) & (MEM_write_reg != 0) & (MEM_Wreg == 1) & ~MEM_Reg2reg)
                begin
                    Fwda = 2'b10;//前推MEM_Alu
                end
            else if((rs == MEM_write_reg) & (MEM_write_reg != 0) & (MEM_Wreg == 1) & MEM_Reg2reg)
                begin
                    Fwda = 2'b11;//前推WB_Alu
                end
            Fwdb = 2'b00;//无数据冒险
            if((rt == EXE_write_reg) & (EXE_write_reg != 0) & (EXE_Wreg == 1) & ~EXE_Reg2reg)
                begin
                    Fwdb = 2'b01;//前推EXE_Alu
                end
            else if((rt == MEM_write_reg) & (MEM_write_reg != 0) & (MEM_Wreg == 1) & ~MEM_Reg2reg)
                begin
                    Fwdb = 2'b10;//前推MEM_Alu
                end
            else if((rt == MEM_write_reg) & (MEM_write_reg != 0) & (MEM_Wreg == 1) & MEM_Reg2reg)
                begin
                    Fwdb = 2'b11;//前推WB_Alu
                end
        end
endmodule
