`include "MULTIPLIER_N_BIT.v"

module MULTIPLIER_N_BIT_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
  
	reg [6:0] a, b;
	wire [6:0] out;
	wire cout, overflow;

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
			sim_done = 1;
			#2;
	    end

    initial
    	if (`DISPLAY_OUTPUT == 1) 
	    begin
	      $monitor($time, "    a=%b, b=%b, out=%b, cout=%b, overflow=%b", a, b, out, cout, overflow);
	    end

	always @(*) begin 
	#1 $fwrite(f, "a=%b, b=%b, out=%b, cout=%b, overflow=%b\n", a, b, out, cout, overflow);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   MULTIPLIER_N_BIT #(7) my_multiplier(.out(out), .in_a(a), .in_b(b), .cout(cout), .overflow(overflow));

endmodule