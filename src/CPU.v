`include "RAM/RAM.v"
`include "ROM/ROM.v"
`include "ALU/ALU.v"
`include "DECODER.v"
`include "CONDITION.v"

// Finite State Machine CPU
// State = 0 , Fetch New Instruction
// State = 1 , Decode instruction and put RAM registers on ALU
// State = 2 , Execute , RAM in write mode here so result from ALU will 
//						be written immedietly to RAM


module CPU(
	clk,
	rst,
	negative,
	zero,
	overflow,
	carry,
	);

localparam PC = 14; //Special Register Program Counter
localparam R1 = 1; //Special Register Program Counter
localparam R2 = 2; //Special Register Program Counter
localparam R3 = 3; //Special Register Program Counter

input clk, rst;

output negative, zero, overflow, carry;


// Internal 
wire [1:0] condition;
wire [3:0] op_code;
wire [2:0] dest_reg, source_reg_one, source_reg_two;
wire [4:0] bits_to_shift;

wire [1:0] next_state;
reg [1:0] current_state;

//Clocks
wire fetch_clk;		//Fetch CLK
wire dec_clk;		//Decode CLK
wire alu_clk;		//ALU CLK
wire ram_clk;		//RAM CLK for read at dec_clk and write and alu_clk

//Internal
reg ram_chip_enable = 1;
reg load = 0;
wire conditional_execute;
wire ram_read_write;
wire [15:0] raw_instruction;
reg [4:0] pc;
wire [15:0] ram_in_data_1;
wire [15:0] ram_out_data_1;
wire [15:0] ram_out_data_2;

// Ram in write mode when ALU is operational
assign ram_read_write = (current_state == 2) ? 1 : 0; 



// This will cycle states 0 1 2 0 1 2
assign next_state = ((current_state == 2) | ((current_state == 1)&(~conditional_execute))) ? 0 : current_state+1;

always @ (posedge clk)
	begin
	 	current_state <= next_state;
	end

assign dec_clk = (current_state==1) 	? 1 : 0; 
assign alu_clk = (current_state==2) 	? conditional_execute : 0; 
assign fetch_clk = (current_state==0) ? 1 : 0; 
assign ram_clk = clk&(~dec_clk);

always @(posedge rst)
	begin
		pc = 0;
		current_state = 0;
		#1;
		load = 1;
	end



always @(posedge fetch_clk) begin pc = pc+1; end






ROM ROM_i (.address(pc), .data(raw_instruction), .ce(1'b1));

DECODER DECODER (
	.raw_instruction(raw_instruction),
	.condition      (condition),
	.op_code        (op_code),
	.dest_reg       (dest_reg),
	.source_reg_one (source_reg_one),
	.source_reg_two (source_reg_two),
	.bits_to_shift  (bits_to_shift)
);

ALU #(.WIDTH()) ALU (
	.R3      (ram_out_data_2),// Need to take the 3 bits from source_reg_one and access Reg bank and put 16 bit actual address location here
	.R2      (ram_out_data_1),
	.optcode (op_code),
	.shift   (bits_to_shift),
	.R1      (ram_in_data_1),
	.negative(negative),
	.zero    (zero),
	.overflow(overflow),
	.carry   (carry),
	.clk(alu_clk)
);




// Instantiate submodules
RAM RAM_i (
	.out_data_1_sel(source_reg_one), 
	.out_data_2_sel(source_reg_two),
	.in_data_1_sel(dest_reg),
	.ce(ram_chip_enable), 
	.rr(ram_read_write), 
	.in_data_1(ram_in_data_1), 
	.out_data_1(ram_out_data_1),
	.out_data_2(ram_out_data_2),
	.load(load),
	.clk(ram_clk)
	);

CONDITION CONDITION_i (
	.clk(dec_clk),
	.ins(condition),
	.negative(negative),
	.zero(zero),
	.out_bool(conditional_execute)
	);

initial 
	    begin
	      $monitor($time, "current_state=%d", current_state);
	    end


endmodule


