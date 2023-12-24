LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY test_portmap IS
    PORT (
        Clk : IN STD_LOGIC;
        Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        D_enable : IN STD_LOGIC;
        mode : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        A, B : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        ALU_Out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        Decode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        Decoded_letter : OUT CHARACTER;
        Decode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        Encode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END test_portmap;

ARCHITECTURE Behavioral OF test_portmap IS
    TYPE morse_state IS (IDLE, DECODE_LETTER, DECODE_NUMBER, ADD_STATE);
    SIGNAL present_state, next_state : morse_state;
    SIGNAL Temp_number : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Temp_letter : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    COMPONENT LetterDecoder IS
        PORT (
            Clk : IN STD_LOGIC;
            Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            D_enable : IN STD_LOGIC;
            Decode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT LetterDecoder;

    COMPONENT NumberDecoder IS
        PORT (
            Clk : IN STD_LOGIC;
            Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            D_enable : IN STD_LOGIC;
            Decode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    END COMPONENT NumberDecoder;

BEGIN
    UUT_LetterDecoder : LetterDecoder PORT MAP(
        Clk => Clk,
        Decode_letter_in => Decode_letter_in,
        D_enable => D_enable,
        Decode_letter_out => Decode_letter_out
    );

    UUT_NumberDecoder : NumberDecoder PORT MAP(
        Clk => Clk,
        Decode_number_in => Decode_number_in,
        D_enable => D_enable,
        Decode_number_out => Decode_number_out
    );

    PROCESS (present_state, Decode_letter_in, Decode_number_in, Temp_letter, Temp_number)

    VARIABLE Temp_decoded_letter : CHARACTER;

    BEGIN
        CASE present_state IS
            WHEN IDLE =>
                IF D_enable = '0' THEN
                    next_state <= DECODE_LETTER;
                ELSIF D_enable = '1' THEN
                    next_state <= DECODE_NUMBER;
                END IF;

            WHEN DECODE_LETTER =>
                IF D_enable = '0' THEN
                    Temp_letter <= decode_morse_letter(Decode_letter_in);
                    Decode_letter_out <= Temp_letter;

                    Temp_decoded_letter := morse_to_char(Temp_letter);
                    Decoded_letter <= Temp_decoded_letter;

                    REPORT "Decoded letter: " & CHARACTER'image(Temp_decoded_letter);

                    next_state <= IDLE;
                ELSE
                    Decode_letter_out <= "00000000"; -- 0
                END IF;

            WHEN DECODE_NUMBER =>
                IF D_enable = '1' THEN
                    Decode_number_out <= decode_morse_number(Decode_number_in);
                    next_state <= ADD_STATE;
                ELSE
                    Decode_number_out <= "0000000000"; -- 0
                    next_state <= ADD_STATE;
                END IF;

            WHEN ADD_STATE =>
                IF mode = "000" THEN
                    Temp_number <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
                    Decode_number_out <= decode_morse_number(Temp_number);

                ELSIF mode = "001" THEN
                    Temp_number <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));
                    Decode_number_out <= decode_morse_number(Temp_number);
                ELSE
                    Decode_number_out <= "0000000000"; -- 0
                END IF;
        END CASE;
    END PROCESS;

    PROCESS (Clk)
    BEGIN
        IF rising_edge(Clk) THEN
            present_state <= next_state;
        END IF;
    END PROCESS;
END Behavioral;