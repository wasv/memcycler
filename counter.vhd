LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY counter IS
    GENERIC( bits : integer := 3);
    PORT ( inc   : IN  std_logic;
           reset : IN  std_logic;
           cnt   : OUT std_logic_vector(0 TO bits)
       );
END counter;

ARCHITECTURE behv OF counter IS
BEGIN
    PROCESS (inc, reset)
        VARIABLE vCnt : unsigned(0 TO bits) := (OTHERS => '0');
    BEGIN
        IF (reset = '0') THEN
            vCnt := (OTHERS => '0');
        ELSIF (inc'event AND inc ='1') THEN
            vCnt := vCnt + 1;
        END IF;
        cnt <= std_logic_vector(vCnt);
    END PROCESS;
END behv;
