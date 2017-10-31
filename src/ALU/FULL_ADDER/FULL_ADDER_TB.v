`include "../ALU/FULL_ADDER/FULL_ADDER.v"

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
	    	if (`DISPLAY_OUTPUT)
	      		$monitor($time, "    a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
	    end

	initial  
		begin
		$dumpfile (`DUMP_FILE); 
		$dumpvars; 
		end

   FULL_ADDER my_adder(.sum(sum), .cout(cout), .a(a), .b(b), .cin(cin));

endmodule