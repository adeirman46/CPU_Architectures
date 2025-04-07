`timescale 1ns / 1ps

module Control_Unit(
    input wire [6:0] instruction,
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
);

always @(*) begin
    case (instruction)
        7'b0110_011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1], ALUOp[0]} <= 8'b0010_0010; // R-format (add, sub, and, or)
        7'b0000_011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1], ALUOp[0]} <= 8'b1111_0000; // ld (load double) I - Type
        7'b0100_011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1], ALUOp[0]} <= 8'b1000_1000; // sd (save double) S - Type
        7'b1100_011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1], ALUOp[0]} <= 8'b0000_0101; // beq (branch if equal) SB - Type
        default: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1], ALUOp[0]} <= 8'b0000_0000; // Default case
    endcase
    
end
endmodule
