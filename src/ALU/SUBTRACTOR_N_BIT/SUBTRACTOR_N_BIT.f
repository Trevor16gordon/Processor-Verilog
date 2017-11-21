# SUBTRACTOR_N_BIT compile file
# The -y statement declares a library
# search directory
-y $(PROJ_PATH)/src/ALU/ADDER_N_BIT/
-y $(PROJ_PATH)/src/ALU/FULL_ADDER/
#
# This plusarg tells the compiler that
# files in libraries may have .v or .vl
# extensions.
+libext+.v+.vl
