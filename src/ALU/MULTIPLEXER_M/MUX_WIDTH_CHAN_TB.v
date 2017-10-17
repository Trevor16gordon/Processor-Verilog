`include "MUX_WIDTH_CHAN.v"

module MUX_WIDTH_CHAN_TB;

	reg [3:0] sel;
	reg [11:0] in_bus;
	wire [2:0] out;

  	initial 
	    begin
	      in_bus = 12'b000000000111;
	    end

	initial
		begin
			sel = 2'b10;
			#1in_bus = in_bus << 3;
			#1in_bus = in_bus << 3;
			#1in_bus = in_bus << 3;
		end

    initial 
	    begin
	      $monitor($time, "    in_bus=%b, sel=%b, out=%b", in_bus, sel, out);
	    end

	initial  
		begin
		$dumpfile ("MUX_WIDTH_CHAN.vcd"); 
		$dumpvars; 
		end

   MUX_WIDTH_CHAN #(.WIDTH(3), .CHANNELS(4)) MY_MUX_WIDTH_CHAN(.in_bus(in_bus), .out(out), .sel(sel));

endmodule