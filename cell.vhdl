library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell is
   port (
       clk          : in std_logic;
       alive        : out std_logic;
       neighbours   : in std_logic_vector (7 downto 0)
       );
end cell;

architecture struct of cell is
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

            case (num_neighbours) is
                when 2 =>
                    alive <= '1';
                when 3 =>
                    alive <= '1';
                when others =>
                    alive <= '0';
            end case;
        end if;
    end process;
end struct;
