

module ROM(
address , // Address input
 data    , // Data output
 ce        // Chip Enable
 );

parameter mem_width = 16;
parameter mem_length = 16;
parameter add_length = 3;

 input [add_length-1:0] address;
 output [mem_width-1:0] data; 
 input ce; 

 integer i;
            
reg [mem_width - 1:0] mem [0:mem_length - 1]; // 8 bit memory with 16 entries
       
assign data = (ce) ? mem[address] : 0;

initial
	begin
		$readmemb("data.txt", mem); // read hex
		//for (i=0; i<mem_length; i=i+1)
	 	//$display ("data in position %d is %h", i, mem[i]); // read/display the numbers
	end
	

endmodule