`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:38 02/01/2021 
// Design Name: 
// Module Name:    Imme_Gen 
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
module Imme_Gen(instr,sel,out
    );
	 
	 input [31:7] instr;
	 input [2:0] sel;
	 output reg [31:0] out;
	 
	 always@(*) 
	    begin 
		 #50
		    case(sel) 
			 
				    3'b0:begin 
					      out={{21{instr[31]}},instr[30:20]}; end   //I
					 3'b001:begin 
					      out={{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0}; end  //branch
					 3'b010:begin
					      out={{21{instr[31]}},instr[30:25],instr[11:7]}; end   //sw
					 3'b100:begin 
					      out={{11{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0}; end //jal
					 default:begin 
					      out=32'bx; end
							
				endcase
				end
				


endmodule
