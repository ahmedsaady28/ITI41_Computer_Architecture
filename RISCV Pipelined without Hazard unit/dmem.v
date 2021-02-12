`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:26 02/02/2021 
// Design Name: 
// Module Name:    dmem 
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
module dmem(addr,data,out,clk,we
    );
	 input [31:0] addr,data;
	 input clk,we;
	 output  [31:0] out;
	 
	 reg [31:0] d_mem [255:0];
	 
	 
	 assign #100 out = d_mem[addr[7:0]];
	 
	 
	 always @(posedge clk) 
			if(we)	d_mem[addr[7:0]]  <= #100 data;


endmodule
