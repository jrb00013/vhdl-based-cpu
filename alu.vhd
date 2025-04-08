library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           opcode : in STD_LOGIC_VECTOR(3 downto 0); -- ALU operation (e.g., ADD, AND, etc.)
           result : out STD_LOGIC_VECTOR(15 downto 0);
           zero_flag : out STD_LOGIC;
           carry_out : out STD_LOGIC;  -- Carry out for operations like addition
           overflow_flag : out STD_LOGIC  -- Overflow flag for signed operations
           );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, opcode)
    variable temp_result : STD_LOGIC_VECTOR(16 downto 0); -- Temporary result for carry-out and overflow
    begin
        case opcode is
            when "0000" =>  -- ADD
                temp_result := ('0' & A) + ('0' & B);
                result <= temp_result(15 downto 0);
                carry_out <= temp_result(16);
                overflow_flag <= (A(15) and B(15) and not result(15)) or (not A(15) and not B(15) and result(15));
            when "0001" =>  -- SUB
                temp_result := ('0' & A) - ('0' & B);
                result <= temp_result(15 downto 0);
                carry_out <= temp_result(16); -- Borrow flag (for subtraction)
                overflow_flag <= (A(15) and not B(15) and not result(15)) or (not A(15) and B(15) and result(15));
            when "0010" =>  -- AND
                result <= A and B;
                carry_out <= '0';
                overflow_flag <= '0';
            when "0011" =>  -- OR
                result <= A or B;
                carry_out <= '0';
                overflow_flag <= '0';
            -- Add more operations as necessary
            when others => 
                result <= (others => '0');
                carry_out <= '0';
                overflow_flag <= '0';
        end case;
        
        -- Set zero flag
        if result = "0000000000000000" then
            zero_flag <= '1';
        else
            zero_flag <= '0';
        end if;
    end process;
end Behavioral;
