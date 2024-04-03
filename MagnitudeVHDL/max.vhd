library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity max is
	generic (
		NUM : positive := 10
	);
	port (
		a : in std_logic_vector(NUM -1 downto 0);
		b : in std_logic_vector(NUM -1 downto 0);
		y : out std_logic_vector(NUM -1 downto 0)
	);

end entity;

architecture dataflow of max is
begin
	minProc : process (a, b)
	begin
		if (a >= b) then
			y <= a;
		else
			y <= b;
		end if;
	end process;
end architecture;