library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        reg_write    : in  STD_LOGIC;
        write_addr   : in  STD_LOGIC_VECTOR(4 downto 0); --  its 5  bits for 32 registers
        read_addr    : in  STD_LOGIC_VECTOR(4 downto 0);
        reg_data_in  : in  STD_LOGIC_VECTOR(15 downto 0);
        reg_data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end register_file;

architecture Behavioral of register_file is
    type reg_array is array(0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- reset all registers
                for i in 0 to 31 loop
                    regs(i) <= (others => '0');
                end loop;
            elsif reg_write = '1' then
                -- write data
                regs(to_integer(unsigned(write_addr))) <= reg_data_in;
            end if;
        end if;
    end process;

    -- Combinational reads
    reg_data_out <= regs(to_integer(unsigned(read_addr)));

end Behavioral;
