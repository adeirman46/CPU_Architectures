`timescale 1ns / 1ps

module Reg_File(
    input wire clk,
    input wire rst,
    input wire reg_write,
    input wire [4:0] rs1, rs2, rd,
    input wire [31:0] write_data,
    output wire [31:0] read_data1, read_data2
    );

    reg [31:0] Registers [31:0]; // 32 registers

    // Initialize registers with some values, CHANGE THIS TO YOUR NEEDS //
    initial begin
        Registers[0] = 0;
        Registers[1] = 3;
        Registers[2] = 2;
        Registers[3] = 12;
        Registers[4] = 20;
        Registers[5] = 3;
        Registers[6] = 44;
        Registers[7] = 4;
        Registers[8] = 2;
        Registers[9] = 1;
        Registers[10] = 23;
        Registers[11] = 4;
        Registers[12] = 90;
        Registers[13] = 10;
        Registers[14] = 20;
        Registers[15] = 30;
        Registers[16] = 40;
        Registers[17] = 50;
        Registers[18] = 60;
        Registers[19] = 70;
        Registers[20] = 80;
        Registers[21] = 80;
        Registers[22] = 90;
        Registers[23] = 70;
        Registers[24] = 60;
        Registers[25] = 65;
        Registers[26] = 4;
        Registers[27] = 32;
        Registers[28] = 12;
        Registers[29] = 34;
        Registers[30] = 5;
        Registers[31] = 10;
    end

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            for (integer k=0; k<32; k=k+1)
                Registers[k] = 32'b0; // if reset is high, set all registers to 0
        end
        else if(reg_write)
        begin
            Registers[rd] = write_data; // if reg_write is high, write data to register rd
        end
            
    end

    assign read_data1 = Registers[rs1]; // read data from register rs1
    assign read_data2 = Registers[rs2]; // read data from register rs2
    
endmodule
