----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:32 03/26/2014 
-- Design Name: 
-- Module Name:    processor - Behavioral 
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

entity processor is
	port (  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end processor;

architecture Behavioral of processor is

component datapath is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC_vector(1 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_Din_sel : in  STD_LOGIC;
           Mem_Dout_sel : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC);
end component;

component Control is
	Port(	PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           Mem_Din_sel : out  STD_LOGIC;
           Mem_Dout_sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           zero : in  STD_LOGIC);
end component;

signal pc_sel_sig, pc_ld_sig, rf_b_sig, rf_wrEn_sig, alu_Bin_sig, mem_Din_sig, mem_Dout_sig, Mem_wrEn_sig, zero_sig : std_logic;
signal rf_wrData_sig : std_logic_vector(1 downto 0);
signal alu_func_sig : std_logic_vector(3 downto 0);
signal instr_sig : std_logic_vector(31 downto 0);

begin


controlPort: Control port map ( PC_sel => pc_sel_sig,
										  PC_LdEn => pc_ld_sig,
										  RF_B_sel => rf_b_sig,
										  RF_WrEn => rf_wrEn_sig,
										  RF_WrData_sel => rf_wrData_sig,
										  ALU_Bin_sel => alu_Bin_sig,
										  ALU_func => alu_func_sig,
										  Mem_Din_sel => mem_Din_sig,
										  Mem_Dout_sel => mem_Dout_sig,
										  Mem_WrEn => Mem_wrEn_sig,
										  clk => clk,
										  rst => rst,
										  Instr => instr_sig,
										  zero => zero_sig);

dataPort: datapath port map (PC_sel => pc_sel_sig,
									  PC_LdEn => pc_ld_sig,
									  clk => clk,
									  rst => rst,
									  RF_B_sel => rf_b_sig,
									  RF_WrEn => rf_wrEn_sig,
									  RF_WrData_sel => rf_wrData_sig,
									  ALU_Bin_sel => alu_Bin_sig,
									  ALU_func => alu_func_sig,
									  Mem_Din_sel => mem_Din_sig,
									  Mem_Dout_sel => mem_Dout_sig,
									  Mem_WrEn => Mem_wrEn_sig,
									  Instr => instr_sig,
									  zero => zero_sig);

end Behavioral;

