LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY mux IS
    PORT ( a    : IN  std_logic;
           b    : IN  std_logic;
           sel  : IN  std_logic;
           f    : OUT std_logic
       );
END mux;

ARCHITECTURE rtl OF mux IS
BEGIN
    f <= (a AND sel) OR (b AND NOT sel);
END rtl;

