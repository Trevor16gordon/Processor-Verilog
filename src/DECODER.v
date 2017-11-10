//////////////////////////////////////////////////////////////////////////////
// Decoder
// Module written by Trevor Gordon
// 4th Year Electrical Engineering Student
// The University of British Columbia
//////////////////////////////////////////////////////////////////////////////


module DECODER(
	raw_instruction,
	condition,
	op_code,
	dest_reg,
	source_reg_one,
	source_reg_two,
	bits_to_shift,
	clk
	);

//Inputs
input [15:0] raw_instruction;
input clk;

//Outputs
output [1:0] condition;
output [3:0] op_code;
output [2:0] dest_reg, source_reg_one, source_reg_two;
output [1:0] bits_to_shift;

//Outputs
reg [1:0] condition;
reg [2:0] op_code;
reg [2:0] dest_reg, source_reg_one, source_reg_two;
reg [1:0] bits_to_shift;

always @ (posedge clk)
	begin
	condidtion <= raw_instruction[15:14];
	op_code <= raw_instruction[13:11];
	dest_reg <= raw_instruction[10:8];
	source_reg_one <= raw_instruction[7:5];
	source_reg_two <= raw_instruction[4:2];
	bits_to_shift <= raw_instruction[1:0];
	end

endmodule