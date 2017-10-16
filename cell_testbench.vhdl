library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity cell_testbench is
end cell_testbench;

architecture test_fixture of cell_testbench is
  constant  half_period     : time      := 1 ns;
  signal    clk             : std_logic :='0';
  signal    alive           : std_logic :='0';
  signal    neighbours_test : std_logic_vector(7 downto 0) := (others => '0');

  procedure run_test (
            signal    test_clk        : out std_logic;
            signal    test_alive      : in std_logic;
            constant  neighbours_in   : in std_logic_vector(7 downto 0);
            signal    neighbours_out  : out std_logic_vector(7 downto 0);
            constant  expected        : in std_logic) is
  begin
    neighbours_out <= neighbours_in;
    test_clk <= '1';
    wait for half_period;
    assert (test_alive = expected)
      report "Cell state incorrect"
      severity failure;
    test_clk <= '0';
    wait for half_period;
  end procedure;

begin
    UUT: entity work.cell
      port map (
         clk => clk,
         liveness => alive,
         neighbours => neighbours_test
      );

    test_neighbours: process
    begin
      report "Test dead cell zero neighbours stays dead";
      run_test(clk, alive, "00000000", neighbours_test, '0');

      report "Test dead cell with one neighbour stays dead";
      run_test(clk, alive, "00000001", neighbours_test, '0');

      report "Test dead cell with another neighbour stays dead";
      run_test(clk, alive, "01000000", neighbours_test, '0');

      report "Test dead cell with two neighbours stays dead";
      run_test(clk, alive, "00011000", neighbours_test, '0');

      report "Test dead cell with three neighbours comes alive";
      run_test(clk, alive, "00000111", neighbours_test, '1');

      report "Test live cell with two different neighbours stays alive";
      run_test(clk, alive, "00100100", neighbours_test, '1');

      report "Test live cell with four neighbours dies";
      run_test(clk, alive, "00110101", neighbours_test, '0');

      assert false report "End of tests" severity note;
      wait;

   end process;
end test_fixture;
