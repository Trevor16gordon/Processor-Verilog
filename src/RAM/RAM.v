module RAM(
address , // Address input
 out_data    , // Data output
 in_data, 	//Data Input
 rr, 		//ReadWrite         - 1 for Write -------------- 0 for Read -
 ce,        // Chip Enable
 clk		// clk
 );

parameter mem_width = 16;
parameter mem_length = 8;
parameter add_length = 3;

//Inputs
 input [add_length-1:0] address;
 input ce, rr, clk; 
 input [mem_width-1:0] in_data; 

 //Outputs
 output [mem_width-1:0] out_data; 
 
//Internal Reg           
reg [mem_width - 1:0] mem [0:mem_length - 1]; // 8 bit memory with 16 entries
reg [mem_width - 1:0] out_data; 


 // Write Operation : When rr = 1, ce = 1
 always @(posedge clk)
 	begin
        mem[address] = (ce & rr) ? in_data : mem[address];
 	end

// Read Operation : When rr = 0, ce = 1
always @(posedge clk)
	begin
	out_data = (ce & !rr) ? mem[address] : {mem_width{1'bz}};
	end

endmodule