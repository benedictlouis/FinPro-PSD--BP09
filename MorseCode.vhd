LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY MorseCode IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        mode_letter, mode_number : IN STD_LOGIC;
        Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        Decode_letter_out, Encode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Decoded_letter, Encoded_letter : OUT CHARACTER;
        Decode_number_out, Encode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END MorseCode;

ARCHITECTURE Behavioral OF MorseCode IS
    TYPE morse_state IS (IDLE, DECODE_LETTER, ENCODE_LETTER, DECODE_NUMBER, ENCODE_NUMBER);
    SIGNAL present_state, next_state : morse_state;
    SIGNAL Temp_number, Temp_decode_number, Temp_encode_number : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Temp_decode_out, Temp_encode_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (
            present_state, 
            Decode_letter_in, 
            Decode_number_in, 
            Temp_decode_out, 
            Temp_encode_out, 
            Temp_number, 
            Temp_decode_number, 
            Temp_encode_number
            )

        VARIABLE Temp_decoded_letter, Temp_encoded_letter : CHARACTER;
        
    BEGIN
        IF D_enable = '0' THEN
            CASE present_state IS
                WHEN IDLE =>
                    next_state <= DECODE_LETTER;

                WHEN DECODE_LETTER =>
                    Temp_decode_out <= decode_morse_letter(Decode_letter_in);
                    Decode_letter_out <= Temp_decode_out;

                    Temp_decoded_letter := morse_to_char(Temp_decode_out);
                    Decoded_letter <= Temp_decoded_letter;

                    REPORT "Decoded letter: " & CHARACTER'image(Temp_decoded_letter);

                    IF mode_letter = '1' THEN
                        next_state <= ENCODE_LETTER;
                    ELSE
                        next_state <= IDLE;
                    END IF;

                WHEN ENCODE_LETTER =>
                    Temp_encode_out <= encode_morse_letter(Temp_decode_out);
                    Encode_letter_out <= Temp_encode_out;

                    Temp_encoded_letter := ascii_to_char(Temp_encode_out);
                    Encoded_letter <= Temp_encoded_letter;

                    REPORT "Encoded letter: " & CHARACTER'image(Temp_encoded_letter);

                    next_state <= IDLE;

                WHEN OTHERS =>
                    next_state <= IDLE;

            END CASE;

        ELSIF D_enable = '1' THEN
            CASE present_state IS

                WHEN IDLE =>
                    next_state <= DECODE_NUMBER;

                WHEN DECODE_NUMBER =>
                    Temp_decode_number <= decode_morse_number(Decode_number_in);
                    Decode_number_out <= Temp_decode_number;

                    REPORT "Decoded number: " & INTEGER'image(to_integer(unsigned(Decode_number_in)));

                    IF mode_number = '1' THEN
                        next_state <= ENCODE_NUMBER;
                    ELSE
                        next_state <= IDLE;
                    END IF;

                WHEN ENCODE_NUMBER =>
                    Temp_encode_number <= encode_morse_number(Temp_decode_number);
                    Encode_number_out <= Temp_encode_number;

                    REPORT "Encoded number: " & INTEGER'image(to_integer(unsigned(Temp_encode_number)));

                    next_state <= IDLE;

                WHEN OTHERS =>
                    next_state <= IDLE;

            END CASE;
        END IF;
    END PROCESS;

    PROCESS (Clk, next_state)
    BEGIN
        IF rising_edge(Clk) THEN
            present_state <= next_state;
        END IF;
    END PROCESS;
END Behavioral;