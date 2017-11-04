import os, errno
import processor_config
import subprocess as sub


def silentremove(filename):
    try:
        os.remove(filename)
    except OSError as e: # this would be "except OSError, e:" before Python 2.6
        if e.errno != errno.ENOENT: # errno.ENOENT = no such file or directory
            raise # re-raise exception if a different error occurred

cfg = processor_config.config


for test, testdict in cfg['modules_to_test'].iteritems():
	for subtest, subtestdict in testdict.iteritems():
		print('-'*90)
		print("STARTING TEST \t %s \t %s"%(test, subtest))

		mycwd = """%sProcessor-Verilog/src/%s/%s/"""%(cfg['relative_path'], test, subtest)

		# print(test, subtest, mycwd)

		display = (subtest in cfg['modules_to_display_output'])

		commands = [
		"iverilog -DDISPLAY_OUTPUT=%i -o %s %s.v"%(display, subtest, subtest),
		"iverilog \
			-DDISPLAY_OUTPUT=%i\
			-DSAVEFILE=\"\\\"%s.txt\\\"\" -o %s_TB %s_TB.v"%(display, subtest, subtest, subtest), #Double escape quotes but also escape the escape
		"vvp %s_TB"%subtest
		]

		all_errors = []
		
		for thiscommand in commands:
			# print thiscommand
			p = sub.Popen(thiscommand,
				shell=True, 
				stdout=sub.PIPE,
				stderr=sub.PIPE,
				cwd=mycwd)
			
			output, errors = p.communicate()

			all_errors.append(errors)
			all_errors.append(output)

		# Check Errors
		fail_test_error = [err for err in all_errors if err]

		if (fail_test_error):
			for thiserr in all_errors: 
				print(thiserr)
			print("ERROR IN TEST \t %s \t %s"%(test, subtest))
		else:
			#Check if output is as expected
			with open ("%s/EXPECTED_OUTPUT_%s.txt"%(mycwd, subtest)) as expected_result:
				with open("%s/%s.txt"%(mycwd, subtest)) as this_result:

					if this_result.readlines() == expected_result.readlines():
						print("PASSED TEST \t %s \t %s"%(test, subtest))
						
						if not (subtest in cfg['modules_to_keep_sim_output']):
							silentremove("%s/%s.txt"%(mycwd, subtest))
					
					else:
						print("FAILED TEST \t %s \t %s"%(test, subtest))
		
		# Remove super ugly executables I don't wanna see
		if not (subtest in cfg['modules_to_keep_executable']):
			silentremove("%s/%s"%(mycwd, subtest))
			silentremove("%s/%s_TB"%(mycwd, subtest))

