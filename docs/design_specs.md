## Design Specifications for VHDL-Based CPU
#1. Introduction
This project implements a basic CPU architecture using VHDL. The CPU is designed to execute a set of simple instructions such as arithmetic operations, memory reads/writes, and branching. The design is modular, with components for the ALU (Arithmetic Logic Unit), Control Unit, Datapath, Register File, Memory, and a Testbench for verifying functionality.

#2. CPU Architecture Overview
The architecture follows a simplified RISC (Reduced Instruction Set Computing) style with the following major components:

Control Unit: Decodes instructions and generates control signals for the other components.

Datapath: Includes registers, multiplexers, and the ALU for executing operations.

ALU: Performs arithmetic and logic operations (e.g., ADD, SUB, AND, OR).

Register File: Stores values used by the ALU and memory.

Memory: Holds data that can be read or written by the CPU.

Testbench: Simulates the operation of the CPU and validates the design.

#3. Modules and Their Functionality
3.1 Control Unit
The Control Unit generates the necessary control signals to orchestrate the CPU's operations. It decodes the opcode from the instruction and outputs signals to the Datapath, ALU, and other components.

Inputs: 4-bit opcode (from the instruction).

Outputs:

reg_write (to enable writing to registers)

alu_op (controls the ALU's operation)

mem_read (to read from memory)

mem_write (to write to memory)

branch (for branch operations)

mem_to_reg (to decide whether to write data from memory or ALU to the register)

alu_src (selects whether the second ALU input is from a register or immediate value)

3.2 ALU (Arithmetic Logic Unit)
The ALU performs arithmetic and logic operations on its two inputs, A and B. It generates a result, a zero flag, a carry flag, and an overflow flag.

Inputs: 16-bit A and B, 4-bit ALU opcode.

Outputs:

result (the result of the operation)

zero_flag (indicates if the result is zero)

carry_out (indicates if there was a carry out, used for addition/subtraction)

overflow_flag (indicates if the operation overflowed, for signed operations)

3.3 Datapath
The Datapath handles data movement and arithmetic logic within the CPU. It interfaces with the Register File, ALU, and Memory.

Inputs:

clk, reset, data_in (external input data)

alu_result, mem_data (ALU and memory outputs)

reg_write_data (data to be written to the register file)

Control signals (reg_write_enable, mem_write_enable, mem_read_enable, alu_op)

Outputs:

data_out (final output data from the Datapath)

write_back (data to be written back into the Register File)

3.4 Register File
The Register File stores the values needed by the CPU and provides two read ports and one write port.

Inputs:

write_data (data to write to the register)

write_enable (signal to enable writing to the register file)

Outputs:

read_data1, read_data2 (the values read from the register file)

3.5 Memory
The Memory stores program instructions and data.

Inputs:

address (address to read from or write to)

data_in (data to be written to memory)

mem_write_enable (enables writing to memory)

mem_read_enable (enables reading from memory)

Outputs:

data_out (data read from memory)

3.6 Testbench
The Testbench simulates the behavior of the CPU, providing input stimuli and observing output to verify correct functionality. It includes:

Clock generation

Reset signals

Instruction inputs

Expected output checks

#4. Instruction Set Architecture (ISA)
The CPU supports a simple set of instructions for demonstration purposes:

ADD: Adds two registers.

SUB: Subtracts one register from another.

AND: Performs bitwise AND between two registers.

OR: Performs bitwise OR between two registers.

LD: Loads data from memory into a register.

ST: Stores data from a register to memory.

BEQ: Branches to a given address if two registers are equal.

Each instruction is represented by a 16-bit word, where:

Bits 15-12: Opcode (4 bits)

Bits 11-8: Destination register (4 bits)

Bits 7-4: Source register 1 (4 bits)

Bits 3-0: Source register 2 or immediate value (4 bits)

#5. Signal Descriptions
clk: Clock signal for synchronization of all components.

reset: Active-high reset signal, used to initialize registers and other components to default values.

data_in: Input data for the CPU (used by memory or registers).

data_out: Output data from the CPU.

alu_result: Result of the ALU operation.

alu_op: ALU operation control signal (4 bits).

mem_read_enable: Memory read enable signal.

mem_write_enable: Memory write enable signal.

reg_write_enable: Register write enable signal.

branch: Branch control signal.

mem_to_reg: Selects whether to write the data from memory or the ALU to the register.

#6. Clocking and Reset
Clock: All components of the CPU are synchronized using a rising-edge clock. The clock signal is connected to the ALU, control unit, register file, and datapath to ensure coordinated operation.

Reset: A global reset signal is used to clear registers and set the CPU to its initial state at the beginning of simulation or operation.

#7. Simulation and Testing
The Testbench provides an automated means of verifying the correct behavior of the CPU. It applies test vectors to the CPU’s inputs and compares the outputs against expected results. The following tests are performed:

Basic Arithmetic Operations: Verifies that the ALU performs addition, subtraction, AND, and OR correctly.

Memory Operations: Verifies that data can be correctly written to and read from memory.

Branching: Verifies the behavior of branch instructions.

Register File Operations: Ensures that data is correctly written to and read from the registers.
