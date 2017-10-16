library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell is
   port (
      clk          : in std_logic;
      neighbours   : in std_logic_vector (7 downto 0) := "00000000";
      liveness     : out std_logic
      );
end cell;

architecture struct of cell is
    type cell_type IS (alive, dead);
    signal state : cell_type := dead;

    function count_ones(s : std_logic_vector) return natural is
        variable count : natural := 0;
    begin
        for i in s'range loop
            if s(i) = '1' then count := count + 1;
            end if;
        end loop;
        return count;
    end function count_ones;

begin
    process (clk, neighbours)
        variable num_neighbours: natural := 0;

    begin
        if rising_edge(clk) then
            num_neighbours := count_ones(neighbours);
            case (state) is
              when alive =>
                if (num_neighbours = 2 or num_neighbours = 3) then
                  liveness <= '1';
                else
                  liveness <= '0';
                  state <= dead;
                end if;
              when dead  =>
                if (num_neighbours = 3) then
                  liveness <= '1';
                  state <= alive;
                else
                  liveness <= '0';
                end if;
            end case;

        end if;
    end process;
end struct;
