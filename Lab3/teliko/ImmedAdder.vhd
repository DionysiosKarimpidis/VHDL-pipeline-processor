----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:27:08 03/10/2014 
-- Design Name: 
-- Module Name:    ImmedAdder - Behavioral 
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

entity ImmedAdder is
    Port ( PC_Incr : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_branch : out  STD_LOGIC_VECTOR (31 downto 0));
end ImmedAdder;

architecture Behavioral of ImmedAdder is

signal foo: STD_LOGIC_VECTOR (31 downto 0);

begin
	foo<= PC_Immed+PC_Incr;
	PC_branch<= foo;
end Behavioral;

