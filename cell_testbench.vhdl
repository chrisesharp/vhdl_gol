library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity cell_testbench is
end cell_testbench;

architecture test_fixture of cell_testbench is
  constant  half_period     : time      := 1 ns;
  signal    clk             : std_logic :='0';
  signal    alive_test      : std_logic;
  signal    neighbours_test : unsigned(7 downto 0) := "00000001";

begin
    UUT: entity work.cell
      port map (
         clk => clk,
         alive => alive_test,
         neighbours => std_logic_vector(neighbours_test)
      );

    test_neighbours: process
    begin
      report "Test zero neighbours";
      clk <= '1';
      wait for half_period;
      assert (alive_test = '0') -- dead
        report "Cell state incorrect"
        severity failure;
      clk <= '0';
      wait for half_period;

      report "Test one neighbour";
      neighbours_test <= "00000001";
      clk <= '1';
      wait for half_period;
      assert (alive_test = '0') -- dead
        report "Cell state incorrect"
        severity failure;
      clk <= '0';
      wait for half_period;

      report "Test three neighbours";
      neighbours_test <= "00000111";
      clk <= '1';
      wait for half_period;
      assert (alive_test = '1') -- alive
        report "Cell state incorrect"
        severity failure;
      clk <= '0';
      wait for half_period;

      report "Test two different neighbours";
      neighbours_test <= "00011000";
      clk <= '1';
      wait for half_period;
      assert (alive_test = '1') -- alive
        report "Cell state incorrect"
        severity failure;
      clk <= '0';
      wait for half_period;



      assert false report "End of tests" severity note;
      wait;

   end process;
end test_fixture;
