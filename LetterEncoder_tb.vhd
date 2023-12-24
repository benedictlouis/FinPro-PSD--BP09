LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY LetterEncoder_tb IS
END ENTITY LetterEncoder_tb;

ARCHITECTURE behavior OF LetterEncoder_tb IS
    SIGNAL Clk : STD_LOGIC;
    SIGNAL Decode_letter_in : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL D_enable : STD_LOGIC;
    SIGNAL Decode_letter_out, Encode_letter_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Decoded_letter, Encoded_letter : CHARACTER;

    COMPONENT LetterEncoder IS
        PORT (
            Clk : IN STD_LOGIC;
            Decode_letter_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            D_enable : IN STD_LOGIC;
            Decode_letter_out, Encode_letter_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            Decoded_letter, Encoded_letter : OUT CHARACTER
        );
    END COMPONENT LetterEncoder;

BEGIN
    UUT : LetterEncoder PORT MAP(
        Clk => Clk,
        Decode_letter_in => Decode_letter_in,
        D_enable => D_enable,
        Decode_letter_out => Decode_letter_out,
        Encode_letter_out => Encode_letter_out,
        Decoded_letter => Decoded_letter,
        Encoded_letter => Encoded_letter
    );

    tb : PROCESS
        CONSTANT period : TIME := 30 ns;
        VARIABLE Temp_decoded_letter, Temp_encoded_letter : CHARACTER;

    BEGIN
        D_enable <= '0';
        FOR i IN 0 TO 25 LOOP
            Decode_letter_in <= ascii_values(i);
            WAIT FOR period;
            Temp_encoded_letter := Encoded_letter;
            REPORT "Encoded letter: " & CHARACTER'image(Temp_encoded_letter);

            IF i = 25 THEN
                REPORT "Simulation finished successfully" SEVERITY FAILURE;
            END IF;
        END LOOP;
        WAIT;
    END PROCESS;
END behavior;