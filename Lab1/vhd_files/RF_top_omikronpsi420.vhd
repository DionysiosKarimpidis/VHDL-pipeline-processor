----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:25:15 02/27/2014 
-- Design Name: 
-- Module Name:    RF_top_omikronpsi420 - Behavioral 
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

entity RF_top_omikronpsi420 is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF_top_omikronpsi420;

architecture Behavioral of RF_top_omikronpsi420 is

component decoder_5_32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           dec_output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component reg is
    Port ( DATA : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component select_mux is
    Port ( R0 : in  STD_LOGIC_VECTOR (31 downto 0);
           R1 : in  STD_LOGIC_VECTOR (31 downto 0);
           R2 : in  STD_LOGIC_VECTOR (31 downto 0);
           R3 : in  STD_LOGIC_VECTOR (31 downto 0);
           R4 : in  STD_LOGIC_VECTOR (31 downto 0);
           R5 : in  STD_LOGIC_VECTOR (31 downto 0);
           R6 : in  STD_LOGIC_VECTOR (31 downto 0);
           R7 : in  STD_LOGIC_VECTOR (31 downto 0);
           R8 : in  STD_LOGIC_VECTOR (31 downto 0);
           R9 : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component compare is
    Port ( comp_addRA : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_addWA : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_out : out  STD_LOGIC);
end component;

component final_mux is
    Port ( sel : in  STD_LOGIC;
           data_reg : in  STD_LOGIC_VECTOR (31 downto 0);
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           output_addr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal dec_out, sel_mux_out1, sel_mux_out2, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6, reg_out7, reg_out8, reg_out9, reg_out10, reg_out11, reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, reg_out17, reg_out18, reg_out19, reg_out20, reg_out21, reg_out22, reg_out23, reg_out24, reg_out25, reg_out26, reg_out27, reg_out28, reg_out29, reg_out30, reg_out31, reg_out32  : STD_LOGIC_VECTOR (31 downto 0);
signal comp_mux1,comp_mux2,comp_out1, comp_out2, sel_final, we_reg_sig1, we_reg_sig2, we_reg_sig3, we_reg_sig4, we_reg_sig5, we_reg_sig6, we_reg_sig7, we_reg_sig8, we_reg_sig9, we_reg_sig10, we_reg_sig11, we_reg_sig12, we_reg_sig13, we_reg_sig14, we_reg_sig15, we_reg_sig16, we_reg_sig17, we_reg_sig18, we_reg_sig19, we_reg_sig20, we_reg_sig21, we_reg_sig22, we_reg_sig23, we_reg_sig24, we_reg_sig25, we_reg_sig26, we_reg_sig27, we_reg_sig28, we_reg_sig29, we_reg_sig30, we_reg_sig31, we_reg_sig32 : STD_LOGIC;
signal final_mux_out : STD_LOGIC_VECTOR(4 downto 0);


begin

we_reg_sig1 <= WE and dec_out(0);
we_reg_sig2 <= WE and dec_out(1);
we_reg_sig3 <= WE and dec_out(2);
we_reg_sig4 <= WE and dec_out(3);
we_reg_sig5 <= WE and dec_out(4);
we_reg_sig6 <= WE and dec_out(5);
we_reg_sig7 <= WE and dec_out(6);
we_reg_sig8 <= WE and dec_out(7);
we_reg_sig9 <= WE and dec_out(8);
we_reg_sig10 <= WE and dec_out(9);
we_reg_sig11 <= WE and dec_out(10);
we_reg_sig12 <= WE and dec_out(11);
we_reg_sig13 <= WE and dec_out(12);
we_reg_sig14 <= WE and dec_out(13);
we_reg_sig15 <= WE and dec_out(14);
we_reg_sig16 <= WE and dec_out(15);
we_reg_sig17 <= WE and dec_out(16);
we_reg_sig18 <= WE and dec_out(17);
we_reg_sig19 <= WE and dec_out(18);
we_reg_sig20 <= WE and dec_out(19);
we_reg_sig21 <= WE and dec_out(20);
we_reg_sig22 <= WE and dec_out(21);
we_reg_sig23 <= WE and dec_out(22);
we_reg_sig24 <= WE and dec_out(23);
we_reg_sig25 <= WE and dec_out(24);
we_reg_sig26 <= WE and dec_out(25);
we_reg_sig27 <= WE and dec_out(26);
we_reg_sig28 <= WE and dec_out(27);
we_reg_sig29 <= WE and dec_out(28);
we_reg_sig30 <= WE and dec_out(29);
we_reg_sig31 <= WE and dec_out(30);
we_reg_sig32 <= WE and dec_out(31);


comp_mux1<= WE AND comp_out1;
comp_mux2<= WE AND comp_out2;


flag1:	decoder_5_32 port map(Awr => Awr,
										 dec_output =>	dec_out);
						
reg1:	reg port map ( DATA => "00000000000000000000000000000000",
							WE => we_reg_sig1,
							CLK => CLK,
							Dout => reg_out1);

reg2:	reg port map ( DATA => Din,
							WE => we_reg_sig2,
							CLK => CLK,
							Dout => reg_out2);
							
reg3:	reg port map ( DATA => Din,
							WE => we_reg_sig3,
							CLK => CLK,
							Dout => reg_out3);

reg4:	reg port map ( DATA => Din,
							WE => we_reg_sig4,
							CLK => CLK,
							Dout => reg_out4);
							
reg5:	reg port map ( DATA => Din,
							WE => we_reg_sig5,
							CLK => CLK,
							Dout => reg_out5);

reg6:	reg port map ( DATA => Din,
							WE => we_reg_sig6,
							CLK => CLK,
							Dout => reg_out6);

reg7:	reg port map ( DATA => Din,
							WE => we_reg_sig7,
							CLK => CLK,
							Dout => reg_out7);

reg8:	reg port map ( DATA => Din,
							WE => we_reg_sig8,
							CLK => CLK,
							Dout => reg_out8);

reg9:	reg port map ( DATA => Din,
							WE => we_reg_sig9,
							CLK => CLK,
							Dout => reg_out9);

reg10:	reg port map ( DATA => Din,
							WE => we_reg_sig10,
							CLK => CLK,
							Dout => reg_out10);
							
reg11:	reg port map ( DATA => Din,
							WE => we_reg_sig11,
							CLK => CLK,
							Dout => reg_out11);

reg12:	reg port map ( DATA => Din,
							WE => we_reg_sig12,
							CLK => CLK,
							Dout => reg_out12);

reg13:	reg port map ( DATA => Din,
							WE => we_reg_sig13,
							CLK => CLK,
							Dout => reg_out13);

reg14:	reg port map ( DATA => Din,
							WE => we_reg_sig14,
							CLK => CLK,
							Dout => reg_out14);

reg15:	reg port map ( DATA => Din,
							WE => we_reg_sig15,
							CLK => CLK,
							Dout => reg_out15);

reg16:	reg port map ( DATA => Din,
							WE => we_reg_sig16,
							CLK => CLK,
							Dout => reg_out16);

reg17:	reg port map ( DATA => Din,
							WE => we_reg_sig17,
							CLK => CLK,
							Dout => reg_out17);							
							
reg18:	reg port map ( DATA => Din,
							WE => we_reg_sig18,
							CLK => CLK,
							Dout => reg_out18);							
							
reg19:	reg port map ( DATA => Din,
							WE => we_reg_sig19,
							CLK => CLK,
							Dout => reg_out19);							
							
reg20:	reg port map ( DATA => Din,
							WE => we_reg_sig20,
							CLK => CLK,
							Dout => reg_out20);							
							
reg21:	reg port map ( DATA => Din,
							WE => we_reg_sig21,
							CLK => CLK,
							Dout => reg_out21);							
							
reg22:	reg port map ( DATA => Din,
							WE => we_reg_sig22,
							CLK => CLK,
							Dout => reg_out22);							
							
reg23:	reg port map ( DATA => Din,
							WE => we_reg_sig23,
							CLK => CLK,
							Dout => reg_out23);							
							
reg24:	reg port map ( DATA => Din,
							WE => we_reg_sig24,
							CLK => CLK,
							Dout => reg_out24);							

reg25:	reg port map ( DATA => Din,
							WE => we_reg_sig25,
							CLK => CLK,
							Dout => reg_out25);

reg26:	reg port map ( DATA => Din,
							WE => we_reg_sig26,
							CLK => CLK,
							Dout => reg_out26);

reg27:	reg port map ( DATA => Din,
							WE => we_reg_sig27,
							CLK => CLK,
							Dout => reg_out27);

sel_mux1:	select_mux port map( R0 =>	 "00000000000000000000000000000000",
											R1 =>	 reg_out2,
											R2 =>	 reg_out3,
											R3 =>	 reg_out4,
											R4 =>	 reg_out5,
											R5 =>	 reg_out6,
											R6 =>	 reg_out7,
											R7 =>	 reg_out8,
											R8 =>	 reg_out9,
											R9 =>	 reg_out10,
											R10 =>	 reg_out11,
											R11 =>	 reg_out12,
											R12 =>	 reg_out13,
											R13 =>	 reg_out14,
											R14 =>	 reg_out15,
											R15 =>	 reg_out16,
											R16 =>	 reg_out17,
											R17 =>	 reg_out18,
											R18 =>	 reg_out19,
											R19 =>	 reg_out20,
											R20 =>	 reg_out21,
											R21 =>	 reg_out22,
											R22 =>	 reg_out23,
											R23 =>	 reg_out24,
											R24 =>	 reg_out25,
											R25 =>	 reg_out26,
											R26 =>	 reg_out27,
											R27 =>	 reg_out28,
											R28 =>	 reg_out29,
											R29 =>	 reg_out30,
											R30 =>	 reg_out31,
											R31 =>	 reg_out32,
											SEL => 	 Ard1,
											Dout =>   sel_mux_out1);
											
sel_mux2:	select_mux port map( R0 =>	 "00000000000000000000000000000000",
											R1 =>	 reg_out2,
											R2 =>	 reg_out3,
											R3 =>	 reg_out4,
											R4 =>	 reg_out5,
											R5 =>	 reg_out6,
											R6 =>	 reg_out7,
											R7 =>	 reg_out8,
											R8 =>	 reg_out9,
											R9 =>	 reg_out10,
											R10 =>	 reg_out11,
											R11 =>	 reg_out12,
											R12 =>	 reg_out13,
											R13 =>	 reg_out14,
											R14 =>	 reg_out15,
											R15 =>	 reg_out16,
											R16 =>	 reg_out17,
											R17 =>	 reg_out18,
											R18 =>	 reg_out19,
											R19 =>	 reg_out20,
											R20 =>	 reg_out21,
											R21 =>	 reg_out22,
											R22 =>	 reg_out23,
											R23 =>	 reg_out24,
											R24 =>	 reg_out25,
											R25 =>	 reg_out26,
											R26 =>	 reg_out27,
											R27 =>	 reg_out28,
											R28 =>	 reg_out29,
											R29 =>	 reg_out30,
											R30 =>	 reg_out31,
											R31 =>	 reg_out32,
											SEL => 	 Ard2,
											Dout =>   sel_mux_out2);

comp1: compare port map( 	comp_addRA => Ard1,
									comp_addWA => Awr,
									comp_out => comp_out1);

comp2: compare port map( 	comp_addRA => Ard2,
									comp_addWA => Awr,
									comp_out => comp_out2);
									
f_mux1: final_mux port map( 	sel=>	comp_mux1,
										data_reg=> sel_mux_out1, 
										data_in=> Din,	
										output_addr=> Dout1);
										
f_mux2: final_mux port map( 	sel=>	comp_mux2,
										data_reg=> sel_mux_out2, 
										data_in=> Din,	
										output_addr=> Dout2);
										
end Behavioral;

