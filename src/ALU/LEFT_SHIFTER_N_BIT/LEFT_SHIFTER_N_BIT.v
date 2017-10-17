module LEFT_SHIFTER_N_BIT(flags_n_z_v_c, out, in_a, shift);
	parameter size = 16;
	parameter m = 4;

	input [size-1:0] in_a;
	input [m-1:0] shift;
	output [size-1:0] out;
	output [3:0] flags_n_z_v_c; // Negative, Zero, Overflow Carry


	assign out = in_a<< shift;	// Carry flag takes outgoing bit
	assign flags_n_z_v_c[3] = out[size-1]; 	// Negative checks first bit
	assign flags_n_z_v_c[2] = ~|out;		// Zero Or's all bits
	assign flags_n_z_v_c[1] = 1'b0;			// Overflow Won't be set for ORing
	assign flags_n_z_v_c[0] = in_a[size-shift];	// Carry


endmodule