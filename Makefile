# Define the toolchain
VHDL_COMPILER = ghdl
GHDL_FLAGS = --std=08

# Define the sources
SOURCES = alu.vhd control_unit.vhd cpu_top.vhd datapath.vhd memory.vhd register_file.vhd testbench.vhd

# Compile the VHDL files
all: compile

compile:
	$(VHDL_COMPILER) $(GHDL_FLAGS) -a $(SOURCES)

run:
	$(VHDL_COMPILER) $(GHDL_FLAGS) -e testbench
	./testbench

clean:
	rm -f *.o *.cf *.vcd
