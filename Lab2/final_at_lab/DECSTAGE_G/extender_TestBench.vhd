--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:39:26 03/11/2014
-- Design Name:   
-- Module Name:   C:/Users/dimitris/Desktop/lab2_org_G/DECSTAGE/extender_TestBench.vhd
-- Project Name:  DECSTAGE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: extender
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
 
ENTITY extender_TestBench IS
END extender_TestBench;
 
ARCHITECTURE behavior OF extender_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT extender
    PORT(
         immed_in : IN  std_logic_vector(15 downto 0);
         ext_op : IN  std_logic;
         immed_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal immed_in : std_logic_vector(15 downto 0) := (others => '0');
   signal ext_op : std_logic := '0';

 	--Outputs
   signal immed_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: extender PORT MAP (
          immed_in => immed_in,
          ext_op => ext_op,
          immed_out => immed_out
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      immed_in <= "1000000000000011";
		ext_op <= '1';
      wait for 100 ns;	
		
		ext_op <= '0';
      wait for 100 ns; 

      wait;
   end process;

END;
