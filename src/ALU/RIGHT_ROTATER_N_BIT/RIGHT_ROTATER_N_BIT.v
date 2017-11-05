module RIGHT_ROTATER_N_BIT(cout, out, in_a, shift);
	parameter size = 16;
	parameter m = 4;

	input [size-1:0] in_a;
	input [m-1:0] shift;

	output [size-1:0] out;
	output cout; 

	wire [size-1:0] out;
	wire cout; 


	assign out = {in_a[m-1:0], in_a[size-1:m]};	// Shift by m bit needed at compile time
	assign cout = in_a[m-1];	// Carry is the last one to leave


endmodule