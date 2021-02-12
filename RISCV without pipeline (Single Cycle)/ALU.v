`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:22 02/01/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(alu_sel,operand1,operand2,alu_result
    );
	 
	 input [31:0] operand1,operand2;
	 input [3:0] alu_sel;
	 output reg [31:0] alu_result;
	 
	 
	 always@(*)
	    begin 
		 #50
		    case(alu_sel)
			    4'b0000 , 4'b1000 : begin
				       alu_result=operand1+(operand2)^{32{alu_sel[3]}}; end
				 4'b0110 : begin 
				       alu_result=operand1 & operand2; end
						 
				 4'b0111: begin 
				       alu_result=operand1 | operand2; end
				 default : begin 
				       alu_result=32'b0; end
						 
			 endcase
			 end
						 

endmodule
