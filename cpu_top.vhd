library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(15 downto 0);
           data_out : out STD_LOGIC_VECTOR(15 downto 0)
           );
end cpu_top;

architecture Behavioral of cpu_top is

    -- Internal signal declarations for components
    signal alu_result : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_zero : STD_LOGIC;
    signal alu_carry : STD_LOGIC;
    signal alu_overflow : STD_LOGIC;
    signal reg_write_data : STD_LOGIC_VECTOR(15 downto 0);
    signal mem_data : STD_LOGIC_VECTOR(15 downto 0);
    signal mem_read_enable : STD_LOGIC;
    signal mem_write_enable : STD_LOGIC;
    signal reg_write_enable : STD_LOGIC;
    signal alu_op_signal : STD_LOGIC_VECTOR(3 downto 0);
    signal alu_src_signal : STD_LOGIC;
    signal branch_signal : STD_LOGIC;
    signal mem_to_reg_signal : STD_LOGIC;

    component ALU is
        Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
               B : in STD_LOGIC_VECTOR(15 downto 0);
               opcode : in STD_LOGIC_VECTOR(3 downto 0);
               result : out STD_LOGIC_VECTOR(15 downto 0);
               zero_flag : out STD_LOGIC;
               carry_out : out STD_LOGIC;
               overflow_flag : out STD_LOGIC );
    end component;

    component control_unit is
        Port ( opcode : in STD_LOGIC_VECTOR(3 downto 0);
               reg_write : out STD_LOGIC;
               alu_op : out STD_LOGIC_VECTOR(3 downto 0);
               mem_read : out STD_LOGIC;
               mem_write : out STD_LOGIC;
               branch : out STD_LOGIC;
               mem_to_reg : out STD_LOGIC;
               alu_src : out STD_LOGIC );
    end component;

    component datapath is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR(15 downto 0);
               alu_result : in STD_LOGIC_VECTOR(15 downto 0);
               mem_data : in STD_LOGIC_VECTOR(15 downto 0);
               reg_write_data : in STD_LOGIC_VECTOR(15 downto 0);
               data_out : out STD_LOGIC_VECTOR(15 downto 0);
               reg_write_enable : in STD_LOGIC;
               mem_write_enable : in STD_LOGIC;
               mem_read_enable : in STD_LOGIC;
               alu_op : in STD_LOGIC_VECTOR(3 downto 0);
               write_back : out STD_LOGIC_VECTOR(15 downto 0) );
    end component;

begin

    -- Instantiate components
    ALU_inst : ALU
        Port map ( A => data
