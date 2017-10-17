`include "MULTIPLIER_N_BIT.v"

module MULTIPLIER_N_BIT_TB;

	
  
	reg [6:0] a, b;
	wire [6:0] out;
	wire cout;

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
	      $monitor($time, "    a=%b, b=%b, out=%b, cout=%b", a, b, out, cout);
	    end

	initial  
		begin
		$dumpfile ("MULTIPLIER_N_BIT_TB.vcd"); 
		$dumpvars; 
		end

   MULTIPLIER_N_BIT #(7) my_multiplier(.out(out), .in_a(a), .in_b(b), .cout(cout));

endmodule