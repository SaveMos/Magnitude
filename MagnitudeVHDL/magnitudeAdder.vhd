library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity magnitudeAdder is
    generic (
        NUM : positive := 10
    );
    port (
        max : in std_logic_vector(NUM - 1 downto 0); -- Unsigned
        min : in std_logic_vector(NUM - 1 downto 0); -- Unsigned
        y : out std_logic_vector(NUM downto 0) -- Unsigned
    );

end entity;

architecture dataflow of magnitudeAdder is
    signal newMax : std_logic_vector(NUM downto 0);
    signal newMin : std_logic_vector(NUM downto 0);

    signal minShift1 : unsigned(NUM downto 0);
    signal sum1 : unsigned(NUM downto 0);
    signal sum2 : unsigned(NUM downto 0);
    signal sumShift4 : unsigned(NUM downto 0);
    signal diff : unsigned(NUM downto 0);

   
begin
    newMax <= ('0' & max(NUM - 1 downto 0)); -- Extend the number to NUM + 1 bits.
    newMin <= ('0' & min(NUM - 1 downto 0)); -- Extend the number to NUM + 1 bits.
    
    minShift1 <= shift_right(unsigned(newMin), 1); -- divide by 2 the minimum.
    sum1 <= unsigned(newMax) + minShift1; -- Sum the max and the shifted minimum.
    -- The sum surely stay in NUM+1 bits.

    sum2 <= unsigned(newMax) + unsigned(newMin); -- Sum the max and the minimum.
    sumShift4 <= shift_right(sum2, 4); -- divide by 16 the latter sum.
    -- The sum surely stay in NUM+1 bits.

    diff <= (sum1 - sumShift4); -- Compute the difference.
    -- The difference surely stay in NUM+1 bits.

    y <= std_logic_vector(diff); -- Output
end architecture;