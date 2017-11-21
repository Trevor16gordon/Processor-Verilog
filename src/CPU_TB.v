`include "CPU.v"

module CPU_TB;

	integer i;

	// Sequence ends when sim_done goes high
	reg sim_done;
	integer f;
	reg[40*8:0] comment;
	reg clk, rst;
	wire [1:0] current_state;
	wire [2:0] pc;
	wire [3:0] op_code;
	wire [2:0] source_reg_one;
	wire [15:0] ram_in_data_1;
	wire [15:0] ram_out_data_1;

	wire [15:0] raw_instruction;

	initial begin clk = 0;
		forever begin #2 clk = ~clk; end;end

  	initial 
	    begin
	    	sim_done = 0;
			f = $fopen(`SAVEFILE,"w");
			rst = 0;
			#1; rst = 1;
			#30

			sim_done =1;
			#2;
	    end

    initial 
	    begin
	    	if (`DISPLAY_OUTPUT == 1)
			$monitor($time, "      clk= %b, raw_instruction=%b, CS=%d, pc=%d, op_code=%b, source_reg_one=%b, ram_out_data_1=%b, ram_in_data_1=%b", clk, raw_instruction, current_state, pc, op_code, source_reg_one,ram_out_data_1, ram_in_data_1);
	    end


	always @(*) begin 
	#1 $fwrite(f, "clk= %b, raw_instruction=%b, CS=%d\n", clk, raw_instruction, current_state);
	end

	// End sequenc when sim_done goes high
	always @(posedge sim_done) begin $fclose(f); $finish();end


   CPU cpu_i(.raw_instruction(raw_instruction), .clk(clk), .rst(rst), .current_state(current_state), .pc(pc), .op_code(op_code), .ram_in_data_1(ram_in_data_1), .ram_out_data_1(ram_out_data_1), .source_reg_one(source_reg_one));

endmodule