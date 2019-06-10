----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:42:32 03/24/2014 
-- Design Name: 
-- Module Name:    loadMux - Behavioral 
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

entity loadMux is
    Port ( loadMux_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_Dout_sel : in  STD_LOGIC;
           lmux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end loadMux;

architecture Behavioral of loadMux is

begin

	with Mem_Dout_sel select
		lmux_Out <= loadMux_in when '0',
						"000000000000000000000000"&loadMux_in(7 downto 0) when others;
						


end Behavioral;

