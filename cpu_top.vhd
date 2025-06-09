library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cpu_top is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        data_in   : in  STD_LOGIC_VECTOR(15 downto 0);
        data_out  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end cpu_top;

architecture Behavioral of cpu_top is

    -- ALU Signals
    signal alu_result      : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_zero        : STD_LOGIC;
    signal alu_carry       : STD_LOGIC;
    signal alu_overflow    : STD_LOGIC;

    -- Control Signals
    signal reg_write_en    : STD_LOGIC;
    signal mem_read_en     : STD_LOGIC;
    signal mem_write_en    : STD_LOGIC;
    signal alu_src         : STD_LOGIC;
    signal branch_en       : STD_LOGIC;
    signal mem_to_reg      : STD_LOGIC;
    signal alu_op          : STD_LOGIC_VECTOR(3 downto 0);

    -- Data Signals
    signal reg_write_data  : STD_LOGIC_VECTOR(15 downto 0);
    signal mem_data        : STD_LOGIC_VECTOR(15 downto 0);
    signal write_back_data : STD_LOGIC_VECTOR(15 downto 0);
    signal operand_B       : STD_LOGIC_VECTOR(15 downto 0);  -- ALU second operand

    -- Component Declarations
    component ALU
        Port (
            A            : in  STD_LOGIC_VECTOR(15 downto 0);
            B            : in  STD_LOGIC_VECTOR(15 downto 0);
            opcode       : in  STD_LOGIC_VECTOR(3 downto 0);
            result       : out STD_LOGIC_VECTOR(15 downto 0);
            zero_flag    : out STD_LOGIC;
            carry_out    : out STD_LOGIC;
            overflow_flag: out STD_LOGIC
        );
    end component;

    component control_unit
        Port (
            opcode      : in  STD_LOGIC_VECTOR(3 downto 0);
            reg_write   : out STD_LOGIC;
            alu_op      : out STD_LOGIC_VECTOR(3 downto 0);
            mem_read    : out STD_LOGIC;
            mem_write   : out STD_LOGIC;
            branch      : out STD_LOGIC;
            mem_to_reg  : out STD_LOGIC;
            alu_src     : out STD_LOGIC
        );
    end component;

    component datapath
        Port (
            clk             : in  STD_LOGIC;
            reset           : in  STD_LOGIC;
            data_in         : in  STD_LOGIC_VECTOR(15 downto 0);
            alu_result      : in  STD_LOGIC_VECTOR(15 downto 0);
            mem_data        : in  STD_LOGIC_VECTOR(15 downto 0);
            write_back_data : out STD_LOGIC_VECTOR(15 downto 0);
            reg_write_en    : in  STD_LOGIC;
            mem_write_en    : in  STD_LOGIC;
            mem_read_en     : in  STD_LOGIC;
            alu_op          : in  STD_LOGIC_VECTOR(3 downto 0);
            operand_B       : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

begin

    -- ALU Instantiation
    ALU_inst : ALU
        Port map (
            A             => data_in,          
            B             => operand_B,
            opcode        => alu_op,
            result        => alu_result,
            zero_flag     => alu_zero,
            carry_out     => alu_carry,
            overflow_flag => alu_overflow
        );

    -- Control Unit Instantiation
    control_unit_inst : control_unit
        Port map (
            opcode     => data_in(15 downto 12), -- Assuming MSB 4-bits are opcode
            reg_write  => reg_write_en,
            alu_op     => alu_op,
            mem_read   => mem_read_en,
            mem_write  => mem_write_en,
            branch     => branch_en,
            mem_to_reg => mem_to_reg,
            alu_src    => alu_src
        );

    -- Datapath Instantiation
    datapath_inst : datapath
        Port map (
            clk             => clk,
            reset           => reset,
            data_in         => data_in,
            alu_result      => alu_result,
            mem_data        => mem_data,
            write_back_data => write_back_data,
            reg_write_en    => reg_write_en,
            mem_write_en    => mem_write_en,
            mem_read_en     => mem_read_en,
            alu_op          => alu_op,
            operand_B       => operand_B
        );

    -- Final output
    data_out <= write_back_data;

end Behavioral;
