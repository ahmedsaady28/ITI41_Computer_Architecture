`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:50 02/02/2021 
// Design Name: 
// Module Name:    imem 
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
module imem(addr,inst
    );
	 input [31:0] addr;
	 output [31:0] inst;
	 
	 reg [31:0] i_mem [0:255];
	 initial
	 $readmemh("program.txt",i_mem);
	 assign #100 inst = {{24{1'b0}},i_mem[addr[9:2]]};


endmodule
