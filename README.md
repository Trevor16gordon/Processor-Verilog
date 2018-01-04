# Processor - Verilog
Trevor Gordon
4th Year Electrical Engineering Student
The University of British Columbia
https://www.linkedin.com/in/trevor-gordon-28667094/

# Description

This project is a simple Processor with 9 ALU operations and conditional execution
- 16 Bit Instructions
```verilog
	//    				RAW MESSAGE DECODE
	//    15 14 13    10 9       7 6       4 3       1  0
	//   +-----+--------+---------+---------+---------+--+
	//   |COND |Op_code | dest_reg| src_reg1| src_reg2|  |
	//   +-----+--------+---------+---------+---------+--+
	//                                      |    Shift   |
	//                                      +---------+--+
```

- FETCH -> DECODE -> EXECUTE if condiction is satisfied	

- This project includes Python for building the project and running all tests where the output text file is compared
against an expected output. 

	- Subtest output can be conditionaly shown in terminal for debugging purposed by changing the config file.

	- Simply run `test.py`

![alt text](https://github.com/Trevor16gordon/Processor-Verilog/blob/FSM/Pictures/Processor%20Block%20Diagram.png)

Here is a screenshot of the project being built and CPU test displayed

![alt text](https://github.com/Trevor16gordon/Processor-Verilog/blob/FSM/Pictures/ENGR468-Trevor-Verilog-Tester.png)


# REQUIREMENTS
Requirements to run this after cloning
python 2.7 
Verilog simulator, [Icarus][iverilog]

# COPYRIGHT

Copyright &copy; 2017, Trevor Gordon.  All Rights Reserved.<br>
This project is free software and released under
the [GNU General Public License][gpl].

 [gpl]: http://www.gnu.org/licenses/gpl.html