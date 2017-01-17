LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY counter IS
  GENERIC( bits : integer := 4);
  PORT ( inc   : IN  std_logic;
         reset : IN  std_logic;
         cnt   : OUT std_logic_vector(0 TO bits)
         );
END counter;

ARCHITECTURE struct OF counter IS
  SIGNAL sCnt : std_logic_vector(0 TO bits+1) := (OTHERS => '1');
  COMPONENT tff
    PORT ( t    : IN  std_logic;
           clk  : IN  std_logic;
           reset: IN  std_logic;
           q    : OUT std_logic;
           qp   : OUT std_logic
           );
  END COMPONENT tff;
BEGIN
  sCnt(0) <= inc;

  cntr: FOR n IN 0 TO bits GENERATE
    bit_tff : tff PORT MAP(t => '1', clk => sCnt(n),
                           reset => reset,
                           q => sCnt(n+1));
  END GENERATE;

  cnt <= NOT sCnt(1 DOWNTO bits+1);
END struct;
