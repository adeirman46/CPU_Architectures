`timescale 1ns / 1ps

module AND_logic(
    input branch, zero,
    output wire and_out
    );

    assign and_out = branch & zero;
endmodule
