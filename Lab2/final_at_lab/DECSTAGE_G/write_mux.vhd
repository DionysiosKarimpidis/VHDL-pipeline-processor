----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:03:54 03/11/2014 
-- Design Name: 
-- Module Name:    write_mux - Behavioral 
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

entity write_mux is
    Port ( ALU_muxIN : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_muxIN : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           writeMux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end write_mux;

architecture Behavioral of write_mux is

begin

with RF_WrData_sel select
	writeMux_out <= ALU_muxIN when '0',
						 MEM_muxIN when others;


end Behavioral;

