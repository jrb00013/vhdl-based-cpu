library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;

architecture Behavior of testbench is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal data_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(15 downto 0);

    -- Component Declaration for the Unit Under Test (UUT)
    component cpu_top is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR(15 downto 0);
               data_out : out STD_LOGIC_VECTOR(15 downto 0)
               );
    end component;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: cpu_top Port map ( clk => clk, reset => reset, data_in => data_in, data_out => data_out );

    -- Clock Generation
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Apply inputs
        data_in <= "0000000000000101"; -- Example input value
        wait for 40 ns;
        
        -- Add more test cases here
        wait;
    end process;

end Behavior;
