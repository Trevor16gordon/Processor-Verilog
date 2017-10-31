`include "SUBTRACTOR_N_BIT.v"

module SUBTRACTOR_N_BIT_TB;

	reg [3:0] a, b;
	wire [3:0] out;
	wire cout, neg;

  	initial 
	    begin
	      a = 0;
	      b = 0;
	      #1 a = 1;
	      #1 b = 1;
	      #1 a = 3; b=4;
	      #1 a = 15; b = 15;
	    end

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT)
	    		$monitor($time, "    a=%b, b=%b, out=%b, cout=%b, neg=%b", a, b, out, cout, neg);
	    end

	initial  
		begin
		$dumpfile ("SUBTRACTOR_N_BIT_TB.vcd"); 
		$dumpvars; 
		end

   SUBTRACTOR_N_BIT my_subtractor(.out(out), .in_a(a), .in_b(b), .cout(cout), .negative(neg));

endmodule