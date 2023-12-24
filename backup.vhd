LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.MorseTable.all;

ENTITY MorseCode IS
  PORT (
    Clk : IN STD_LOGIC;
    Decode_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    Encode_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    D_enable : IN STD_LOGIC;
    E_enable : IN STD_LOGIC;
    Decode_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    Encode_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
END MorseCode;

ARCHITECTURE Behavioral OF MorseCode IS
  TYPE morse_state IS (IDLE, DECODE, ENCODE);
  SIGNAL present_state, next_state : morse_state;

  FUNCTION decode_morse(morse : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
    VARIABLE i : INTEGER RANGE 0 TO 25;
  BEGIN
    FOR i IN 0 TO 25 LOOP
      IF morse = morse_values(i) THEN
        RETURN ascii_values(i);
      END IF;
    END LOOP;
    RETURN "00000000"; -- Return '0' if no match is found
  END FUNCTION decode_morse;

  FUNCTION encode_morse(ascii : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
    VARIABLE i : INTEGER RANGE 0 TO 25;
  BEGIN
    FOR i IN 0 TO 25 LOOP
      IF ascii = ascii_values(i) THEN
        RETURN morse_values(i);
      END IF;
    END LOOP;
    RETURN "00000000"; -- Return '0' if no match is found
  END FUNCTION encode_morse;
  

BEGIN
  PROCESS (Decode_in, Encode_in, present_state)
  BEGIN
    CASE present_state IS
      WHEN IDLE =>
        next_state <= DECODE;

      WHEN DECODE =>
        IF D_enable = '1' THEN
          Decode_out <= decode_morse(Decode_in);
        ELSE
          Decode_out <= "00000000"; -- 0
        END IF;
        next_state <= ENCODE;
        
      WHEN ENCODE =>
        IF E_enable = '1' THEN
          Encode_out <= encode_morse(Encode_in);
        ELSE
          Encode_out <= "00000000"; -- 0
        END IF;
        next_state <= IDLE;

    END CASE;
  END PROCESS;

  PROCESS (Clk)
  BEGIN
    IF rising_edge(Clk) THEN
      present_state <= next_state;
    END IF;
  END PROCESS;
END Behavioral;

Decoded_letter : OUT CHARACTER;


signal Temp_decoded_letter : CHARACTER;

Temp_decoded_letter <= morse_to_char(Decode_letter_out);
                    Decoded_letter <= Temp_decoded_letter;
                    report "Decoded letter: " & Character'image(Temp_decoded_letter);