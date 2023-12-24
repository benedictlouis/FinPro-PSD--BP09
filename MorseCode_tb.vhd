-- MorseCode_tb.vhd
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY MorseCode_tb IS
END MorseCode_tb;

ARCHITECTURE Behavioral OF MorseCode_tb IS
    COMPONENT MorseCode
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
    END COMPONENT;

    SIGNAL Clk : STD_LOGIC;
    SIGNAL Decode_letter_in : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL D_enable : STD_LOGIC;
    SIGNAL mode_letter, mode_number : STD_LOGIC;
    SIGNAL Decode_number_in : STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Decode_letter_out, Encode_letter_out : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Decoded_letter, Encoded_letter : CHARACTER;
    SIGNAL Decode_number_out, Encode_number_out : STD_LOGIC_VECTOR (9 DOWNTO 0);

BEGIN
    uut : MorseCode PORT MAP(
        Clk => Clk,
        Decode_letter_in => Decode_letter_in,
        D_enable => D_enable,
        mode_letter => mode_letter,
        mode_number => mode_number,
        Decode_number_in => Decode_number_in,
        Decode_letter_out => Decode_letter_out,
        Encode_letter_out => Encode_letter_out,
        Decoded_letter => Decoded_letter,
        Encoded_letter => Encoded_letter,
        Decode_number_out => Decode_number_out,
        Encode_number_out => Encode_number_out
    );

    TB_MorseLetter : PROCESS
        CONSTANT period : TIME := 30 ns;
        VARIABLE Temp_decoded_letter, Temp_encoded_letter : CHARACTER;

    BEGIN
        D_enable <= '0';
        mode_letter <= '1';

        FOR i IN 0 TO 25 LOOP
            Decode_letter_in <= ascii_values(i);
            WAIT FOR period;
            Temp_decoded_letter := Decoded_letter;
            Temp_encoded_letter := Encoded_letter;
            REPORT "Decoded letter: " & CHARACTER'image(Temp_decoded_letter);
            REPORT "Encoded letter: " & CHARACTER'image(Temp_encoded_letter);

            IF i = 25 THEN
                REPORT "Simulation finished successfully" SEVERITY FAILURE;
            END IF;
        END LOOP;
        WAIT;
    END PROCESS;


END Behavioral;