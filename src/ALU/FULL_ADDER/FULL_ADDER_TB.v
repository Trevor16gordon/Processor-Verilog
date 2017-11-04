`include "FULL_ADDER.v"

module FULL_ADDER_TB;
  
	reg a, b, cin;
	wire sum, cout;

	reg sim_done;
	integer f;

  	initial 
	    begin
	    	sim_done = 0;
	    	f = $fopen(`SAVEFILE,"w");

			a = 0;
			b = 0;
			cin = 0;
			#1 a = 1;
			#1 b = 1;
			#1 cin = 0;
			#1 sim_done = 1;
			#1;
	    end

	always @(posedge sim_done) begin $fclose(f); $finish();end
	

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT)
	      		$monitor($time, "    a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
	    end
	initial begin
	    forever begin
	    	#1 $fwrite(f, "a=%b, b=%b, cin=%b, sum=%b, cout=%b\n", a, b, cin, sum, cout);
			end
	end

   FULL_ADDER my_adder(.sum(sum), .cout(cout), .a(a), .b(b), .cin(cin));

endmodule