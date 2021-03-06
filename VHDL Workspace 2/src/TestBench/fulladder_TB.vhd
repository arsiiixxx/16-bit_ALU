library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

	-- Add your library and packages declaration here ...

entity fulladder_tb is
end fulladder_tb;

architecture TB_ARCHITECTURE of fulladder_tb is
	-- Component declaration of the tested unit
	component fulladder
	port(
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		Cin : in STD_LOGIC;
		S : out STD_LOGIC;
		Cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC:='0';
	signal B : STD_LOGIC:='0';
	signal Cin : STD_LOGIC:='0';	   
	signal delayA : STD_LOGIC:='0';
	signal delayB : STD_LOGIC:='0';
	signal delayCin : STD_LOGIC:='0';
	signal testValue : std_logic_vector(2 downto 0):="000";
	-- Observed signals - signals mapped to the output ports of tested entity
	signal S : STD_LOGIC:='0';
	signal Cout : STD_LOGIC:='0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : fulladder
		port map (
			A => A,
			B => B,
			Cin => Cin,
			S => S,
			Cout => Cout
		);

	-- Add your stimulus here ...
	
	process
	begin
		for i in 0 to 7 loop -- Loops through all the possible input combinations
			testValue <= std_logic_vector(to_unsigned(i, 3)); 
			wait for 0ns;
			A <= testValue(0);
			B <= testValue(1);
			Cin <= testValue(2);
			wait for 40ns;
		end loop;	
		assert false
		report "End of testing"
		severity failure;
	end process;
	
	-- Delay of the inputs
	delayA <= A after 30ns;
	delayB <= B after 30ns;
	delayCin <= Cin after 30ns;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fulladder of fulladder_tb is
	for TB_ARCHITECTURE
		for UUT : fulladder
			use entity work.fulladder(structural);
		end for;
	end for;
end TESTBENCH_FOR_fulladder;

