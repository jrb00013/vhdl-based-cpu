library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    Port (
        clk        : in  STD_LOGIC;
        reset_n    : in  STD_LOGIC;  -- ACTIVE LOW RESET 
        addr       : in  STD_LOGIC_VECTOR(15 downto 0);
        data_in    : in  STD_LOGIC_VECTOR(15 downto 0);
        data_out   : out STD_LOGIC_VECTOR(15 downto 0);
        mem_write  : in  STD_LOGIC;
        mem_read   : in  STD_LOGIC;
        byte_enable: in  STD_LOGIC_VECTOR(1 downto 0) -- byte enable 1 =upper byte 0 =lower byte
    );
end memory;

architecture Behavioral of memory is
    type mem_array is array(0 to 1023) of STD_LOGIC_VECTOR(15 downto 0);
    signal mem : mem_array := (others => (others => '0'));

    signal read_data : STD_LOGIC_VECTOR(15 downto 0);

begin

    -- Asynchronous read process
    read_data <= mem(to_integer(unsigned(addr(9 downto 0)))) when mem_read = '1' else (others => 'Z');

    data_out <= read_data;

    -- Synchronous write with byte
    process(clk, reset_n)
        variable tmp : STD_LOGIC_VECTOR(15 downto 0);
    begin
        if reset_n = '0' then
            -- Clear memory on rese
            for i in 0 to 1023 loop
                mem(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            if mem_write = '1' then
                tmp := mem(to_integer(unsigned(addr(9 downto 0))));
                -- Byte enable logics
                if byte_enable(0) = '1' then
                    tmp(7 downto 0) := data_in(7 downto 0);
                end if;
                if byte_enable(1) = '1' then
                    tmp(15 downto 8) := data_in(15 downto 8);
                end if;
                mem(to_integer(unsigned(addr(9 downto 0)))) <= tmp;
            end if;
        end if;
    end process;

end Behavioral;
