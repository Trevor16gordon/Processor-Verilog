module OR_N_BIT(flags_n_z_v_c, out, in_a, in_b);
	parameter size = 4;
	input [size-1:0] in_a, in_b;
	output [size-1:0] out;
	output [3:0] flags_n_z_v_c; // Negative, Zero, Overflow Carry


	assign out = in_a | in_b;
	assign flags_n_z_v_c[3] = out[size-1]; 	// Negative checks first bit
	assign flags_n_z_v_c[2] = ~|out;		// Zero Or's all bits
	assign flags_n_z_v_c[1] = 1'b0;			// Overflow Won't be set for ORing
	assign flags_n_z_v_c[0] = 1'b0;			// Carry Won't be set for ORing


endmodule