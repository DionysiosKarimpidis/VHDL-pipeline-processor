----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:29:59 03/11/2014 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component IF_MEM is
port (
	clk: in std_logic;
	addr: in std_logic_vector(9 downto 0);
	dout: out std_logic_vector(31 downto 0));
end component;

component ImmedAdder is
    Port ( PC_Incr : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_branch : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementor is
    Port ( incr_In : in  STD_LOGIC_VECTOR (31 downto 0);
           incr_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC_Sel_Mux is
    Port ( PC_Inc : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Imm : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC is
    Port ( pc_mux_in : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal branch_sig, incr_sig, pc_in, pc_out : std_logic_vector(31 downto 0);

begin

pc_mux: PC_Sel_Mux port map(	PC_Inc => incr_sig,
										PC_Imm => branch_sig,
										PC_Sel => PC_sel,
										PC => pc_in);
										
pc_port: PC port map(	pc_mux_in => pc_in,
								PC_LdEn => PC_LdEn,
								Clk => clk,
								rst => rst,
								PC_out => pc_out);


incr: Incrementor port map( incr_In => pc_out,
									 incr_Out => incr_sig);

immed: ImmedAdder port map( PC_Incr => incr_sig,
									 PC_Immed => PC_Immed,
									 PC_branch => branch_sig);

IFMem: IF_MEM port map( clk => clk,
								addr => pc_out(11 downto 2),
								dout => Instr);

end Behavioral;

