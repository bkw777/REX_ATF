------------------------------------------------------------------------
-- define a positive edge triggered clock register vector
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity regis_vector is
	port (
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
		rst, clk, clk_en, clr, default 	: in std_logic;
		input										: in std_logic_vector;
		output									: out std_logic_vector
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
	);
-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end regis_vector;

architecture regis_rtl_vector of regis_vector is
-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
	reg_gen: for ix in input'RANGE generate
	begin
		process(rst, clk, clk_en, clr, default, input)
		begin
			if (rst='1') then
				output(ix) <= default;
			elsif (clr='1') then
				output(ix) <= default;
			elsif  (clk_en = '1') then
				if (clk'event and clk='1') then
					output(ix) <= input(ix);
				end if;
			end if;
		end process;
	end generate reg_gen;
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!
end regis_rtl_vector;
