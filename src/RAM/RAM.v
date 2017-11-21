module RAM(
	load,
out_data_1_sel , 		// Address input
out_data_2_sel , 		// Address input
in_data_1_sel , 		// Address input
 out_data_1    , 	// Data output 1
 out_data_2    , 	// Data output 2
 in_data_1, 		//Data Input
 ce,        		// Chip Enable
 rr,					// Read Write
 clk
 );

parameter mem_width = 16;
parameter mem_length = 8;
parameter add_length = 3;

//Inputs
 input [add_length-1:0] out_data_1_sel;
 input [add_length-1:0] out_data_2_sel;
 input [add_length-1:0] in_data_1_sel;
 input ce, clk, rr, load; 
 input [mem_width-1:0] in_data_1; 

 //Outputs
 output [mem_width-1:0] out_data_1;
 output [mem_width-1:0] out_data_2; 
 
//Internal Reg           
reg [mem_width - 1:0] mem [0:mem_length - 1]; // 8 bit memory with 16 entries
reg [mem_width - 1:0] out_data_1; 
reg [mem_width - 1:0] out_data_2; 


 // Write Operation : When rr = 1, ce = 1
 always @(posedge clk)
 	begin
 		if (ce & rr) begin mem[in_data_1_sel] = in_data_1; end
 	end

// Read Operation : When rr = 0, ce = 1
always @(posedge clk)
	begin
	out_data_1 = (ce & !rr) ? mem[out_data_1_sel] : {mem_width{1'bz}};
	out_data_2 = (ce & !rr) ? mem[out_data_2_sel] : {mem_width{1'bz}};
	end

// Load deafult values into register
integer i;
always @(posedge load)
	for (i=0; i<mem_length; i =i +1)
	begin
		if (i == 0)
			mem[i] = 0;
		else
			mem[i] = mem[i-1]+1;
	end
endmodule


