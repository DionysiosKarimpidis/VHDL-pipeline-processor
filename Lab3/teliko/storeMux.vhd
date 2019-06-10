----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:18:42 03/24/2014 
-- Design Name: 
-- Module Name:    storeMux - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity storeMux is
    Port ( Rf_b : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_Din_sel : in  STD_LOGIC;
           sMuxOut : out  STD_LOGIC_VECTOR (31 downto 0));
end storeMux;

architecture Behavioral of storeMux is

begin

	with Mem_Din_sel select
		sMuxOut <= Rf_b when '0',
					  "000000000000000000000000"&Rf_b(7 downto 0) when others;



end Behavioral;

