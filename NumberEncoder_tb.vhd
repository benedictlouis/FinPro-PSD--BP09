LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

USE work.MorseTable.ALL;
USE work.MorseFunction.ALL;

ENTITY NumberEncoder_tb IS
END NumberEncoder_tb;

ARCHITECTURE Behavioral OF NumberEncoder_tb IS
    SIGNAL Clk : STD_LOGIC;
    SIGNAL Decode_number_in : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL D_enable : STD_LOGIC;
    SIGNAL Decode_number_out, Encode_number_out : STD_LOGIC_VECTOR (9 DOWNTO 0);

    COMPONENT NumberEncoder IS
        PORT (
            Clk : IN STD_LOGIC;
            Decode_number_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            D_enable : IN STD_LOGIC;
            Decode_number_out, Encode_number_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    END COMPONENT NumberEncoder;

BEGIN
    UUT : NumberEncoder PORT MAP(
        Clk => Clk,
        Decode_number_in => Decode_number_in,
        D_enable => D_enable,
        Decode_number_out => Decode_number_out,
        Encode_number_out => Encode_number_out
    );

    tb : PROCESS
        CONSTANT period : TIME := 30 ns;
    BEGIN
        D_enable <= '1';
        FOR i IN 0 TO 9 LOOP
            Decode_number_in <= binary_mumber(i);
            WAIT FOR period;
            REPORT "Decimal number: " & INTEGER'image(to_integer(unsigned(Decode_number_in)));
            REPORT "Encoded number: " & INTEGER'image(to_integer(unsigned(Encode_number_out)));

            IF i = 9 THEN
                REPORT "Simulation finished successfully" SEVERITY FAILURE;
            END IF;
        END LOOP;
        WAIT;
    END PROCESS;
END Behavioral;