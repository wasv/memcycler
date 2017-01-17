LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY pctrl IS
  PORT ( inc    : IN  std_logic;
         run    : IN  std_logic;
         clk    : IN  std_logic;
         rw	    : OUT std_logic;
         datIn  : IN  std_logic_vector(0 TO 7);
         datOut : OUT std_logic_vector(0 TO 7);
         addrOut: OUT std_logic_vector(0 TO 3)
         );
END pctrl;

ARCHITECTURE struct OF pctrl IS
  SIGNAL sInc   : std_logic := '0';
  SIGNAL sAddr  : std_logic_vector(0 TO 3)  := (OTHERS => '0');
  SIGNAL sCnt   : std_logic_vector(0 TO 24) := (OTHERS => '0');

  COMPONENT counter
    GENERIC( bits : integer := 3);
    PORT ( inc   : IN  std_logic;
           reset : IN  std_logic;
           cnt   : OUT std_logic_vector(0 TO bits)
           );
  END COMPONENT counter;

  COMPONENT clkctrl IS
    PORT ( inc    : IN  std_logic;
           clk    : IN  std_logic;
           sel    : IN  std_logic;
           clkOut : OUT std_logic;
           state  : OUT std_logic
           );
  END COMPONENT clkctrl;
BEGIN
  clk_counter  : counter GENERIC MAP(bits => 24)
                         PORT MAP(inc => clk, reset => '1',
                                  cnt => sCnt);
  clkctrl0     : clkctrl PORT MAP(inc => inc, clk => sCnt(0),
                                  sel => run, clkOut=> sInc,
                                  state => rw);
  addr_counter : counter PORT MAP(inc => sInc, reset => run,
                                  cnt => sAddr);
  addrOut <= sAddr;
  datOut <= datIn;
END struct;
