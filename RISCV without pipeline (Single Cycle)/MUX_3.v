`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:13 02/01/2021 
// Design Name: 
// Module Name:    MUX_3 
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
module MUX_3(data1,data2,data3,sel,out
    );
	 
	 input [31:0] data1,data2,data3;
	 input [1:0] sel;
	 output reg [31:0] out;
	 
	 always@(*)
	   begin 
		#10;
		  case(sel) 
		     2'b00:out=data1;
			  2'b01:out=data2;
			  2'b10:out=data3;
			  2'b11:out=31'bz;
			  
			endcase
			end


endmodule
