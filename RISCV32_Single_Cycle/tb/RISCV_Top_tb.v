
`timescale 1ns / 1ps

module RISCV_Top_tb();
    reg clk, rst;

    // Instantiate the RISCV_Top module
    RISCV_Top uut (
        .clk(clk),
        .rst(rst)
    );

    // For debugging - access internal signals
    wire [31:0] pc_value = uut.pc_out_wire;
    wire [31:0] instruction = uut.decode_wire;
    wire [31:0] alu_result = uut.alu_result_wire;
    wire [31:0] reg_read_data1 = uut.read_data1;
    wire [31:0] reg_read_data2 = uut.reg_to_mux_data;
    wire [31:0] write_back_data = uut.write_back_data_wire;
    

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Set up VCD file for waveform viewing
        $dumpfile("risc_v_sim.vcd");
        $dumpvars(0, RISCV_Top_tb);
        
        rst = 1; // Assert reset
        #20;
        rst = 0; // Deassert reset

        // Monitor important signals
        $monitor("Time=%0t, PC=%h, Instruction=%h, ALU_Result=%h", 
                 $time, pc_value, instruction, alu_result);
        
        // Wait for a longer time to observe multiple instruction executions
        #500;

        // Display register values
        $display("Final register values:");
        for (integer i = 0; i < 10; i = i + 1) begin
            $display("Reg[%0d] = %h", i, uut.Register.Registers[i]);
        end

        // Finish simulation
        $finish;
    end

endmodule