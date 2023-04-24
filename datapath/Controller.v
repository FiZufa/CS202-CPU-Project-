`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/08 12:42:57
// Design Name: 
// Module Name: control32
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


module Controller(Opcode,Function_opcode,Jr,Jmp,Jal,Branch,nBranch,RegDST,MemtoReg,RegWrite,MemWrite,ALUSrc,I_format,Sftmd,ALUOp);
    input[5:0] Opcode; 
    input[5:0] Function_opcode;
    
    output Jr;          
    output Jmp;         
    output Jal;         
    output Branch;      
    output nBranch;     
    output RegDST;      
    output MemtoReg;    
    output MemWrite;    
    output ALUSrc;      // 
    output I_format;    /
    output Sftmd;       /

    output[1:0] ALUOp;
    //R-type  I_format = 1, ALUOp = 2'b10;
    // beq 或 bne, ALUOp = 2'b01;
    //lw 或 sw, ALUOP = 2'b00;

   
    wire R_format; 
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;

    
    wire Lw; 
    assign Lw = (Opcode==6'b100011)? 1'b1:1'b0;
    wire Sw;
    assign Sw = (Opcode==6'b101011) ? 1'b1:1'b0;

    /
    assign I_format = (Opcode[5:3]==3'b001)? 1'b1:1'b0;

   
    assign Jr       = ((Function_opcode==6'b001000) && (Opcode==6'b000000)) ? 1'b1:1'b0;
    assign Jmp      = (Opcode==6'b000010) ? 1'b1:1'b0;
    assign Jal      = (Opcode==6'b000011) ? 1'b1:1'b0;
    assign Branch   = (Opcode==6'b000100) ? 1'b1:1'b0;
    assign nBranch  = (Opcode==6'b000101) ? 1'b1:1'b0;

    
    assign RegDST = R_format;
    assign MemtoReg = Lw; // lw
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jr);
    assign MemWrite = Sw; // sw
    assign ALUSrc = I_format || Lw || Sw;
    assign Sftmd = (((Function_opcode==6'b000000)||(Function_opcode==6'b000010)||(Function_opcode==6'b000011)||(Function_opcode==6'b000100)||(Function_opcode==6'b000110)||(Function_opcode==6'b000111))&& R_format)? 1'b1:1'b0;
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};


endmodule
