`timescale 1ns / 1ps

module RISCV_Top(
    input clk, rst
    );

    // Program Counter Instantiations
    wire [31:0] pc_in_wire, pc_out_wire;
    // PC Adder 4 Instantiations
    wire [31:0] pc_next_wire;
    // Instruction Memory Instantiations
    wire [31:0] decode_wire;
    // Register Instantiations
    wire reg_write;
    wire [31:0] write_back_data_wire, read_data1, reg_to_mux_data;
    // Control Instantiations
    wire branch_to_and_wire, mem_to_reg_wire, alu_src_to_mux_wire, mem_read_wire, mem_write_wire;
    wire [1:0] alu_op_wire;
    // Immediate Generator Instantiations
    wire [31:0] imm_ext_out_wire;
    // Mux 1 Instantiations
    wire [31:0] mux1_out_wire;
    // ALU Control Instantiations
    wire [3:0] alu_control_out_wire;
    // ALU Instantiations
    wire [31:0] alu_result_wire;
    wire zero_to_and_wire;
    // Adders Instantiations
    wire [31:0] sum_out_wire;
    // AND Gate Instantiations
    wire and_out_wire;
    // Data Memory Instantiations
    wire [31:0] data_mem_to_mux_wire;


    // Program Counter
    Program_Counter PC(.clk(clk), .reset(rst), .pc_in(pc_in_wire), .pc_out(pc_out_wire));

    // PC Adder 4
    PCplus4 PC_Adder(.from_pc(pc_out_wire), .next_to_pc(pc_next_wire));

    // Instruction Memory
    Instruction_Memory IM(.clk(clk), .rst(rst), .read_address(pc_out_wire), .instruction_out(decode_wire));

    // Register
    Reg_File Register(.clk(clk), .rst(rst), .reg_write(reg_write), .rs1(decode_wire[19:15]), .rs2(decode_wire[24:20]), .rd(decode_wire[11:7]), .write_data(write_back_data_wire), .read_data1(read_data1), .read_data2(reg_to_mux_data));

    // Control Unit
    Control_Unit CU(.instruction(decode_wire[6:0]), .Branch(branch_to_and_wire), .MemRead(mem_read_wire), .MemtoReg(mem_to_reg_wire), .MemWrite(mem_write_wire), .ALUSrc(alu_src_to_mux_wire), .RegWrite(reg_write), .ALUOp(alu_op_wire));

    // Immediate Generator
    Imm_Gen IMM_Gen(.instruction(decode_wire), .imm_ext(imm_ext_out_wire));

    // MUX 1
    Mux_2_to_1 MUX1(.sel(alu_src_to_mux_wire), .A(reg_to_mux_data), .B(imm_ext_out_wire), .C(mux1_out_wire));

    // ALU Control
    ALU_Control ALU_Ctrl(.ALUOp(alu_op_wire), .funct7(decode_wire[31:25]), .funct3(decode_wire[14:12]), .control_out(alu_control_out_wire));

    // ALU
    ALU ALU_(.A(read_data1), .B(mux1_out_wire), .control_in(alu_control_out_wire), .ALU_result(alu_result_wire), .zero(zero_to_and_wire));

    // Adder
    Adder Adder_(.in_1(pc_out_wire), .in_2(imm_ext_out_wire), .out(sum_out_wire));

    // AND Gate
    AND_logic AND_(.branch(branch_to_and_wire), .zero(zero_to_and_wire), .and_out(and_out_wire));

    // MUX 2
    Mux_2_to_1 MUX2(.sel(and_out_wire), .A(pc_next_wire), .B(sum_out_wire), .C(pc_in_wire));

    // Data Memory
    Data_Memory DM(.clk(clk), .rst(rst), .MemWrite(mem_write_wire), .MemRead(mem_read_wire), .address(alu_result_wire), .write_data(reg_to_mux_data), .read_data(data_mem_to_mux_wire));

    // MUX 3
    Mux_2_to_1 MUX3(.sel(mem_to_reg_wire), .A(alu_result_wire), .B(data_mem_to_mux_wire), .C(write_back_data_wire));


endmodule


