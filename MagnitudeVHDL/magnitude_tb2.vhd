library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity magnitude_tb2 is
end entity;

architecture beh of magnitude_tb2 is
    constant CLK_PERIOD : time := 100 ns; -- Clock period duration.
    constant NUME : positive := 10; -- Number of bits of the inputs.

    component Magnitude is
        generic (
            N : positive := NUME
        );
        port (
            realPart : in std_logic_vector(N - 1 downto 0);
            imgPart : in std_logic_vector(N - 1 downto 0);
            y : out std_logic_vector(N downto 0);
            clk : in std_logic;
            resetn : in std_logic;
            en : in std_logic
        );
    end component;

    signal clk : std_logic := '0'; -- Initialized to 0.
    signal reset_s : std_logic := '0'; -- Initialized to 0.
    signal enable_s : std_logic := '0'; -- Initialized to 0.
    signal input_Real : std_logic_vector (NUME - 1 downto 0) := (others => '0'); -- Initialized to 0.
    signal input_Img : std_logic_vector (NUME - 1 downto 0) := (others => '0'); -- Initialized to 0.
    signal output_Magn : std_logic_vector (NUME downto 0); -- Not initialized.
    signal testing : boolean := true; -- Initialized to true

begin

    clk <= (not clk) after CLK_PERIOD/2 when testing else
        '0'; -- after half Clock Period, negate the clock variable. 0101010

    Magn : Magnitude port map(
        realPart => input_Real,
        imgPart => input_Img,
        y => output_Magn,
        clk => clk,
        resetn => reset_s,
        en => enable_s
    );

    STIMULUS : process
        -- Result printing stuff
        variable line_out : line;
        file text_vector : text open write_mode is "result.csv";

        variable semicolon : character := ';';
        variable excellBinary : character := ''';

    begin

        -- Start of the safety period.
        -- Default condition
        input_Real <= std_logic_vector(to_signed(0, input_Real'length)); -- Initialized to 0
        input_Img <= std_logic_vector(to_signed(0, input_Img'length)); -- Initialized to 0
        reset_s <= '0'; -- reset initialized at 0.
        enable_s <= '0'; -- enable initialized at 0.

        wait until rising_edge(clk);
        wait until rising_edge(clk);
        -- Wait for 2 clock cycles.

        reset_s <= '1';
        enable_s <= '1';
        wait until rising_edge(clk);
        -- End of the safety period.

        -- Borderline case studies

        input_Real <= (others => '1'); -- All 1
        input_Img <= (others => '1'); -- All 1

        wait until rising_edge(clk);
       
        input_Real <= (others => '0'); -- All 0
        input_Img <= (others => '1'); -- All 1

        wait until rising_edge(clk);
       

        input_Real <= (others => '1'); -- All 1
        input_Img <= (others => '0'); -- All 0
        wait until rising_edge(clk);
       

        input_Real <= (others => '0'); -- All 0
        input_Img <= (others => '0'); -- All 0
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Real'length)); -- Negative extreme
        input_Img <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Img'length)); -- Negative extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Real'length)); -- Negative extreme
        input_Img <= (others => '0'); -- All 0
        wait until rising_edge(clk);
       

        input_Real <= (others => '0'); -- All 0
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Real'length)); -- Negative extreme
        input_Img <= (others => '1'); -- All 1
        wait until rising_edge(clk);
       

        input_Real <= (others => '1'); -- All 1
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Real'length)); -- Positive extreme
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Real'length)); -- Positive extreme
        input_Img <= (others => '0'); -- All 0
        wait until rising_edge(clk);
       

        input_Real <= (others => '0'); -- All 0
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Real'length)); -- Positive extreme
        input_Img <= (others => '1'); -- All 1
        wait until rising_edge(clk);
       

        input_Real <= (others => '1'); -- All 1
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Real'length)); -- Negative extreme
        input_Img <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Img'length)); -- Positive extreme
        wait until rising_edge(clk);
       

        input_Real <= std_logic_vector(to_signed(2 ** (NUME - 1) - 1, input_Real'length)); -- Positive extreme
        input_Img <= std_logic_vector(to_signed(-1 * 2 ** (NUME - 1) + 1, input_Img'length)); -- Negative extreme
        wait until rising_edge(clk);
       
        -- Some tests with "normal" values.

    
        -- Reset test
        wait for 200 ns;
        wait until rising_edge(clk);
        reset_s <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        reset_s <= '1';
        -- end of the reset test.

        wait for 300 ns;
        wait until rising_edge(clk);
        reset_s <= '0';
        wait for 0.1 ms;

        -- testing go false
        testing <= false;
        wait until rising_edge(clk);
    end process;

end architecture;