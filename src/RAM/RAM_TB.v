`include "RAM.v"



module RAM_TB;
  	reg ce, clk, rr;
	reg [2:0] address;
	reg [15:0] in_data;
	wire [15:0] out_data;
	reg [15:0] memory [0:15];

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;

initial begin clk = 0;
	forever begin #1 clk = ~clk;end;end

initial begin rr = 1;
	forever begin #2 rr = ~rr; end;end

initial begin address = 0;
	forever begin #4 address = address+1; end; end

initial begin in_data = 16'hAAA0;
	forever begin #4 in_data = in_data+1; 	end; end

initial 
	begin
		sim_done = 0;
		f = $fopen(`SAVEFILE,"w");
		ce = 1;
		#50
		sim_done =1;
		#2;
	end

initial 
	if (`DISPLAY_OUTPUT == 1)
    begin
      $monitor($time, "      rr=%d, clk=%d, address=%d, in_data = %h, out_data = %h", rr, clk, address, in_data, out_data);
    end

always @(*) begin 
	#1 $fwrite(f, "rr=%d, clk=%d, address=%d, in_data = %h, out_data = %h\n", rr, clk, address, in_data, out_data);
	end

// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end

// initial
// begin
//  for (i=0; i<16; i=i+1) // This loop will write numbers 0 to 15 into the memory
//  begin
//  memory[i] =i;
//  end
//  $writememh("RAM_TB.txt", memory); // write in Hex
// end

   RAM my_ram(.ce(ce), 
   	.address(address), 
   	.out_data(out_data), 
   	.in_data(in_data), 
   	.clk(clk), 
   	.rr(rr)
   	);

endmodule