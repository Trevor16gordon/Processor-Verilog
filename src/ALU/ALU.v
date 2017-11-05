// ALU
// Trevor Gordon

`include "ADDER_N_BIT/ADDER_N_BIT.v"
`include "SUBTRACTOR_N_BIT/SUBTRACTOR_N_BIT.v"
`include "MULTIPLIER_N_BIT/MULTIPLIER_N_BIT.v"
`include "AND_BITWISE_N_BIT/AND_BITWISE_N_BIT.v"
`include "OR_BITWISE_N_BIT/OR_BITWISE_N_BIT.v"
`include "XOR_BITWISE_N_BIT/XOR_BITWISE_N_BIT.v"
`include "RIGHT_SHIFTER_N_BIT/RIGHT_SHIFTER_N_BIT.v"
`include "LEFT_SHIFTER_N_BIT/LEFT_SHIFTER_N_BIT.v"
`include "RIGHT_ROTATER_N_BIT/RIGHT_ROTATER_N_BIT.v"


module ALU(
	//outputs
	R1,
	negative,
	zero,
	overflow,
	carry,
	//inputs
	optcode,
	R2,
	R3,
	shift
	);

	parameter n = 5;

	input [31:0] R3, R2;
	input [3:0] optcode;
	input [4:0] shift;
	output [31:0] R1;
	output negative, zero, overflow, carry;


	wire    [31:0] answer_wires [0:8]; // 8 * 32 array for answer
	wire [3:0] flags [0:8]; 			// 8 by 4 array for flags to be multiplexed



	ADDER_N_BIT #(32) a(.out(answer_wires[0]), .in_a(R2), .in_b(R3));
	SUBTRACTOR_N_BIT #(32) b(.out(answer_wires[1]), .in_a(R2), .in_b(R3));
	MULTIPLIER_N_BIT #(32) c(.out(answer_wires[2]), .in_a(R2), .in_b(R3));
	OR_N_BIT #(32) d(.out(answer_wires[3]), .in_a(R2), .in_b(R3));
	AND_BITWISE_N_BIT #(32) e(.out(answer_wires[4]), .in_a(R2), .in_b(R3));
	XOR_BITWISE_N_BIT #(32) f(.out(answer_wires[5]), .in_a(R2), .in_b(R3));
	RIGHT_SHIFTER_N_BIT #(32, 5) g(.out(answer_wires[6]), .shift(shift), .in_a(R2));
	LEFT_SHIFTER_N_BIT #(32, 5) h(.out(answer_wires[7]), .shift(shift), .in_a(R2));
	RIGHT_ROTATER_N_BIT #(32, n) i(.out(answer_wires[8]), .in_a(R2));
	// NOTE CMP is taken care of when Software developer calls SUB and looks at the zero flag

	assign answer_wires[9] = answer_wires[1];


	assign R1 = answer_wires[optcode];
		

endmodule