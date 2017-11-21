# This is a comment in a command file.
# The -y statement declares a library
# search directory
-y $(PROJ_PATH)/src/ALU/FULL_ADDER/
-y $(PROJ_PATH)/src/ALU/ADDER_N_BIT/
-y $(PROJ_PATH)/src/ALU/SUBTRACTOR_N_BIT/
-y $(PROJ_PATH)/src/ALU/MULTIPLIER_N_BIT/
-y $(PROJ_PATH)/src/ALU/AND_BITWISE_N_BIT/
-y $(PROJ_PATH)/src/ALU/OR_BITWISE_N_BIT/
-y $(PROJ_PATH)/src/ALU/XOR_BITWISE_N_BIT/
-y $(PROJ_PATH)/src/ALU/RIGHT_SHIFTER_N_BIT/
-y $(PROJ_PATH)/src/ALU/LEFT_SHIFTER_N_BIT/
-y $(PROJ_PATH)/src/ALU/RIGHT_ROTATER_N_BIT/

-y $(PROJ_PATH)/src/RAM/
-y $(PROJ_PATH)/src/ROM/
#
# This plusarg tells the compiler that
# files in libraries may have .v or .vl
# extensions.
+libext+.v+.vl

//+define+DISPLAY_OUTPUT=$(DISPLAY_OUTPUT)
//+define+SAVEFILE=$(SAVEFILE)

