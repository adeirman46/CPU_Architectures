`timescale 1ns / 1ps

module Mux_2_to_1(
    input wire sel,
    input wire [31:0] A, B,
    output wire [31:0] C
    );

    assign C = (sel == 1'b0) ? A : B;
endmodule
