VHDL_SOURCES = cpu_top.vhd alu.vhd control_unit.vhd register_file.vhd datapath.vhd memory.vhd testbench.vhd
LIBRARY = work
ENTITY = testbench

all: compile simulate

compile:
    ghdl -a --workdir=$(LIBRARY) $(VHDL_SOURCES)

simulate:
    ghdl -e --workdir=$(LIBRARY) $(ENTITY)
    ghdl -r --workdir=$(LIBRARY) $(ENTITY)

clean:
    ghdl -r --workdir=$(LIBRARY) $(ENTITY)
    rm -rf $(LIBRARY)
