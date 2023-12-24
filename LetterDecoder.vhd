LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY LetterDecoder IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        Decode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Decoded_letter : OUT CHARACTER
    );
END LetterDecoder;

ARCHITECTURE Behavioral OF LetterDecoder IS
    SIGNAL Temp_letter : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (Decode_letter_in, D_enable, Clk)
        VARIABLE Temp_decoded_letter : CHARACTER;
    BEGIN
        IF rising_edge(Clk) THEN
            IF D_enable = '0' THEN
                Temp_letter <= decode_morse_letter(Decode_letter_in);
                Decode_letter_out <= Temp_letter;

                Temp_decoded_letter := morse_to_char(Temp_letter);
                Decoded_letter <= Temp_decoded_letter;
            ELSE
                Decode_letter_out <= "00000000"; -- 0
            END IF;
        END IF;
    END PROCESS;
END Behavioral;