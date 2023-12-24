LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY LetterEncoder IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        Decode_letter_out, Encode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Decoded_letter, Encoded_letter : OUT CHARACTER
    );
END LetterEncoder;

ARCHITECTURE Behavioral OF LetterEncoder IS
    SIGNAL Temp_letter_decode, Temp_letter_encode, Temp_letter_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (Decode_letter_in, D_enable, Clk)
        VARIABLE Temp_decoded_letter, Temp_encoded_letter : CHARACTER;
    BEGIN
        IF rising_edge(Clk) THEN
            IF D_enable = '0' THEN
                Temp_letter_decode <= decode_morse_letter(Decode_letter_in);
                Temp_letter_out <= Temp_letter_decode;
                Decode_letter_out <= Temp_letter_decode;

                Temp_decoded_letter := morse_to_char(Temp_letter_decode);
                Decoded_letter <= Temp_decoded_letter;

                Temp_letter_encode <= encode_morse_letter(Temp_letter_out);
                Encode_letter_out <= Temp_letter_encode;

                Temp_encoded_letter := ascii_to_char(Temp_letter_encode);
                Encoded_letter <= Temp_encoded_letter;
            ELSE
                Decode_letter_out <= "00000000"; -- 0
            END IF;
        END IF;
    END PROCESS;

END Behavioral;