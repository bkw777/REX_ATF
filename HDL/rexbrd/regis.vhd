------------------------------------------------------------------------
-- define a positive edge triggered clock register
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity regis is
	port (
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
		rst, clk, clk_en, clr, default 	: in std_logic;
		input						: in std_logic;
		output					: out std_logic
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
	);
-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end regis;

architecture regis_rtl of regis is
-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
process(rst, clk, clk_en, clr, default, input)
	begin
		if (rst='1') then
			output <= default;
		elsif (clr='1') then
			output <= default;
		elsif  (clk_en = '1') then
   			if (clk'event and clk='1') then
			  	output <= input;
		  	end if;
		end if;
	end process;
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!
end regis_rtl;
