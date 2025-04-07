`timescale 1ns / 1ps

module ALU(
    input wire [31:0] A, B,
    input wire [3:0] control_in,
    output reg [31:0] ALU_result,
    output reg zero
    );

    always @(A or B or control_in) begin
        case (control_in)
            4'b0000: begin zero <= 0; ALU_result <= A & B; end // AND
            4'b0001: begin zero <= 0; ALU_result <= A | B; end // OR
            4'b0010: begin zero <= 0; ALU_result <= A + B; end // Add
            4'b0110: begin if (A==B) zero <= 1; else zero <= 0; ALU_result <= A - B; end // Subtract
            default: begin zero <= 0; ALU_result <= 32'b0; end // Default case
        endcase
    end

endmodule
