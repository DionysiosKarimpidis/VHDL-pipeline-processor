----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:54:47 03/11/2014 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC_vector(1 downto 0);
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst: in std_logic;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

COMPONENT RF_top_omikronpsi420 is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
			  Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT extender is
    Port ( immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  ext_op : in STD_LOGIC_VECTOR (5 downto 0);
           immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT instr_mux is
    Port ( Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           RegDst : in  STD_LOGIC;
           instrMux_out : out  STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;

COMPONENT write_mux is
    Port ( ALU_muxIN : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_muxIN : in  STD_LOGIC_VECTOR (31 downto 0);
			  ImmedMux : in STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           writeMux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

signal write_sig, immed_sig : STD_LOGIC_VECTOR (31 downto 0);
signal regMux_signal : STD_LOGIC_VECTOR (4 downto 0);


begin

RF: RF_top_omikronpsi420 PORT MAP ( Ard1 => Instr(25 downto 21),
												Ard2 => regMux_signal,
												Awr => 	Instr(20 downto 16),
												Din => write_sig,
												WE => RF_WrEn,
												CLK => clk,
												RST => rst,
												Dout1 => RF_A,
												Dout2 => RF_B);
												
extndr: extender port map ( immed_in => Instr(15 downto 0),
									 ext_op => Instr(31 downto 26),
									 immed_out => immed_sig);

WrMux: write_mux port map( ALU_muxIN => ALU_out,
									MEM_muxIN => MEM_out,
									ImmedMux => immed_sig,
									RF_WrData_sel => RF_WrData_sel,
									writeMux_out => write_sig);

instrMuc: instr_mux port map ( Rd => Instr(20 downto 16),
										 Rt => Instr(15 downto 11),
										 RegDst => RF_B_sel,
										 instrMux_out => regMux_signal);

Immed <= immed_sig;

end Behavioral;

