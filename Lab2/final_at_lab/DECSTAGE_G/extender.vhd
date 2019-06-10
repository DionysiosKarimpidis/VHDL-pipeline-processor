----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:56:30 03/11/2014 
-- Design Name: 
-- Module Name:    extender - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity extender is
    Port ( immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  ext_op : in STD_LOGIC_VECTOR (5 downto 0);
           immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end extender;

architecture Behavioral of extender is
signal tmp, tmp2 : STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";

begin

	
	tmp(15 downto 0) <= immed_in;
	tmp(31 downto 16) <= (31 downto 16 => immed_in(15));
	with ext_op select 
		tmp2 <= 	"0000000000000000"&immed_in 	when "111100",
					"0000000000000000"&immed_in 	when "111110",
					tmp 									when "110000",
					tmp 									when "111000",
					tmp 									when "111111",
					tmp 									when "000000",
					tmp 									when "000001",
					tmp 									when "000011",
					tmp 									when "000111",
					tmp 									when "001111",
					tmp 									when "011111",
					tmp when others;
	
	with ext_op select
		immed_out <= tmp2(29 downto 0) & "00" when "111111",	--periptwseis twn brands
						 tmp2(29 downto 0) & "00" when "000000",	--shift left kata 2=PC_Immed*4
						 tmp2(29 downto 0) & "00" when "000001",
						 tmp2 when others;
end Behavioral;

