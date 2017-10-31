import os
import processor_config
import subprocess as sub

cfg = processor_config.config

all_test = {
	'ALU':
		{	
		'FULL_ADDER': {'expected_result': 1},
		'ADDER_N_BIT': {'expected_result': 1},
		'SUBTRACTOR_N_BIT': {'expected_result': 1}
		}
}

for test, testdict in all_test.iteritems():
	for subtest, subtestdict in testdict.iteritems():

		mycwd = """%sProcessor-Verilog/src/%s/%s/"""%(cfg['relative_path'], test, subtest)

		# print(test, subtest, mycwd)

		display = 1 if ((subtest in cfg['show_specific_output']) or cfg['show_all_output']) else 0

		commands = [
		"iverilog -DDISPLAY_OUTPUT=%i -o %s %s.v"%(display, subtest, subtest),
		"iverilog -DDISPLAY_OUTPUT=%i -DDUMP_FILE=\"\\\"%s.vcd\\\"\" -o %s_TB %s_TB.v"%(display, subtest, subtest, subtest),
		"vvp %s_TB"%subtest
		]
		
		for thiscommand in commands:
			# print thiscommand
			p = sub.Popen(thiscommand,
				shell=True, 
				stdout=sub.PIPE,
				stderr=sub.PIPE,
				cwd=mycwd)
			
			output, errors = p.communicate()
			print output
			print errors

# os.system.print()
# os.chdir("""%s/Processor-Verilog/src/ALU/FULL_ADDER"""%relative_path)
# os.system("vvp FULL_ADDER_TB")