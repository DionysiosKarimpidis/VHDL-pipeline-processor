--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:44:01 02/27/2014
-- Design Name:   
-- Module Name:   /home/lef/diafora_flokia/Erg/organosi_lab2_v2/TEST_REG.vhd
-- Project Name:  organosi_lab2_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TEST_REG IS
END TEST_REG;
 
ARCHITECTURE behavior OF TEST_REG IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg
    PORT(
         DATA : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         CLK : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATA : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg PORT MAP (
          DATA => DATA,
          WE => WE,
          CLK => CLK,
          Dout => Dout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      DATA<="00000111110000011111000001111101";
		WE <= '1';
      wait for CLK_period*10;
		
		DATA<="11111111111100011111000001111101";
		WE <= '0';
      wait for CLK_period*10;

wait for CLK_period*10;
      wait;
   end process;

END;
