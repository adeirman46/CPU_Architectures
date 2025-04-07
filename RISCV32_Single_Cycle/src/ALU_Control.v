`timescale 1ns / 1ps

module ALU_Control(
    input wire [1:0] ALUOp,
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    output reg [3:0] control_out
    );

    always @(*) begin
        case ({ALUOp, funct7, funct3})
            12'b00_0000000_000: control_out = 4'b0010; // add
            12'b01_0000000_000: control_out = 4'b0110; // sub
            12'b10_0000000_000: control_out = 4'b0010; // add
            12'b10_0100000_000: control_out = 4'b0110; // sub
            12'b10_0000000_111: control_out = 4'b0000; // and
            12'b10_0000000_110: control_out = 4'b0001; // or
            default: control_out = 4'b0000; // default case
        endcase
    end

endmodule


