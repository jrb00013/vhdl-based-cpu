# VHDL RISC-Style CPU with Custom ISA 🖥️

This project implements a basic CPU in VHDL. It consists of essential components like the ALU, control unit, registers, and memory.

## Files:

cpu_top.vhd: Main design of the CPU, integrating all components.

alu.vhd: Implements the Arithmetic and Logic Unit (ALU), performing arithmetic and logical operations.

control_unit.vhd: Contains the logic for the control unit that decodes instructions and generates control signals.

register_file.vhd: Implements the register file, which holds the CPU's general-purpose registers.

datapath.vhd: Connects all the components of the CPU (ALU, registers, control signals, etc.).

memory.vhd: Simulates the CPU’s memory, including read and write capabilities.

testbench.vhd: Provides the test vectors and simulation environment for validating the CPU's operation.


## How to Compile:
1. Open your terminal.
2. Navigate to the project folder.
3. Run `make` to compile the project.
4. Run the simulation to verify the functionality.

## Requirements:
- VHDL Compiler (e.g., ModelSim or Vivado)
