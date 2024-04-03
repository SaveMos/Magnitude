library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity absolute_value is
    generic (
        NUM : positive := 10
    );
    port (
        x : in std_logic_vector(NUM - 1 downto 0);
        y : out std_logic_vector(NUM - 1 downto 0)
    );

end entity;

architecture dataflow of absolute_value is
    begin
        absProc : process (x)
        begin
            y <= std_logic_vector(abs(signed(x)));
        end process;
    end architecture;