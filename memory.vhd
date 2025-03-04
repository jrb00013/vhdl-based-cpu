library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory is
    Port ( clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(15 downto 0);
           data_in : in STD_LOGIC_VECTOR(15 downto 0);
           data_out : out STD_LOGIC_VECTOR(15 downto 0);
           mem_write : in STD_LOGIC;
           mem_read : in STD_LOGIC;
           -- other signals as needed
           );
end memory;

architecture Behavioral of memory is
    type mem_array is array(0 to 1023) of STD_LOGIC_VECTOR(15 downto 0);
    signal mem : mem_array;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write = '1' then
                mem(to_integer(unsigned(addr))) <= data_in;
            elsif mem_read = '1' then
                data_out <= mem(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
end Behavioral;
