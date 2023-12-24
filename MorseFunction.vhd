LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.MorseTable.ALL;

-- Package specification
PACKAGE MorseFunction IS
    FUNCTION decode_morse_letter(ascii : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION encode_morse_letter(morse : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION decode_morse_number(number : STD_LOGIC_VECTOR(9 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION encode_morse_number(morse : STD_LOGIC_VECTOR(9 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION morse_to_char(morse : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN CHARACTER;
    FUNCTION ascii_to_char (ascii : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN CHARACTER;
END MorseFunction;

-- Package body
PACKAGE BODY MorseFunction IS
    FUNCTION decode_morse_letter(ascii : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE i : INTEGER RANGE 0 TO 25;
    BEGIN
        FOR i IN 0 TO 25 LOOP
            IF ascii = ascii_values(i) THEN
                RETURN morse_letter(i);
            END IF;
        END LOOP;
        RETURN "00000000"; -- Return '0' if no match is found
    END FUNCTION decode_morse_letter;

    FUNCTION encode_morse_letter(morse : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE i : INTEGER RANGE 0 TO 25;
    BEGIN
        FOR i IN 0 TO 25 LOOP
            IF morse = morse_letter(i) THEN
                RETURN ascii_values(i);
            END IF;
        END LOOP;
        RETURN "00000000"; -- Return '0' if no match is found
    END FUNCTION encode_morse_letter;

    FUNCTION decode_morse_number(number : STD_LOGIC_VECTOR(9 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE i : INTEGER RANGE 0 TO 9;
    BEGIN
        FOR i IN 0 TO 9 LOOP
            IF number = binary_mumber(i) THEN
                RETURN morse_number(i);
            END IF;
        END LOOP;
        RETURN "0000000000"; -- Return '0' if no match is found
    END FUNCTION decode_morse_number;

    FUNCTION encode_morse_number(morse : STD_LOGIC_VECTOR(9 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE i : INTEGER RANGE 0 TO 9;
    BEGIN
        FOR i IN 0 TO 9 LOOP
            IF morse = morse_number(i) THEN
                RETURN binary_mumber(i);
            END IF;
        END LOOP;
        RETURN "0000000000"; -- Return '0' if no match is found
    END FUNCTION encode_morse_number;

    FUNCTION morse_to_char(morse : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN CHARACTER IS
    BEGIN
        FOR i IN 0 TO 25 LOOP
            IF morse = morse_letter(i) THEN
                RETURN chars(i);
            END IF;
        END LOOP;
        RETURN ' ';
    END FUNCTION morse_to_char;

    FUNCTION ascii_to_char(ascii : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN CHARACTER IS
    BEGIN
        FOR i IN 0 TO 25 LOOP
            IF ascii = ascii_values(i) THEN
                RETURN chars(i);
            END IF;
        END LOOP;
        RETURN ' ';
    END FUNCTION ascii_to_char;

END MorseFunction;