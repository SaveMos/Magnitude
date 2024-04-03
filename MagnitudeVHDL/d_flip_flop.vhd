library IEEE;
use IEEE.std_logic_1164.all;

entity d_flip_flop is
    generic ( 
		NUM : Positive := 10
	);
	port (
		clk : in std_logic;
        resetn : in std_logic;
        en : in std_logic;

        di : in std_logic_vector(NUM - 1 downto 0);
        do : out std_logic_vector(NUM - 1 downto 0)
	);

end entity;

architecture rtl of d_flip_flop is

    signal di_s : std_logic_vector(NUM - 1 downto 0);
    signal do_s : std_logic_vector(NUM - 1 downto 0);

begin
    p_DFF: process(clk , resetn)
	
    begin
        if resetn = '0' then
            do_s <= (others => '0'); --reset
        elsif rising_edge(clk) then
            do_s <= di_s; -- leggo l'input corrente.
        end if;
    end process;

    di_s <= di when en ='1' else do_s; 
    -- implementazione del multiplexer.
    -- cioè, implementa la condizione dell' enable.

    do <= do_s; -- do_s è uguale all'output.

end architecture;