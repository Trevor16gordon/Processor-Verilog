`include "FULL_ADDER.v"

module FULL_ADDER_TB;
  
	reg a, b, cin;
	wire sum, cout;

  	initial 
	    begin
	      a = 0;
	      b = 0;
	      cin = 0;
	      #1 a = 1;
	      #1 b = 1;
	      #1 cin = 0;
	    end

    initial 
	    begin
	      $monitor($time, "    a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
	    end

	initial  
		begin
		$dumpfile ("FULL_ADDER.vcd"); 
		$dumpvars; 
		end

   FULL_ADDER my_adder(.sum(sum), .cout(cout), .a(a), .b(b), .cin(cin));

endmodule