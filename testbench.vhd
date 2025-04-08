library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;

architecture Behavior of testbench is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal data_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(15 downto 0);

    -- Instantiate the unit under test (UUT)
    component cpu_top is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR(15 downto 0);
               data_out : out STD_LOGIC_VECTOR(15 downto 0)
               );
    end component;

begin

    -- Instantiate the UUT
    uut: cpu_top Port map ( clk => clk, reset => reset, data_in => data_in, data_out => data_out );

    -- Clock generation
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process for applying inputs
    stim_proc: process
    begin
        -- Test reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test ADD instruction
        data_in <= "0000000000000001";  -- Example input value
        wait for 40 ns;
        
        -- Test SUB instruction
        data_in <= "0000000000000010";  -- Example input value
        wait for 40 ns;
        
        -- Add more tests here
        wait;
    end process;

end Behavior;
