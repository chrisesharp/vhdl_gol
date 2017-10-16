library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity board is
   port (
      clk          : in std_logic
      );
end board;

architecture struct of board is

begin
    process (clk)

    begin
        if rising_edge(clk) then
        end if;
    end process;
end struct;
