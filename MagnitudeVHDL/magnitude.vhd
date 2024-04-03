library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity Magnitude is
    generic (
        N : positive := 10
    );
    port (
        realPart : in std_logic_vector(N - 1 downto 0);
        imgPart : in std_logic_vector(N - 1 downto 0);
        y : out std_logic_vector(N downto 0);
        clk : in std_logic;
        resetn : in std_logic;
        en : in std_logic
    );

end entity;

architecture dataflow of Magnitude is
    signal realRegOutput : std_logic_vector(N - 1 downto 0); -- Real register output.
    signal imgRegOutput : std_logic_vector(N - 1 downto 0);
    signal sumFinalOutput : std_logic_vector(N downto 0);

    signal maxPQ : std_logic_vector(N - 1 downto 0);
    signal minPQ : std_logic_vector(N - 1 downto 0);

    signal realPartAbs : std_logic_vector(N - 1 downto 0);
    signal imgPartAbs : std_logic_vector(N - 1 downto 0);

    signal sumFinal : std_logic_vector(N downto 0);

    component absolute_value is
        generic (
            NUM : positive := 10 
        );
        port (
            x : in std_logic_vector(NUM - 1 downto 0);
            y : out std_logic_vector(NUM - 1 downto 0)
        );
    end component;

    component max is
        generic (
            NUM : positive := 10
        );
        port (
            a : in std_logic_vector(NUM -1 downto 0);
            b : in std_logic_vector(NUM -1 downto 0);
            y : out std_logic_vector(NUM -1 downto 0)
        );
    end component;

    component min is
        generic (
            NUM : positive := 10
        );
        port (
            a : in std_logic_vector(NUM - 1 downto 0);
            b : in std_logic_vector(NUM - 1 downto 0);
            y : out std_logic_vector(NUM - 1 downto 0)
        );
    end component;

    component magnitudeAdder is
        generic (
            NUM : positive := 10
        );
        port (
            max : in std_logic_vector(NUM - 1 downto 0);
            min : in std_logic_vector(NUM - 1 downto 0);
            y : out std_logic_vector(NUM downto 0)
        );
    
    end component;

    component d_flip_flop is
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
    
    end component;

begin
    oregReal : d_flip_flop 
    generic map(NUM => N)
    port map(
        di => realPart,
        do => realRegOutput,
        clk => clk,
        resetn => resetn,
        en => en
    );

    oregImg : d_flip_flop 
    generic map(NUM => N)
    port map(
        di => imgPart,
        do => imgRegOutput,
        clk => clk,
        resetn => resetn,
        en => en
    );

    absReal : absolute_value 
    generic map(NUM => N)
    port map(
        x => realRegOutput,
        y => realPartAbs
    );

    absImg : absolute_value 
    generic map(NUM => N)
    port map(
        x => imgRegOutput,
        y => imgPartAbs
    );

    myMax : max 
    generic map(NUM => N)
    port map(
        a => realPartAbs,
        b => imgPartAbs,
        y => maxPQ
    );

    myMin : min 
    generic map(NUM => N)
    port map(
        a => realPartAbs,
        b => imgPartAbs,
        y => minPQ
    );

    myMagnitudeAdder : magnitudeAdder 
    generic map(NUM => N)
    port map(
        max => maxPQ,
        min => minPQ,
        y => sumFinal
    );

    oregOutput : d_flip_flop
    generic map(NUM => N + 1 ) 
    port map(
        di => sumFinal,
        do => sumFinalOutput,
        clk => clk,
        resetn => resetn,
        en => en
    );

    y <= sumFinalOutput;

end architecture;