--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:44:57 02/27/2014
-- Design Name:   
-- Module Name:   /home/lef/diafora_flokia/Erg/organosi_lab2_v2/test_alu.vhd
-- Project Name:  organosi_lab2_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_fk
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
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu_fk
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         zero : OUT  std_logic;
         ovf : OUT  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal zero : std_logic;
   signal ovf : std_logic;
   signal Cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu_fk PORT MAP (
          A => A,
          B => B,
          op => op,
          Output => Output,
          zero => zero,
          ovf => ovf,
          Cout => Cout
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
     A <= "10000000000000000000000000000000";
	  B <= "10000000000000000000000000000000";
	  op <= "1111";		--pros8esi pou vgazei zero, ovf kai Cout
	  wait for 100 ns;
	  
	  A <= "10000000000100000000001000000000";
	  B <= "00000000000000001000000000001000";
	  op <= "0111";
	  wait for 100 ns;
	  
	  A <= "01111111111110000000000100000000";
	  B <= "00000000000000001000000000001000";
	  op <= "1100";
	  wait for 100 ns;
	  
	  A <= "11111111111100000000001000000000";
	  op <= "1110";
	  wait for 100 ns;
	  
	  
		
		

      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
