`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:57:35 02/08/2021 
// Design Name: 
// Module Name:    reg_mod 
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
module reg_mod(
    input [31:0] data_in,
    output reg [31:0] data_out,
	 input rst,
    input clk
    );

always@(posedge clk)
begin
	if(rst) data_out = 32'b0;
	else data_out = data_in;
	
end
endmodule
