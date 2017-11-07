import errno
import processor_config
import subprocess as sub
import re
import custom_util as util



class verilogTester(object):

	def __init__(self):

		#grab config files
		self.cfg = processor_config.config
		pass

	def run_all_tests(self):

		for test, testdict in self.cfg['modules_to_test'].iteritems():
			for subtest, subtestdict in testdict.iteritems():

				mycwd = """%sProcessor-Verilog/src/%s/%s/"""%(self.cfg['relative_path'], test, subtest)
				self.run_one_test(test, subtest, workingdir=mycwd)

			mycwd = """%sProcessor-Verilog/src/%s/"""%(self.cfg['relative_path'], test)
			self.run_one_test(test=test, subtest=test, workingdir=mycwd)

	def run_one_test(self, test, subtest, workingdir):

		print('-'*90)
		print("STARTING TEST \t %s \t %s"%(test, subtest))

		commands = self.build_commands_to_run(test, subtest)

		all_errors = ''
		
		for thiscommand in commands:
			# print thiscommand
			p = sub.Popen(thiscommand, shell=True, stdout=sub.PIPE, stderr=sub.PIPE, cwd=workingdir)
			
			output, errors = p.communicate()
			if output:
				print output
			if errors:
				print errors

			all_errors= all_errors+ '\n' + output + errors

		# Check Errors
		fail_test_error = re.search('error', all_errors, re.IGNORECASE)

		if (fail_test_error):
			self.test_error(test, subtest, all_errors)

		else:
			#Check if output is as expected
			with open ("%s/EXPECTED_OUTPUT_%s.txt"%(workingdir, subtest)) as expected_result:
				with open("%s/%s.txt"%(workingdir, subtest)) as this_result:
					is_output_equal = this_result.readlines() == expected_result.readlines()

			if is_output_equal:
				self.test_passed(test, subtest, workingdir=workingdir)
			
			else:
				self.test_failed(test, subtest)
		
		# Remove super ugly executables I don't wanna see
		if not (subtest in self.cfg['modules_to_keep_executable']):
			util.silentremove("%s/%s"%(workingdir, subtest))
			util.silentremove("%s/%s_TB"%(workingdir, subtest))

	def build_commands_to_run(self, test, module_name):

		# This assumes that module_name also has a test bench in the same dir callled module_name_tb

		display = (module_name in self.cfg['modules_to_display_output'])

		commands = [
		"iverilog -DDISPLAY_OUTPUT=%i -o %s %s.v"%(display, module_name, module_name),
		"iverilog \
			-DDISPLAY_OUTPUT=%i\
			-DSAVEFILE=\"\\\"%s.txt\\\"\" -o %s_TB %s_TB.v"%(display, module_name, module_name, module_name), #Double escape quotes but also escape the escape
		"vvp %s_TB"%module_name
		]

		return commands

	def test_error(self, test, subtest, all_errors):
	
		print(util.color_code.WARNING+\
				all_errors\
				+ util.color_code.ENDC)
		print(util.color_code.FAIL+\
			"ERROR IN TEST \t %s \t %s"%(test, subtest)\
			+ util.color_code.ENDC)		

	def test_passed(self, test, subtest, workingdir):
		print(util.color_code.OKGREEN + \
					"PASSED TEST \t %s \t %s"%(test, subtest) \
					+ util.color_code.ENDC)
		
		if not (subtest in self.cfg['modules_to_keep_sim_output']):
			util.silentremove("%s/%s.txt"%(workingdir, subtest))

	def test_failed(self, test, subtest):

		print(util.color_code.FAIL+\
					"FAILED TEST \t %s \t %s"%(test, subtest)\
					+ util.color_code.ENDC)

verilog_processor = verilogTester()
verilog_processor.run_all_tests()