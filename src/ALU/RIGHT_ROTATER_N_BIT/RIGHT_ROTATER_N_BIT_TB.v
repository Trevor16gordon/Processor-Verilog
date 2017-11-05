`include "RIGHT_ROTATER_N_BIT.v"

module RIGHT_ROTATER_N_BIT_TB;

	
	reg [7:0] a, b;
	reg [3:0] shift;
	wire [7:0] out;
	wire cout;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			a = 8'b11110000;
			#2 a = 8'b01111000;
			#2;
			sim_done = 1;
			#2;
	    end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
		    begin
		      $monitor($time, "    shift=%d, a=%b, out=%b, cout=%b", 8, a, out, cout);
		    end

	always @(*) begin 
	#1 $fwrite(f, "shift=%d, a=%b, out=%b, cout=%b\n", shift, a, out, cout);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   RIGHT_ROTATER_N_BIT #(8, 4) MY_RR(.out(out), .in_a(a), .shift(shift), .cout(cout));

endmodule