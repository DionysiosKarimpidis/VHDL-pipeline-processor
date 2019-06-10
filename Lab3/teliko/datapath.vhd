----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:58:53 03/24/2014 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

entity datapath is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC_vector (1 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_Din_sel : in  STD_LOGIC;
           Mem_Dout_sel : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC);
end datapath;

architecture Behavioral of datapath is

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC_vector (1 downto 0);
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst: in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALUSTAGE is
 Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
        RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
        Immed : in  STD_LOGIC_VECTOR (31 downto 0);
        ALU_Bin_sel : in  STD_LOGIC;
        ALU_func : in STD_LOGIC_VECTOR (3 downto 0);
		  ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
		  zero : out STD_LOGIC);
end component;

component MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEnable : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_in : in  STD_LOGIC_VECTOR (31 downto 0);
			  MemDinsel : in  STD_LOGIC;
			  MemDoutsel : in  STD_LOGIC;
			  loadMuxOut : out  STD_LOGIC_VECTOR (31 downto 0));
--           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component rf_out_reg is
    Port ( rf_out : in  STD_LOGIC_VECTOR (31 downto 0);
           rf_reg_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end component;


signal Instr_sig, Immed_sig, rfa_sig, rfb_sig, aluOut_sig, loadMux_sig,regRFA,regRFB: STD_LOGIC_VECTOR (31 downto 0);
begin

ifPort: IFSTAGE port map ( PC_Immed => Immed_sig,
									PC_sel => PC_sel,
									PC_LdEn => PC_LdEn,
									clk => clk,
									rst => rst,
									Instr => Instr_sig);
									
decPort: DECSTAGE port map ( Instr => Instr_sig,
									  RF_WrEn => RF_WrEn,
									  ALU_out => aluOut_sig,
									  MEM_out => loadMux_sig,
									  RF_WrData_sel => RF_WrData_sel,
									  RF_B_sel => RF_B_sel,
									  clk => clk,
									  rst => rst,
									  Immed => Immed_sig,
									  RF_A => regRFA,
									  RF_B => regRFB);

aluPort: ALUSTAGE port map ( RF_A => rfa_sig,
									  RF_B => rfb_sig,
									  Immed => Immed_sig,
									  ALU_Bin_sel => ALU_Bin_sel,
									  ALU_func => ALU_func,
									  ALU_out => aluOut_sig,
									  zero => zero);


memPort: MEMSTAGE port map ( clk => clk,
									  Mem_WrEnable => Mem_WrEn,
									  ALU_MEM_addr => aluOut_sig,
									  RF_B_in => rfb_sig,
									  MemDinsel => Mem_Din_sel,
									  MemDoutsel => Mem_Dout_sel,
									  loadMuxOut => loadMux_sig);
									 
RF_A_reg: rf_out_reg port map( rf_out => regRFA ,
										rf_reg_out =>rfa_sig ,
										clk =>clk);
										
RF_B_reg: rf_out_reg port map( rf_out => regRFB ,
										rf_reg_out =>rfb_sig ,
										clk =>clk);
									  
Instr <= Instr_sig;						  

end Behavioral;

