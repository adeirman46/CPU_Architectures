`timescale 1ns / 1ps

module Instruction_Memory(
    input wire clk,
    input wire rst,
    input wire [31:0] read_address,
    output wire [31:0] instruction_out
    );

    integer k;

    reg [31:0] I_Mem[63:0]; // 64 instructions

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                for (k=0; k<64; k=k+1)
                    I_Mem[k] = 32'b0;
            end
        else begin
            // CHANGE THIS TO YOUR INSTRUCTIONS //
            // R-type
            I_Mem[0] = 32'b0000000000000000000000000000000 ;       // no operation
            I_Mem[4] = 32'b0000000_11001_10000_000_01101_0110011;    // add x13, x16, x25
            I_Mem[8] = 32'b0100000_00011_01000_000_00101_0110011;     // sub x5, x8, x3
            I_Mem[12] = 32'b0000000_00011_00010_111_00001_0110011;    // and x1, x2, x3
            I_Mem[16] = 32'b0000000_00101_00011_110_00100_0110011;    // or x4, x3, x5
            // I-type
            I_Mem[20]  = 32'b000000000010_10101_000_10110_0010011;     // addi x22, x21, 2
            I_Mem[24]  = 32'b000000000011_01000_110_01001_0010011;     // ori x9, x8, 3 
            // L-type
            I_Mem[28] =  32'b000000000101_00011_000_01001_0000011;     // lb x9, 5(x3)
            I_Mem[32] = 32'b000000000011_00011_001_01001_0000011;    // lh x9, 3(x3)
            // S-type
            I_Mem[36] =  32'b0000000_01111_00011_000_01000_0100011;     // sb x15, 8(x3), x3 = 12
            I_Mem[40] =  32'b0000000_01110_00110_001_01010_0100011;     // sh x14, 10(x6), x6 = 44
            // SB-type
            I_Mem[44] = 32'h00948663;     // beq x9, x9, 12
        end    
    end

    assign instruction_out = I_Mem[read_address];

endmodule
