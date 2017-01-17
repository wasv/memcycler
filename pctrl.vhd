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
  SIGNAL sRun   : std_logic := '0';
  SIGNAL sInc   : std_logic := '0';
  SIGNAL sClk   : std_logic := '0';
  SIGNAL sAddr  : std_logic_vector(0 TO 3)  := (OTHERS => '0');
  SIGNAL sCnt   : std_logic_vector(0 TO 24) := (OTHERS => '0');
  COMPONENT tff
    PORT ( t    : IN  std_logic;
           clk  : IN  std_logic;
           reset: IN  std_logic;
           q    : OUT std_logic;
           qp   : OUT std_logic
           );
  END COMPONENT tff;

  COMPONENT counter
    GENERIC( bits : integer := 3);
    PORT ( inc   : IN  std_logic;
           reset : IN  std_logic;
           cnt   : OUT std_logic_vector(0 TO bits)
           );
  END COMPONENT counter;

  COMPONENT mux
    PORT ( a    : IN  std_logic;
           b    : IN  std_logic;
           sel  : IN  std_logic;
           f    : OUT std_logic
           );
  END COMPONENT mux;
BEGIN
  clk_counter  : counter GENERIC MAP(bits => 24)
                         PORT MAP(inc => clk, reset => '1',
                                  cnt => sCnt);
  clk_tff      : tff     PORT MAP(t => sRun, clk => sCnt(24),
                                  reset => run, q => sClk);
  addr_counter : counter PORT MAP(inc => sInc, reset => run,
                                  cnt => sAddr);
  ce_tff       : tff     PORT MAP(t => '1', clk => run,
                                  reset => '1' , q => sRun);
  inc_mux      : mux     PORT MAP(a => sClk, b=>inc,
                                  sel => sRun, f => sInc);
  addrOut <= sAddr;
  rw <= sRun;
  datOut <= datIn;
END struct;
