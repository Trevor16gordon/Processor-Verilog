module MULTIPLIER_N_BIT(out, cout, overflow, in_a, in_b);
	parameter size = 4;
	localparam MSB = size - 1;

	input [size-1:0] in_a, in_b;
	output[size-1:0] out;
	output cout, overflow;

	wire[size-1:0] out;
	wire cout, overflow;


	assign {cout, out} = in_a*in_b;
	// msb of inputs are the same and different from result bit
	assign overflow = (in_a[MSB] == in_b[MSB]) & (in_a[MSB] ^ out[MSB]);

endmodule