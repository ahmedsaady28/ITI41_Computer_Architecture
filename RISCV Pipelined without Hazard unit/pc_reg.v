`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:05 02/02/2021 
// Design Name: 
// Module Name:    pc_reg 
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
module pc_reg(pc_in,pc_out,clk,rst
    );
input [31:0] pc_in;
input clk,rst;
output reg [31:0] pc_out;


always @(posedge clk,posedge rst)
	begin
	if(rst)
		begin
		pc_out = 32'b0;
		end
	else
		begin
		pc_out = pc_in;
		end
	end

endmodule
