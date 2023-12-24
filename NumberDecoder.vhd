LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY NumberDecoder IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        Decode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END NumberDecoder;

ARCHITECTURE Behavioral OF NumberDecoder IS
BEGIN
    PROCESS (Decode_number_in, D_enable, Clk)
    BEGIN
        IF rising_edge(Clk) THEN
            IF D_enable = '1' THEN
                Decode_number_out <= decode_morse_number(Decode_number_in);
            ELSE
                Decode_number_out <= "0000000000"; -- 0
            END IF;
        END IF;
    END PROCESS;
END Behavioral;