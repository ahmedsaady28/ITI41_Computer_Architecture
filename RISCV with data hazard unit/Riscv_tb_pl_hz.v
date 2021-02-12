`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:46:38 02/02/2021
// Design Name:   top_riscv
// Module Name:   E:/ITI_references/Digital_IC_course/Computer architecture/Labs/RISCV/RISCV/Riscv_tb.v
// Project Name:  RISCV
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_riscv
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Riscv_tb_pl_hz;

	// Inputs
	wire [31:0] top_dmem_out;
	wire [31:0] top_imem_inst;
	reg clk;
	reg rst;

	// Outputs
	wire top_dmemrw;
	wire [31:0] top_dmem_data;
	wire [31:0] top_dmem_addr;
	wire [31:0] top_imem_addr;

	// Instantiate the Unit Under Test (UUT)
	//Main cpu
	top_riscv_pl_hz uut (
		.top_dmemrw(top_dmemrw), 
		.top_dmem_data(top_dmem_data), 
		.top_dmem_addr(top_dmem_addr), 
		.top_dmem_out(top_dmem_out), 
		.top_imem_addr(top_imem_addr), 
		.top_imem_inst(top_imem_inst), 
		.clk(clk), 
		.rst(rst)
	);
	//Data memory
	dmem data(
		.addr(top_dmem_addr),
		.data(top_dmem_data),
		.out(top_dmem_out),
		.clk(clk),
		.we(top_dmemrw)
	);
	//Instruction memory
	imem instructions(
		.addr(top_imem_addr),
		.inst(top_imem_inst)
	);
	
/////////////////////Clocking block////////////
	initial clk = 0;
	always 
		begin
		#1000 clk =! clk;
	end
/////////////////////End of section////////////
	initial begin
		// Initialize Inputs
		#1000 rst = 1;
		#1000 rst = 0;        
		// Add stimulus here

	end
      
endmodule

