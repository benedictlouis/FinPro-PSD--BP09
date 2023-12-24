library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

PACKAGE MorseTable IS
    TYPE morse_table_letter IS ARRAY (0 TO 25) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT morse_letter : morse_table_letter := (
        "01110000", -- A
        "11010101", -- B
        "11011101", -- C
        "11010100", -- D
        "01000000", -- E
        "01011101", -- F
        "11110100", -- G
        "01010101", -- H
        "01010000", -- I
        "01111111", -- J
        "11011100", -- K
        "01110101", -- L
        "11110000", -- M
        "11010000", -- N
        "11111100", -- O
        "01111101", -- P
        "11110111", -- Q
        "01110100", -- R
        "01010100", -- S
        "11000000", -- T
        "01011100", -- U
        "01010111", -- V
        "01111100", -- W
        "11010111", -- X
        "11011111", -- Y
        "11110101"  -- Z
    );

    TYPE morse_character is array(0 to 25) of character;
    constant chars : morse_character := (
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z'
    );

    TYPE morse_table_number IS ARRAY (0 TO 9) OF STD_LOGIC_VECTOR(9 DOWNTO 0);
    CONSTANT morse_number : morse_table_number := (
        "0111111111", -- 1
        "0101111111", -- 2
        "0101011111", -- 3
        "0101010111", -- 4
        "0101010101", -- 5
        "1101010101", -- 6
        "1111010101", -- 7
        "1111110101", -- 8
        "1111111101", -- 9
        "1111111111" -- 0
    );

    TYPE ascii_table IS ARRAY (0 TO 25) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT ascii_values : ascii_table := (
        "01000001", -- A
        "01000010", -- B
        "01000011", -- C
        "01000100", -- D
        "01000101", -- E
        "01000110", -- F
        "01000111", -- G
        "01001000", -- H
        "01001001", -- I
        "01001010", -- J
        "01001011", -- K
        "01001100", -- L
        "01001101", -- M
        "01001110", -- N
        "01001111", -- O
        "01010000", -- P
        "01010001", -- Q
        "01010010", -- R
        "01010011", -- S
        "01010100", -- T
        "01010101", -- U
        "01010110", -- V
        "01010111", -- W
        "01011000", -- X
        "01011001", -- Y
        "01011010"  -- Z
    );

    TYPE number_table IS ARRAY (0 TO 9) OF STD_LOGIC_VECTOR(9 DOWNTO 0);
    CONSTANT binary_mumber : number_table := (
        "0000000001", -- 1
        "0000000010", -- 2
        "0000000011", -- 3
        "0000000100", -- 4
        "0000000101", -- 5
        "0000000110", -- 6
        "0000000111", -- 7
        "0000001000", -- 8
        "0000001001", -- 9
        "0000000000" -- 0
    );
END MorseTable;