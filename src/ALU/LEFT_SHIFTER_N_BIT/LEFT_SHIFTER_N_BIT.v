module LEFT_SHIFTER_N_BIT(cout, out, in_a, shift);
	parameter size = 16;
	parameter m = 4;

	input [size-1:0] in_a;
	input [m-1:0] shift;
	output [size-1:0] out;
	output cout; 

	wire [size-1:0] out;
	wire cout; 


	assign out = in_a<< shift;
	assign cout = in_a[size-shift];	// Carry


endmodule