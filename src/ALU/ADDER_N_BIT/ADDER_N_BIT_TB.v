`include "ADDER_N_BIT.v"

module ADDER_N_BIT_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
  
	reg [3:0] a, b;
	wire [3:0] out;
	wire cout;


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
			#1 sim_done = 1;
			#1;
	    end

    initial 
	    begin
	      	if (`DISPLAY_OUTPUT)
	      		$monitor($time, "    a=%b, b=%b, out=%b, cout=%b", a, b, out, cout);
	    end

	always begin
	#1 $fwrite(f, "a=%b, b=%b, out=%b, cout=%b\n", a, b, out, cout);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   ADDER_N_BIT my_adder(.out(out), .in_a(a), .in_b(b), .cout(cout));

endmodule