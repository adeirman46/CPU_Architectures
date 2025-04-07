`timescale 1ns / 1ps

module Imm_Gen(
    input wire [31:0] instruction,
    output reg [31:0] imm_ext
    );

    always @(*)
    begin
        case(instruction[6:0])
            7'b0000011: imm_ext <= {{20{instruction[31]}}, instruction[31:20]}; // ld (load)
            7'b0100011: imm_ext <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; //sd (store)
            7'b1100011: imm_ext <= {{19{instruction[31]}}, instruction[31], instruction[30:25], instruction[11:8], 1'b0}; // sb (conditional branch)
            default: imm_ext <= 32'b0; // default case
       endcase

    end
endmodule


