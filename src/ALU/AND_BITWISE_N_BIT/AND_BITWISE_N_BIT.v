module AND_BITWISE_N_BIT(out, in_a, in_b);
	parameter size = 4;
	input [size-1:0] in_a, in_b;
	output [size-1:0] out;

	wire [size-1:0] out;


	assign out = in_a & in_b;


endmodule