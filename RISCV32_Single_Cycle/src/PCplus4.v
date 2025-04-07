`timescale 1ns / 1ps

module PCplus4(
    input wire [31:0] from_pc,
    output reg [31:0] next_to_pc
    );
    
    always @(*) begin
        next_to_pc = from_pc + 4;
    end
    
endmodule
