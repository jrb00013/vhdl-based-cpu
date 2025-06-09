library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- Note: use numeric_std for synthesis safety in real designs
use IEEE.STD_LOGIC_ARITH.ALL;

entity datapath is
    Port (
        clk               : in  STD_LOGIC;
        reset             : in  STD_LOGIC;
        data_in           : in  STD_LOGIC_VECTOR(15 downto 0); --  instruction or immediate
        alu_result        : in  STD_LOGIC_VECTOR(15 downto 0);
        mem_data          : in  STD_LOGIC_VECTOR(15 downto 0);
        reg_write_data    : in  STD_LOGIC_VECTOR(15 downto 0);
        data_out          : out STD_LOGIC_VECTOR(15 downto 0);
        reg_write_enable  : in  STD_LOGIC;
        mem_write_enable  : in  STD_LOGIC;
        mem_read_enable   : in  STD_LOGIC;
        alu_op            : in  STD_LOGIC_VECTOR(3 downto 0);
        write_back        : out STD_LOGIC_VECTOR(15 downto 0);
        operand_B         : out STD_LOGIC_VECTOR(15 downto 0)
    );
end datapath;

architecture Behavioral of datapath is

    -- Assume 8 registers (R0 to R7), each 16-bit wide
    type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal reg_file : reg_array := (others => (others => '0'));

    -- Control signals instruction decode
    signal rs_addr   : INTEGER range 0 to 7 := 0; -- source register A
    signal rt_addr   : INTEGER range 0 to 7 := 1; -- source register B
    signal rd_addr   : INTEGER range 0 to 7 := 2; -- dest
    signal imm       : STD_LOGIC_VECTOR(15 downto 0);

    -- ALU operands
    signal operand_A : STD_LOGIC_VECTOR(15 downto 0);

    -- Multiplexer for B operand: either register or immediate
    signal use_immediate : STD_LOGIC := '0';  --  externally by control

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                reg_file <= (others => (others => '0'));
                data_out <= (others => '0');
                write_back <= (others => '0');
            else
                -- Read operands from register file
                operand_A <= reg_file(rs_addr);
                operand_B <= (use_immediate = '1') ? imm : reg_file(rt_addr);

                -- Write-back from ALU
                if reg_write_enable = '1' then
                    reg_file(rd_addr) <= reg_write_data;
                end if;

                -- Send ALU result to write-back stage
                write_back <= alu_result;

                -- Load from memory
                if mem_read_enable = '1' then
                    data_out <= mem_data;
                end if;

                --
                if mem_write_enable = '1' then
                   data_out <= reg_write_data;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
