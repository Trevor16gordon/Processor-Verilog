`include "OR_BITWISE_N_BIT.v"

module OR_BITWISE_N_BIT_TB;
	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

	reg [7:0] a, b;
	wire [7:0] out;

	

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			a = 0;
			b = 0;
			#2;
			#2 a = 1;
			#2 b = 1;
			#2 a = 3; b=4;
			#2 a = 15; b = 15;
			#2 a = a << 4;
			#2;
			#2;
			sim_done =1;
	    end

	always @(*) begin #1; $fwrite(f, "a=%b, b=%b, out= %b\n", a, b, out); end



    initial 
    	if (`DISPLAY_OUTPUT == 1)
		    begin
		      $monitor($time, "       a=%b, b=%b, out= %b", a, b, out);
		    end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end

   OR_BITWISE_N_BIT #(8) MY_ORER(.out(out), .in_a(a), .in_b(b));

endmodule