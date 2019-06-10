----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:01:34 03/10/2014 
-- Design Name: 
-- Module Name:    PC_Sel_Mux - Behavioral 
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

entity PC_Sel_Mux is
    Port ( PC_Inc : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Imm : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_Sel_Mux;

architecture Behavioral of PC_Sel_Mux is

begin

with PC_Sel select
	PC <= PC_Inc when '0',
			PC_Imm when others;

end Behavioral;

