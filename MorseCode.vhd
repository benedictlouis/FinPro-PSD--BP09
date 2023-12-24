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
        mode_letter, mode_number : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        A, B : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        ALU_Out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        Decode_letter_out, Encode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Decoded_letter, Encoded_letter : OUT CHARACTER;
        Decode_number_out, Encode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END MorseCode;

ARCHITECTURE Behavioral OF MorseCode IS
    TYPE morse_state IS (IDLE, DECODE_LETTER, ENCODE_LETTER, DECODE_NUMBER, ADD_STATE);
    SIGNAL present_state, next_state : morse_state;
    SIGNAL Temp_number : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Temp_letter, Temp_letter_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (present_state, Decode_letter_in, Decode_number_in, Temp_letter, Temp_number)
        VARIABLE Temp_decoded_letter, Temp_encoded_letter : CHARACTER;
    BEGIN
        IF D_enable = '0' THEN
            CASE present_state IS
                WHEN IDLE =>
                    next_state <= DECODE_LETTER;

                WHEN DECODE_LETTER =>
                    Temp_letter <= decode_morse_letter(Decode_letter_in);
                    Temp_letter_out <= Temp_letter;
                    Decode_letter_out <= Temp_letter_out;

                    Temp_decoded_letter := morse_to_char(Temp_letter);
                    Decoded_letter <= Temp_decoded_letter;

                    REPORT "Decoded letter: " & CHARACTER'image(Temp_decoded_letter);

                    IF mode_letter = "001" THEN
                        next_state <= ENCODE_LETTER;
                    ELSE 
                        next_state <= IDLE;
                    END IF;

                WHEN ENCODE_LETTER =>
                    Temp_letter <= encode_morse_letter(Temp_letter_out);
                    Encode_letter_out <= Temp_letter;

                    Temp_encoded_letter := ascii_to_char(Temp_letter);
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
                    Decode_number_out <= decode_morse_number(Decode_number_in);
                    next_state <= ADD_STATE;

                WHEN ADD_STATE =>
                    IF mode_number = "000" THEN
                        Temp_number <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
                        Decode_number_out <= decode_morse_number(Temp_number);
                        next_state <= IDLE;
                    ELSIF mode_number = "001" THEN
                        Temp_number <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));
                        Decode_number_out <= decode_morse_number(Temp_number);
                        next_state <= IDLE;
                    ELSE
                        Decode_number_out <= "0000000000"; -- 0
                    END IF;

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