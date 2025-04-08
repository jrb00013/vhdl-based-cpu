library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
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
           write_back : out STD_LOGIC_VECTOR(15 downto 0)
           );
end datapath;

architecture Behavioral of datapath is

    signal register_file : STD_LOGIC_VECTOR(15 downto 0); -- Registers inside datapath

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                register_file <= (others => '0');  -- Reset all registers
                data_out <= (others => '0');
                write_back <= (others => '0');
            else
                -- ALU result processing
                write_back <= alu_result; -- Direct ALU output to write-back

                -- Register Write Logic
                if reg_write_enable = '1' then
                    register_file <= reg_write_data;
                end if;

                -- Data Read Logic
                if mem_read_enable = '1' then
                    data_out <= mem_data;
                end if;

                -- Memory Write Logic
                if mem_write_enable = '1' then
                    -- Assume memory write code is executed elsewhere
                end if;
            end if;
        end if;
    end process;
end Behavioral;
