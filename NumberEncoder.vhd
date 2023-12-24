LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY NumberEncoder IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        Decode_number_out, Encode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END NumberEncoder;

ARCHITECTURE Behavioral OF NumberEncoder IS
SIGNAL Temp_decode_number : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (Decode_number_in, D_enable, Clk)
    BEGIN
        IF rising_edge(Clk) THEN
            IF D_enable = '1' THEN
                Temp_decode_number <= decode_morse_number(Decode_number_in);
                Decode_number_out <= Temp_decode_number;

                Encode_number_out <= encode_morse_number(Temp_decode_number);
            ELSE
                Encode_number_out <= "0000000000"; -- 0
            END IF;
        END IF;
    END PROCESS;
END Behavioral;