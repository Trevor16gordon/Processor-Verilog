`include "SUBTRACTOR_N_BIT.v"

module SUBTRACTOR_N_BIT_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

	reg [3:0] a, b;
	wire [3:0] out;
	wire cout, overflow;

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			#2;
			a = 0;
			b = 0;
			#2 a = 1;
			#2 b = 1;
			#2 a = 3; b=4;
			#2 a = 15; b = 15;
			#2 a = 6; b = 14;
			sim_done =1;
			#1;
	    end

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT)
	    		$monitor($time, "    a-b=out %d - %d = %d, cout=%b, overflow=%b", a, b, out, cout, overflow);
	    end

	    always @(*) begin 
			#1 $fwrite(f, "a-b=out %d - %d = %d, cout=%b, overflow=%b\n", a, b, out, cout, overflow);
			end

		// End sequenc when sim_done goes high
		always @(posedge sim_done) begin $fclose(f); $finish();end

   SUBTRACTOR_N_BIT my_subtractor(.out(out), .in_a(a), .in_b(b), .cout(cout), .overflow(overflow));

endmodule