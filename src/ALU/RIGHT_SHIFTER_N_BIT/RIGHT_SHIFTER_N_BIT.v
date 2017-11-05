module RIGHT_SHIFTER_N_BIT(cout, out, in_a, shift);
	parameter size = 16;
	parameter m = 4;

	input [size-1:0] in_a;
	input [m-1:0] shift;
	output [size-1:0] out;
	output cout; // Carry

	wire [size-1:0] out;
	wire cout; // Carry


	assign out = in_a >> shift;
	assign cout = in_a[shift-1];	// Carry


endmodule