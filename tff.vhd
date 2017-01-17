LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY tff IS
  PORT ( t    : IN  std_logic;
         clk  : IN  std_logic;
         q    : OUT std_logic;
         qp   : OUT std_logic
         );
END tff;

ARCHITECTURE rtl OF tff IS
  SIGNAL sS, sR, sQ, sQP : std_logic <= 0;
BEGIN
  sS  <= NOT(t AND clk AND sQP);
  sR  <= NOT(t AND clk AND sQ);

  sQ  <= sS NAND sQP;
  sQP <= sR NAND sQ;

  q   <= sQ;
  qp  <= sQP;
END rtl;
