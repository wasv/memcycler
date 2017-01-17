LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY clkctrl IS
  PORT ( inc    : IN  std_logic;
         clk    : IN  std_logic;
         sel    : IN  std_logic;
         clkOut : OUT std_logic;
         state  : OUT std_logic
         );
END clkctrl;

ARCHITECTURE behv OF clkctrl IS
BEGIN
  PROCESS (inc, clk, sel)
    VARIABLE vState : std_logic := '0';
  BEGIN
    IF (sel'event AND sel = '1') THEN
      vState := NOT vState;
    END IF;
    CASE vState IS
      WHEN '1'    => clkOut <= clk;
      WHEN '0'    => clkOut <= inc;
      WHEN OTHERS => clkOut <= '0';
    END CASE;
    state <= vState;
  END PROCESS;
END behv;
