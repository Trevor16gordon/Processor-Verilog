`include "ALU.v"

module ALU_TB;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;

	reg [3:0] optcode;
	reg [31:0] a, b;
	reg [4:0] shift;
	wire [31:0] out;
	wire [3:0] flags_n_z_v_c;

	initial
		begin
			sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			a = 0; b=0; optcode=4'b0000; comment="Adding";
			#2 a=5; b=1;
			#2 a={32{1'b1}}; b={32{1'b1}};comment="Adding - Carry and Negative Should be 1"; 
			#2 a={1'b0,{31{1'b1}}}; b=1;comment="Adding - Overflow Should be 1"; 
			#2 a = 5; b=1; optcode=4'b0001; comment="Subtract";
			#2 a=1; b=5; optcode=4'b0001; comment="Subtract - Negative flag is 1 ";
			#2 a = 5; b=2; optcode=4'b0010; comment="Multiply";
			#2 a = 5; b=2; optcode=4'b0011; comment="Bitwise OR";
			#2 a = 7; b=5; optcode=4'b0100; comment="Bitwise AND";
			#2 a = 7; b=2; optcode=4'b0101; comment="Bitwise XOR";
			#2 a = 8; shift=2; optcode=4'b0110; comment="Right Shift";
			#2 a = 3; shift=2; optcode=4'b0110; comment="Right Shift - Shift that carry bit to be juan";
			#2 a = 8; shift=2; optcode=4'b0111; comment="Left Shift";
			#2 a = 1'b1<<30; shift=2; optcode=4'b0111; comment="Left Shift - Carry should be 1";
			#2 a = 1; shift=5; optcode=4'b1000; comment="Right Rotate";
			#2 a = 5'b11111; shift=5; optcode=4'b1000; comment="Right Rotate - Carry should be 1";
			#2 a = 11; b=11; optcode=4'b1001; comment="CMP  Zero flag";
			#2 a = 10; b=11; optcode=4'b1001; comment="CMP  Negative flag";
			sim_done =1;
			#2;
		end

    initial 
    	if (`DISPLAY_OUTPUT == 1)
	    begin
	      $monitor($time, "\t%s\top(%d)\ta=%d, b=%d, shift=%d, ans= %b, n=%b, z=%b, v=%b, c=%b", comment, optcode, a, b, shift, out, negative, zero, overflow, carry);
	    end

	always @(*) begin 
	#1 $fwrite(f, "%s\top_code=%d, a=%d, b=%d, shift=%d, ans= %d, n=%b, z=%b, v=%b, c=%b\n", comment, optcode, a, b, shift, out, negative, zero, overflow, carry);
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
	.carry(carry)
   	);

endmodule


