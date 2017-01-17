LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY tff IS
  PORT ( t    : IN  std_logic;
         clk  : IN  std_logic;
         reset: IN  std_logic;
         q    : OUT std_logic;
         qp   : OUT std_logic
         );
END tff;

ARCHITECTURE behv OF tff IS
BEGIN
  PROCESS (clk, reset)
    VARIABLE vState : std_logic := '0';
  BEGIN
    IF (reset = '0') THEN
      vState := '0';
      q <= vState;
      qp <= NOT vState;
    ELSIF (clk'event AND clk = '1') THEN
      IF (t = '1') THEN
        vState := NOT vState;
        q <= vState;
        qp <= NOT vState;
      END IF;
    END IF;
  END PROCESS;

END behv;
