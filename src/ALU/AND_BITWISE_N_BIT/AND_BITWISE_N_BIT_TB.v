`include "AND_BITWISE_N_BIT.v"

module AND_BITWISE_N_BIT_TB;

	
	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

	reg [7:0] a, b;
	wire [7:0] out;
	wire [3:0] flags_n_z_v_c;

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");

			a = 0;
			b = 0;
			#1 a = 1;
			#1 b = 1;
			#1 a = 3; b=4;
			#1 a = 15; b = 15;

			sim_done =1;
			#1;
	    end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
		    begin
		      $monitor($time, "    a=%b, b=%b, out=%b, flags_n_z_v_c=%b", a, b, out, flags_n_z_v_c);
		    end

always begin
	#1 $fwrite(f, "a=%b, b=%b, out=%b, flags_n_z_v_c=%b\n", a, b, out, flags_n_z_v_c);
	end

// End sequenc when sim_done goes high
always @(posedge sim_done) begin $fclose(f); $finish();end

   AND_BITWISE_N_BIT #(8) MY_AND(.out(out), .in_a(a), .in_b(b), .flags_n_z_v_c(flags_n_z_v_c));

endmodule