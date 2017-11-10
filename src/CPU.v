`include "RAM.v"
`include "ROM.v"
`include "ALU.v"
`include "DECODER.v"




module CPU(

	);

localparam PC = 14; //Special Register Program Counter



output negative, zero, overflow, carry;

// Internal 
wire [1:0] condition;
wire [2:0] op_code;
wire [2:0] dest_reg, source_reg_one, source_reg_two;
wire [1:0] bits_to_shift;

//Internal
reg [15:0] raw_instruction;


always @ (posedge clk)
	begin
		//FETCH ADDRESS FROM Program Counter Loaded into Memory
		RAM[PC] = RAM[PC] + 1;

		//DECODE Will put new addresses on ALU and the Conditional
		// clk will take care of making this happen

		//EXECUTE If the Condition is satisfied, ALU will complete its operation
		// Conditional eventually but just execute for now



	end

// Instantiate submodules
RAM RAM_i (
	.address(), 
	.ce(), 
	.rr(), 
	.clk(), 
	.in_data(), 
	.out_data());

ROM ROM (.address(RAM[PC]), .data(raw_instruction), .ce(1'b1));


ALU ALU (
	.R3      (),// Need to take the 3 bits from source_reg_one and access Reg bank and put 16 bit actual address here
	.R2      (),
	.optcode (op_code),
	.shift   (bits_to_shift),
	.R1      (),
	.negative(negative),
	.zero    (zero),
	.overflow(overflow),
	.carry   (carry)
);

DECODER DECODER (
	.raw_instruction(raw_instruction),
	.condition      (condition),
	.op_code        (op_code),
	.dest_reg       (dest_reg),
	.source_reg_one (source_reg_one),
	.source_reg_two (source_reg_two),
	.bits_to_shift  (bits_to_shift),
	.clk(clk)
);





endmodule