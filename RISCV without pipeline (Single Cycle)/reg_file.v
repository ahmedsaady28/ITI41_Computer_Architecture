`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:22 02/02/2021 
// Design Name: 
// Module Name:    reg_file 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reg_file(addr_a,addr_b,addr_d,data_d,data_a,data_b,regwen,clk
    );
	input [4:0] addr_a,addr_b,addr_d;
	input clk,regwen;
	input [31:0] data_d;
	output [31:0] data_b,data_a;
	
	
	reg [31:0] reg_mem [31:0];
	
	assign #50 data_a = (addr_a==0) ? 32'b0 : reg_mem[addr_a];
   assign #50 data_b = (addr_b==0) ? 32'b0 : reg_mem[addr_b];
	
	always @(negedge clk )
		begin
		#50
		if (regwen) reg_mem[addr_d] = data_d;
		
		end
endmodule
