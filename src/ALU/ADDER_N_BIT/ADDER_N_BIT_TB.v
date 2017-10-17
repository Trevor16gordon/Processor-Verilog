`include "ADDER_N_BIT.v"

module ADDER_N_BIT_TB;

	
  
	reg [3:0] a, b;
	wire [3:0] out;
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
		$dumpfile ("ADDER_N_BIT_TB.vcd"); 
		$dumpvars; 
		end

   ADDER_N_BIT my_adder(.out(out), .in_a(a), .in_b(b), .cout(cout));

endmodule