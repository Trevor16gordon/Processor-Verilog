`include "RIGHT_SHIFTER_N_BIT.v"

module RIGHT_SHIFTER_N_BIT_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	
	reg [7:0] a, b;
	reg [3:0] shift;
	wire [7:0] out;
	wire cout;

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			a = 8'b11110000;
			#2 shift = 1;
			#2 shift = 3;
			#2 shift = 6;
			sim_done = 1;
			#2;
	    end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
	    begin
	      $monitor($time, "    shift=%d, a=%b, out=%b, cout=%b", shift, a, out, cout);
	    end

	always @(*) begin 
	#1 $fwrite(f, "shift=%d, a=%b, out=%b, cout=%b\n", shift, a, out, cout);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end



   RIGHT_SHIFTER_N_BIT #(8) MY_RShift(.out(out), .in_a(a), .shift(shift), .cout(cout));

endmodule