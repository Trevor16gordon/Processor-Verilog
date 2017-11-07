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


	wire    [31:0] answer_wires [0:9]; // 9 * 32 array for answer
	wire negative, zero;
	wire [5:0] carry_array;
	wire [2:0] overflow_array;

	reg overflow, carry;

	ADDER_N_BIT #(32) a(.out(answer_wires[0]), .in_a(R2), .in_b(R3), .cout(carry_array[0]), .overflow(overflow_array[0]));
	SUBTRACTOR_N_BIT #(32) b(.out(answer_wires[1]), .in_a(R2), .in_b(R3), .cout(carry_array[1]), .overflow(overflow_array[1]));
	MULTIPLIER_N_BIT #(32) c(.out(answer_wires[2]), .in_a(R2), .in_b(R3), .cout(carry_array[2]), .overflow(overflow_array[2]));
	OR_BITWISE_N_BIT #(32) d(.out(answer_wires[3]), .in_a(R2), .in_b(R3));
	AND_BITWISE_N_BIT #(32) e(.out(answer_wires[4]), .in_a(R2), .in_b(R3));
	XOR_BITWISE_N_BIT #(32) f(.out(answer_wires[5]), .in_a(R2), .in_b(R3));
	RIGHT_SHIFTER_N_BIT #(32, 5) g(.out(answer_wires[6]), .shift(shift), .in_a(R2), .cout(carry_array[3]));
	LEFT_SHIFTER_N_BIT #(32, 5) h(.out(answer_wires[7]), .shift(shift), .in_a(R2), .cout(carry_array[4]));
	RIGHT_ROTATER_N_BIT #(32, n) i(.out(answer_wires[8]), .in_a(R2), .cout(carry_array[5]));
	// NOTE CMP is taken care of when Software developer calls SUB and looks at the zero flag

	assign answer_wires[9] = answer_wires[1];
	assign R1 = answer_wires[optcode];
	assign negative = R1[31];
	assign zero = ~(|R1);

	always @(*)
		if (optcode == 4'b0000)
			begin
				carry = carry_array[0];
				overflow = overflow_array[0];
			end
		else if ((optcode == 4'b0001)|(optcode == 4'b1001))
			begin
				carry = carry_array[1];
				overflow = overflow_array[1];
			end
		else if (optcode == 4'b0010)
			begin
				carry = carry_array[2];
				overflow = overflow_array[2];
			end
		else if (optcode == 4'b0110)
			begin
				carry = carry_array[3];
			end
		else if (optcode == 4'b0111)
			begin
				carry = carry_array[4];
			end
		else if (optcode == 4'b1000)
			begin
				carry = carry_array[5];
			end

endmodule


