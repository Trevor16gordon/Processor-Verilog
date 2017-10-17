`include "LEFT_SHIFTER_N_BIT.v"

module LEFT_SHIFTER_N_BIT_TB;

	
	reg [7:0] a, b;
	reg [3:0] shift;
	wire [7:0] out;
	wire [3:0] flags_n_z_v_c;

  	initial 
	    begin
	      a = 8'b11110000;
	      #1 shift = 1;
	      #1 shift = 3;
	      #1 shift = 6;
	    end

    initial 
	    begin
	      $monitor($time, "    shift=%d, a=%b, out=%b, flags_n_z_v_c=%b", shift, a, out, flags_n_z_v_c);
	    end

	initial  
		begin
		$dumpfile ("OR_N_BIT_TB.vcd"); 
		$dumpvars; 
		end

   LEFT_SHIFTER_N_BIT #(8) MY_LShift(.out(out), .in_a(a), .shift(shift), .flags_n_z_v_c(flags_n_z_v_c));

endmodule