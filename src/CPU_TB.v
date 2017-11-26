`include "CPU.v"

module CPU_TB;

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;
	reg[3*8:0] OP, OP_SYM;
	reg clk, rst;
	

	initial begin clk = 0;
		forever begin #2 clk = ~clk; end;end

	initial
	begin
		$readmemh("RAM.txt", cpu_i.RAM_i.mem); // read hex
		for (i=0; i<9; i=i+1)
	 	$display ("data in position %d is %b", i, cpu_i.RAM_i.mem[i]); // read/display the numbers
	end

	initial
	begin
		$readmemb("ROM_INITIAL.txt", cpu_i.ROM_i.mem); // read hex
		for (i=0; i<16; i=i+1)
	 	$display ("data in position %d is %b", i, cpu_i.ROM_i.mem[i]); // read/display the numbers
	end

	always @(cpu_i.op_code)
		begin
			case (cpu_i.op_code)
				4'b0000 : OP = "ADD";
				4'b0001 : OP = "SUB";
				4'b0010 : OP = "MUL";
				4'b0011 : OP = "OR";
				4'b0100 : OP = "AND";
				4'b0101 : OP = "XOR";
				4'b0110 : OP = "SHR";
				4'b0111 : OP = "SHL";
				4'b1000 : OP = "ROR";
			endcase
		end

	always @(cpu_i.op_code)
		begin
			case (cpu_i.op_code)
				4'b0000 : OP_SYM = "+";
				4'b0001 : OP_SYM = "-";
				4'b0010 : OP_SYM = "*";
				4'b0011 : OP_SYM = "|";
				4'b0100 : OP_SYM = "&";
				4'b0101 : OP_SYM = "^";
				4'b0110 : OP_SYM = ">>";
				4'b0111 : OP_SYM = "<<";
				4'b1000 : OP_SYM = ">->";
			endcase
		end

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			rst = 0;
			#1; rst = 1;
			#200

			sim_done =1;
			#2;
	    end

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT == 1)
			$monitor($time, "      || FETCH ? %b: raw_inst=%b, pc=%d, || DECODE ? %b: OP=%s R%h R%h R%h (%d %s %d) || EXECUTE ? %b:  ANS = %d", 

				cpu_i.fetch_clk,
				cpu_i.raw_instruction, 
				cpu_i.pc, 
				cpu_i.dec_clk,
				OP, 
				cpu_i.dest_reg,
				cpu_i.source_reg_one,
				cpu_i.source_reg_two,
				cpu_i.ram_out_data_1,
				OP_SYM, 
				cpu_i.ram_out_data_2,
				cpu_i.alu_clk,
				cpu_i.ram_in_data_1
				);
	    end


	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   CPU cpu_i(
   	.clk(clk), 
   	.rst(rst)
   	);

endmodule