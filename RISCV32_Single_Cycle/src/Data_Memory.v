`timescale 1ns / 1ps

module Data_Memory(
    input wire clk, rst,
    input wire MemWrite, MemRead,
    input wire [31:0] address, write_data,
    output wire [31:0] read_data
    );

    reg [31:0] D_Memory [63:0]; // 64 words of memory
    integer k;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (k = 0; k < 63; k=k+1) begin
                D_Memory[k] <= 32'b0;
            end
        end
        else if (MemWrite) begin
            D_Memory[address] <= write_data;
        end
    end

    assign read_data = MemRead ? D_Memory[address] : 32'b0;
endmodule
