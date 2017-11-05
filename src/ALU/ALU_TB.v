`include "ALU.v"

module ALU_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

	reg [3:0] optcode;
	reg [31:0] a, b;
	reg [4:0] shift;
	wire [31:0] out;
	wire [3:0] flags_n_z_v_c;

	initial
		begin
			a = 0; b=0; optcode=4'b0000;  // Add
			#2 a=5; b=1;
			#2 a = 5; b=1; optcode=4'b0001; // Subtract
			#2 a = 5; b=2; optcode=4'b0010; // Multiply
			#2 a = 5; b=2; optcode=4'b0011; // BITWISE OR
			#2 a = 7; b=5; optcode=4'b0100; // BITWISE AND
			#2 a = 7; b=2; optcode=4'b0101; // BITWISE XOR
			#2 a = 8; shift=2; optcode=4'b0110; // Right Shift
			#2 a = 8; shift=2; optcode=4'b0111; // Left Shift
			#2 a = 1; shift=5; optcode=4'b1000; // Right Rotate
			#2 a = 11; b=11; optcode=4'b1001; // CMP

		end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
	    begin
	      $monitor($time, "    op_code=%d, a=%d, b=%d, shift=%d, ans= %d, flags_n_z_v_c=%b", optcode, a, b, shift, out, flags_n_z_v_c);
	    end

	always @(*) begin 
	#1 $fwrite(f, "op_code=%d, a=%d, b=%d, shift=%d, ans= %d, flags_n_z_v_c=%b", optcode, a, b, shift, out, flags_n_z_v_c);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end

   ALU my_alu(
   	.optcode(optcode), 
   	
   	.R1(out), 
   	.R2(a), 
   	.R3(b), 
   	.shift(shift), 
   	.flags_n_z_v_c(flags_n_z_v_c)
   	);

endmodule