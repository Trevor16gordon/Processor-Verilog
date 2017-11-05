`include "MULTIPLEXER_M.v"

module MULTIPLEXER_M_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;

	reg [3:0] sel;
	reg [23:0] in_bus;
	wire [2:0] out;

  	initial 
	    begin
	      in_bus = 12'b000000000101;
	    end

	initial
		begin
			sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			sel = 2'b10;
			#2 in_bus = in_bus << 3;
			#2 in_bus = in_bus << 3;
			#2 in_bus = in_bus << 3;
			#2 in_bus = in_bus >> 9; sel = 2'b00;
			#2 in_bus = in_bus << 3;
			#2 in_bus = in_bus << 3;
			#2 in_bus = in_bus << 3;
		end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
	    begin
	      $monitor($time, "    in_bus=%b, sel=%b, out=%b", in_bus, sel, out);
	    end

	always @(*) begin 
	#1 $fwrite(f, "in_bus=%b, sel=%b, out=%b\n", in_bus, sel, out);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   MULTIPLEXER_M #(.WIDTH(3), .CHANNELS(8), .SEL_LENGTH(4)) MULTIPLEXER_M_i(.in_bus(in_bus), .out(out), .sel(sel));

endmodule