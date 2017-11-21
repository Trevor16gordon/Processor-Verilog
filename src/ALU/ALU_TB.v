`include "ALU.v"

module ALU_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;

	reg clk;
	reg [3:0] optcode;
	reg [15:0] a, b;
	reg [4:0] shift;
	wire [15:0] out;
	wire [3:0] flags_n_z_v_c;

	initial
		begin
			sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			a = 0; b=0; optcode=4'b0000; comment="Adding";
			#4 a=5; b=1;
			#4 a={16{1'b1}}; b={16{1'b1}};comment="Adding - Carry and Negative Should be 1"; 
			#4 a={1'b0,{15{1'b1}}}; b=1;comment="Adding - Overflow Should be 1"; 
			#4 a = 5; b=1; optcode=4'b0001; comment="Subtract";
			#4 a=1; b=5; optcode=4'b0001; comment="Subtract - Negative flag is 1 ";
			#4 a = 5; b=2; optcode=4'b0010; comment="Multiply";
			#4 a = 5; b=2; optcode=4'b0011; comment="Bitwise OR";
			#4 a = 7; b=5; optcode=4'b0100; comment="Bitwise AND";
			#4 a = 7; b=2; optcode=4'b0101; comment="Bitwise XOR";
			#4 a = 8; shift=2; optcode=4'b0110; comment="Right Shift";
			#4 a = 3; shift=2; optcode=4'b0110; comment="Right Shift - Shift that carry bit to be juan";
			#4 a = 8; shift=2; optcode=4'b0111; comment="Left Shift";
			#4 a = 1'b1<<14; shift=2; optcode=4'b0111; comment="Left Shift - Carry should be 1";
			#4 a = 1; shift=5; optcode=4'b1000; comment="Right Rotate";
			#4 a = 5'b11111; shift=5; optcode=4'b1000; comment="Right Rotate - Carry should be 1";
			#4 a = 11; b=11; optcode=4'b1001; comment="CMP  Zero flag";
			#4 a = 10; b=11; optcode=4'b1001; comment="CMP  Negative flag";
			sim_done =1;
			#2;
		end

	initial begin clk = 0;
		forever begin #2 clk = ~clk; end;end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
	    begin
	      $monitor($time, "\t%s\tclk=%d, op(%d)\ta=%d, b=%d, shift=%d, ans= %b, n=%b, z=%b, v=%b, c=%b", comment, clk, optcode, a, b, shift, out, negative, zero, overflow, carry);
	    end

	always @(*) begin 
	#1 $fwrite(f, "\t%s\tclk=%d, op(%d)\ta=%d, b=%d, shift=%d, ans= %b, n=%b, z=%b, v=%b, c=%b\n", comment, clk, optcode, a, b, shift, out, negative, zero, overflow, carry);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end

   ALU my_alu(
   	.optcode(optcode),  	
   	.R1(out), 
   	.R2(a), 
   	.R3(b), 
   	.shift(shift),
   	.negative(negative),
	.zero(zero),
	.overflow(overflow),
	.carry(carry),
	.clk(clk)
   	);

endmodule


