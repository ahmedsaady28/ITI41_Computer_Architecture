`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:30 02/01/2021 
// Design Name: 
// Module Name:    MUX_2 
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
module MUX_2(sel,data1,data2,out
    );
	 
	 input [31:0] data1,data2;
	 input sel;
	 output [31:0] out;
	 
	 assign #10 out =  sel ? data1:data2;
	 


endmodule
