library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( opcode : in STD_LOGIC_VECTOR(3 downto 0);
           reg_write : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR(3 downto 0);
           mem_read : out STD_LOGIC;
           mem_write : out STD_LOGIC;
           branch : out STD_LOGIC;
           mem_to_reg : out STD_LOGIC;
           alu_src : out STD_LOGIC
           );
end control_unit;

architecture Behavioral of control_unit is
begin
    process(opcode)
    begin
        case opcode is
            when "0000" => -- ADD instruction
                reg_write <= '1';
                alu_op <= "0000";  -- ALU add
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '0';
            when "0001" => -- SUB instruction
                reg_write <= '1';
                alu_op <= "0001";  -- ALU subtract
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '0';
            -- Add more instructions as necessary
            when others =>
                reg_write <= '0';
                alu_op <= "0000";  -- Default ALU operation
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                mem_to_reg <= '0';
                alu_src <= '0';
        end case;
    end process;
end Behavioral;
