`include "ROM.v"

module ROM_TB;

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;

  	reg ce;
	reg [2:0] address;
	wire [15:0] data;

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
		    ce = 1;
			address = 0;
			#1 address = address +1;
			#1 address = address +1;
			#1 address = address +1;
			#1 address = address +1;
			#1 address = address +1;
			sim_done =1;
			#2;
	    end

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT == 1)
			$monitor($time, "      address=%d, data = %b", address, data);
	    end


	always @(*) begin 
	#1 $fwrite(f, "address=%d, data = %b\n", address, data);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


	initial
	begin
		$readmemb("data.txt", my_rom.mem); // read hex
		//for (i=0; i<mem_length; i=i+1)
	 	//$display ("data in position %d is %h", i, mem[i]); // read/display the numbers
	end

   ROM my_rom(.ce(ce), .address(address), .data(data));

endmodule