`include "RAM.v"



module RAM_TB;
  	reg ce, rr, clk;
	reg [2:0] out_data_1_sel;
	reg [2:0] out_data_2_sel;
	reg [2:0] in_data_1_sel;
	reg [15:0] in_data_1;
	wire [15:0] out_data_1;
	wire [15:0] out_data_2;
	reg [15:0] memory [0:15];

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done, load;
	integer f;
	reg[40*8:0] comment;


initial begin rr = 0;
	forever begin #2 rr = ~rr; end;end

initial begin clk = 0;#1;
	forever begin #1 clk = ~clk; end;end

initial begin 
	in_data_1_sel = 0;
	out_data_1_sel = 0; 
	out_data_2_sel = 3'b111;#2
	forever begin 
		#4 out_data_1_sel = out_data_1_sel+1; 
		out_data_2_sel = out_data_2_sel+1; 
		in_data_1_sel = in_data_1_sel+1;
	end; 
end

initial begin in_data_1 = 16'hAAA0;
	forever begin #4 in_data_1 = in_data_1+1; 	end; end

initial 
	begin
		sim_done = 0;
		load = 0;
		f = $fopen(`SAVEFILE,"w");
		ce = 1;
		#20;
		load = 1;
		#2
		sim_done =1;
		#2;
	end

initial 
	if (`DISPLAY_OUTPUT == 1)
    begin
      $monitor($time, "      clk=%b, rr=%d, write_add_1=%d, read_add_1=%d, read_add_2=%d, in_data_1 = %h, out_data_1 = %h, out_data_2 = %h", clk, rr, in_data_1_sel, out_data_1_sel, out_data_2_sel, in_data_1, out_data_1, out_data_2);
    end

always @(*) begin 
	#1 $fwrite(f, "clk=%b, rr=%d, write_add_1=%d, read_add_1=%d, read_add_2=%d, in_data_1 = %h, out_data_1 = %h, out_data_2 = %h\n", clk, rr, in_data_1_sel, out_data_1_sel, out_data_2_sel, in_data_1, out_data_1, out_data_2);
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
   	.in_data_1_sel(in_data_1_sel),
   	.out_data_1_sel(out_data_1_sel), 
   	.out_data_2_sel(out_data_2_sel),
   	.out_data_1(out_data_1),
   	.out_data_2(out_data_2),
   	.in_data_1(in_data_1), 
   	.rr(rr),
   	.clk(clk),
   	.load(load)
   	);

endmodule