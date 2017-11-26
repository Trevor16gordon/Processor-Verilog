`include "CPU.v"

module CPU_TB;

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;
	reg[3*8:0] OP, OP_SYM;
	reg[2*8:0] CD_SYM;
	reg clk, rst;
	wire [3:0] second_operand;

	assign second_operand = ((cpu_i.op_code == 4'b0110) | (cpu_i.op_code == 4'b0111) | (cpu_i.op_code == 4'b1000)) ? cpu_i.bits_to_shift : cpu_i.ram_out_data_2;
	

	initial begin clk = 0;
		forever begin #2 clk = ~clk; end;end

	initial
	begin
		$readmemh("RAM.txt", cpu_i.RAM_i.mem); // read hex
		// for (i=0; i<9; i=i+1)
	 	// 	$display ("data in position %d is %b", i, cpu_i.RAM_i.mem[i]); // read/display the numbers
	end

	initial
	begin
		$readmemb("ROM_INITIAL.txt", cpu_i.ROM_i.mem); // read hex
		// for (i=0; i<16; i=i+1)
	 	// 	$display ("data in position %d is %b", i, cpu_i.ROM_i.mem[i]); // read/display the numbers
	end

	//This is for color coding in terminal output
	reg[8*8:0] COLOR_1, COLOR_2, COLOR_3, COLOR_4;
	always @ (cpu_i.fetch_clk, cpu_i.dec_clk, cpu_i.alu_clk)
	begin
		if (cpu_i.fetch_clk)
			begin
				COLOR_1 = "\033[92m";
				COLOR_2 = "\033[94m";
				COLOR_3 = "\033[94m";
				COLOR_4 = "\033[0m";
			end
		else if (cpu_i.dec_clk)
			begin
				COLOR_1 = "\033[94m";
				COLOR_2 = "\033[92m";
				COLOR_3 = "\033[94m";
				COLOR_4 = "\033[0m";
			end
		else if (cpu_i.alu_clk)
			begin
				COLOR_1 = "\033[94m";
				COLOR_2 = "\033[94m";
				COLOR_3 = "\033[92m";
				COLOR_4 = "\033[0m";
			end	
		else 
			begin
				COLOR_1 = "\033[94m";
				COLOR_2 = "\033[94m";
				COLOR_3 = "\033[94m";
				COLOR_4 = "\033[0m";
			end			
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
				4'b1001 : OP = "CMP";
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
				4'b1001 : OP_SYM = "-";
			endcase
		end

	always @(cpu_i.condition)
		begin
			case (cpu_i.condition)
				2'b00 : CD_SYM = "GT";
				2'b01 : CD_SYM = "LT";
				2'b10 : CD_SYM = "EQ";
				2'b11 : CD_SYM = "  ";
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
			$monitor($time, "      %s|| FETCH: %b%s|| DECODE: %s%s R%h R%h R%h %d %s %d %s|| EXECUTE:  ANS = %d NZVC =%b%b%b%b%s\tR1=%d R2=%d R3=%d", 
				COLOR_1,
				cpu_i.raw_instruction, 
				COLOR_2,
				OP, 
				CD_SYM,
				cpu_i.dest_reg,
				cpu_i.source_reg_one,
				cpu_i.source_reg_two,
				cpu_i.ram_out_data_1,
				OP_SYM, 
				second_operand,
				COLOR_3,
				cpu_i.ram_in_data_1,
				cpu_i.negative,
				cpu_i.zero,
				cpu_i.overflow,
				cpu_i.carry,
				COLOR_4,
				cpu_i.RAM_i.mem[1],
				cpu_i.RAM_i.mem[2],
				cpu_i.RAM_i.mem[3]
				);
	    end

always @(*) begin 
	#1 $fwrite(f, "|| FETCH ? %b: %b|| DECODE ? %b: %s%s R%h R%h R%h %d %s %d || EXECUTE ? %b:  ANS = %d NZVC =%b%b%b%b\tR1=%d R2=%d R3=%d\n",
				cpu_i.fetch_clk,
				cpu_i.raw_instruction, 
				cpu_i.dec_clk,
				OP, 
				CD_SYM,
				cpu_i.dest_reg,
				cpu_i.source_reg_one,
				cpu_i.source_reg_two,
				cpu_i.ram_out_data_1,
				OP_SYM, 
				second_operand,
				cpu_i.alu_clk,
				cpu_i.ram_in_data_1,
				cpu_i.negative,
				cpu_i.zero,
				cpu_i.overflow,
				cpu_i.carry,
				cpu_i.RAM_i.mem[1],
				cpu_i.RAM_i.mem[2],
				cpu_i.RAM_i.mem[3]
				);
	    end


	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   CPU cpu_i(
   	.clk(clk), 
   	.rst(rst)
   	);

endmodule