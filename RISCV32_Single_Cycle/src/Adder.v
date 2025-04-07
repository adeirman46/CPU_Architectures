`timescale 1ns / 1ps

module Adder(
    input wire [31:0] in_1, in_2,
    output wire [31:0] out
    );

    assign out = in_1 + in_2;
endmodule
