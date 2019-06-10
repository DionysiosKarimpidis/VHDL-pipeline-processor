----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:19:42 03/11/2014 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port ( pc_mux_in : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is

signal pc_tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
process
	begin

	wait until Clk'EVENT  and Clk='1';
		if (rst = '1') then
			pc_tmp <= "00000000000000000000000000000000";
		else if (PC_LdEn='1') then 
			pc_tmp <= pc_mux_in;
		else 
			pc_tmp <= pc_tmp;
		end if;
	end if;
end process;
	PC_out <= pc_tmp;

end Behavioral;

