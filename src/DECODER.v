//////////////////////////////////////////////////////////////////////////////
// Decoder
// Module written by Trevor Gordon
// 4th Year Electrical Engineering Student
// The University of British Columbia
//////////////////////////////////////////////////////////////////////////////


	//    				RAW MESSAGE DECODE
	//    15 14 13    10 9       7 6       4 3       1  0
	//   +-----+--------+---------+---------+---------+--+
	//   | CN  |Op_code | dest_reg| src_reg1| src_reg2|  |
	//   +-----+--------+---------+---------+---------+--+
	//									    |    Shift   |
	//                                      +---------+--+


module DECODER(
	raw_instruction,
	condition,
	op_code,
	dest_reg,
	source_reg_one,
	source_reg_two,
	bits_to_shift
	);

//Inputs
input [15:0] raw_instruction;
input clk;

//Outputs
output [1:0] condition;
output [3:0] op_code;
output [2:0] dest_reg, source_reg_one, source_reg_two;
output [4:0] bits_to_shift;

//Outputs
reg [1:0] condition;
reg [3:0] op_code;
reg [2:0] dest_reg, source_reg_one, source_reg_two;
reg [4:0] bits_to_shift;

always @ (*)
	begin
	condition <= raw_instruction[15:14];
	op_code <= raw_instruction[13:10];
	dest_reg <= raw_instruction[9:7];
	source_reg_one <= raw_instruction[6:4];
	source_reg_two <= raw_instruction[3:1];
	bits_to_shift <= raw_instruction[3:0];
	end

endmodule