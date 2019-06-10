--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:56:28 03/26/2014
-- Design Name:   
-- Module Name:   /home/theo/Documents/testaki_control/controoool_test.vhd
-- Project Name:  testaki_control
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY controoool_test IS
END controoool_test;
 
ARCHITECTURE behavior OF controoool_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_Din_sel : OUT  std_logic;
         Mem_Dout_sel : OUT  std_logic;
         Mem_WrEn : OUT  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         zero : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal zero : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_Din_sel : std_logic;
   signal Mem_Dout_sel : std_logic;
   signal Mem_WrEn : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_B_sel => RF_B_sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_Din_sel => Mem_Din_sel,
          Mem_Dout_sel => Mem_Dout_sel,
          Mem_WrEn => Mem_WrEn,
          clk => clk,
          rst => rst,
          Instr => Instr,
          zero => zero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
     -- r-type
      rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		Instr <= "10000000000000000000000000000000";
		wait for 100 ns;
	-- li
		rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		Instr <= "11000000000000000000000000000000";
		wait for 100 ns;
	--addi
	rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		Instr <= "11100000000000000000000000000000";
		wait for 100 ns;
				

      wait;
   end process;

END;
