`include "XOR_BITWISE_N_BIT.v"

module XOR_BITWISE_N_BIT_TB;

	
	reg [7:0] a, b;
	wire [7:0] out;
	wire [3:0] flags_n_z_v_c;

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
	      $monitor($time, "    a=%b, b=%b, out=%b, flags_n_z_v_c=%b", a, b, out, flags_n_z_v_c);
	    end

	initial  
		begin
		$dumpfile ("OR_N_BIT_TB.vcd"); 
		$dumpvars; 
		end

   XOR_BITWISE_N_BIT #(8) MY_XORER(.out(out), .in_a(a), .in_b(b), .flags_n_z_v_c(flags_n_z_v_c));

endmodule