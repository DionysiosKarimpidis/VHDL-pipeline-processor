----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:43:40 05/13/2014 
-- Design Name: 
-- Module Name:    rf_out_reg - Behavioral 
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

entity rf_out_reg is
    Port ( rf_out : in  STD_LOGIC_VECTOR (31 downto 0);
           rf_reg_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end rf_out_reg;

architecture Behavioral of rf_out_reg is

signal tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process
		begin
			wait until clk'event and clk='1';
				tmp <= rf_out;
	end process;
	rf_reg_out <= tmp;



end Behavioral;

