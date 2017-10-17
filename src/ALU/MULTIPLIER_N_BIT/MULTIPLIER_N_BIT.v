module MULTIPLIER_N_BIT(out, cout, in_a, in_b);
	parameter size = 4;
	input [size-1:0] in_a, in_b;
	output[size-1:0] out;
	output cout;


	assign {cout, out} = in_a*in_b;

endmodule