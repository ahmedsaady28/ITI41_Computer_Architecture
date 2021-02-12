`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:41 02/02/2021 
// Design Name: 
// Module Name:    branch_cmp 
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
module branch_cmp(dataA,dataB,brun,brlt,breq
    );
	input [31:0] dataA,dataB;
	input brun;
	output reg brlt,breq;
	
	always @(*)
		begin
		#10
		case(brun)
			1'b0 : begin
						if (dataA == dataB )
							begin
							breq =1'b1;
							brlt =1'b0;
							end
						else if (dataA < dataB)
							begin
							breq =1'b0;
							brlt =1'b1;
							end
						else
							begin
							breq =1'b0;
							brlt =1'b0;
							end
						end
			1'b1 : begin
						if ($signed(dataA) == $signed(dataB) )
							begin
							breq =1'b1;
							brlt =1'b0;
							end
						else if ($signed(dataA) < $signed(dataB))
							begin
							breq =1'b0;
							brlt =1'b1;
							end
						else
							begin
							breq =1'b0;
							brlt =1'b0;
							end
						end
			default : begin
						if (dataA == dataB )
							begin
							breq =1'b1;
							brlt =1'b0;
							end
						else if (dataA < dataB)
							begin
							breq =1'b0;
							brlt =1'b1;
							end
						else
							begin
							breq =1'b0;
							brlt =1'b0;
							end
						end
				endcase
		end

endmodule
