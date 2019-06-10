--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:51:23 02/27/2014
-- Design Name:   
-- Module Name:   /home/lef/diafora_flokia/Erg/organosi_lab2_v2/RF_testBench.vhd
-- Project Name:  organosi_lab2_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF_top_omikronpsi420
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
 
ENTITY RF_testBench IS
END RF_testBench;
 
ARCHITECTURE behavior OF RF_testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF_top_omikronpsi420
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         CLK : IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF_top_omikronpsi420 PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Din => Din,
          WE => WE,
          CLK => CLK,
          Dout1 => Dout1,
          Dout2 => Dout2
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
		--write 1 to R1
      Din <= "00000000000000000000000000000001";
		WE <='1';
		Awr <= "00001";
      wait for CLK_period*10;
		
		--write 2 to R2
		Din <= "00000000000000000000000000000010";
		WE <='1';
		Awr <= "00010";
		wait for CLK_period*10;
		
		--read R1,R2
		WE <='0';
      Ard1 <= "00001";
		Ard2 <= "00010";
		wait for CLK_period*10;
		
		--write something to R4
		Din <= "00000000000000000000000000000000";
		WE <='1';
		Awr <= "00100";
		wait for CLK_period*10;
		
		--read and write on R4
		Din <= "00000000000000000000011111111111";
		WE <='1';
		Awr <= "00100";
		Ard1 <= "00100";
      wait for CLK_period*10;
		
		--write something on R0
		Din <= "11111111111111111111111111111111";
		WE <='1';
		Awr <= "00000";
		wait for CLK_period*100;
		
		--read R0
		WE <='0';
		Ard1 <= "00000";
		wait for CLK_period*10;

		
		
      wait;
   end process;

END;
