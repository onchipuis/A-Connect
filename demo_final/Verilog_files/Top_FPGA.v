`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 09:56:55 PM
// Design Name: 
// Module Name: Top_FPGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_FPGA(
 output reg [6:0] segment,
 output [7:0] AN,
 input SCK,
 input CS,
 input MOSI,
 input clk,
 input rst,
 output MISO
    );
 
 
 //******** Internal Signal *****   
  wire [3:0] regr_0;
  
  wire [7:0] regwr_0;
  wire [7:0] regwr_1;
  wire [7:0] regwr_2;
  wire [7:0] regwr_3;
  wire [7:0] regwr_4;
  wire [7:0] regwr_5;
  wire [7:0] regwr_6;
  wire [7:0] regwr_7;
  wire [7:0] regwr_8;
  wire [7:0] regwr_9;
  wire [7:0] regwr_10;
  wire [7:0] regwr_11;
  wire [7:0] regwr_12;
  wire [7:0] regwr_13;
  wire [7:0] regwr_14;
  wire [7:0] regwr_15;
  wire [7:0] regwr_16;
  wire [7:0] regwr_17;
  wire [7:0] regwr_18;
  wire [7:0] regwr_19;
  wire [7:0] regwr_20;
  wire [7:0] regwr_21;
  wire [7:0] regwr_22;
  wire [7:0] regwr_23;
  wire [7:0] regwr_24;
  wire [7:0] regwr_25;
  wire [7:0] regwr_26;
  wire [7:0] regwr_27;
  wire [7:0] regwr_28;
  wire [7:0] regwr_29;
  wire [7:0] regwr_30;
  wire [7:0] regwr_31;
  wire [7:0] regwr_32;
  wire [7:0] regwr_33;
  wire [7:0] regwr_34;
  wire [7:0] regwr_35;
  wire [7:0] regwr_36;
  wire [7:0] regwr_37;
  wire [7:0] regwr_38;
  wire [7:0] regwr_39;
  wire [7:0] regwr_40;
  wire [7:0] regwr_41;
  wire [7:0] regwr_42;
  wire [7:0] regwr_43;
  wire [7:0] regwr_44;
  wire [7:0] regwr_45;
  wire [7:0] regwr_46;
  wire [7:0] regwr_47;
  wire [7:0] regwr_48;
  wire [7:0] regwr_49;
  wire [7:0] regwr_50;
  wire [7:0] regwr_51;
  wire [7:0] regwr_52;
  wire [7:0] regwr_53;
  wire [7:0] regwr_54;
  wire [7:0] regwr_55;
  wire [7:0] regwr_56;
  wire [7:0] regwr_57;
  wire [7:0] regwr_58;
  wire [7:0] regwr_59;
  wire [7:0] regwr_60;
  wire [7:0] regwr_61;
  wire [7:0] regwr_62;
  wire [7:0] regwr_63;
  wire [7:0] regwr_64;
  wire [7:0] regwr_65;
  wire [7:0] regwr_66;
  wire [7:0] regwr_67;
  wire [7:0] regwr_68;
  wire [7:0] regwr_69;
  wire [7:0] regwr_70;
  wire [7:0] regwr_71;
  wire [7:0] regwr_72;
  wire [7:0] regwr_73;
  wire [7:0] regwr_74;
  wire [7:0] regwr_75;
  wire [7:0] regwr_76;
  wire [7:0] regwr_77;
  wire [7:0] regwr_78;
  wire [7:0] regwr_79;
  wire [7:0] regwr_80;
  wire [7:0] regwr_81;
  wire [7:0] regwr_82;
  wire [7:0] regwr_83;
  wire [7:0] regwr_84;
  wire [7:0] regwr_85;
  wire [7:0] regwr_86;
  wire [7:0] regwr_87;
  wire [7:0] regwr_88;
  wire [7:0] regwr_89;
  wire [7:0] regwr_90;
  wire [7:0] regwr_91;
  wire [7:0] regwr_92;
  wire [7:0] regwr_93;
  wire [7:0] regwr_94;
  wire [7:0] regwr_95;
  wire [7:0] regwr_96;
  wire [7:0] regwr_97;
  wire [7:0] regwr_98;
  wire [7:0] regwr_99;
  wire [7:0] regwr_100;
  wire [7:0] regwr_101;
  wire [7:0] regwr_102;
  wire [7:0] regwr_103;
  wire [7:0] regwr_104;
  wire [7:0] regwr_105;
  wire [7:0] regwr_106;
  wire [7:0] regwr_107;
  wire [7:0] regwr_108;
  wire [7:0] regwr_109;
  wire [7:0] regwr_110;
  wire [7:0] regwr_111;
  wire [7:0] regwr_112;
  wire [7:0] regwr_113;
  wire [7:0] regwr_114;
  wire [7:0] regwr_115;
  wire [7:0] regwr_116;
  wire [7:0] regwr_117;
  wire [7:0] regwr_118;
  wire [7:0] regwr_119;
  wire [7:0] regwr_120;  
  //****************************** 
  
  //******* TOP_SPI ********
  Top_SPI comunnication (  
    .SCK(SCK),
 	.CS(CS),
 	.MOSI(MOSI),
	.MISO(MISO),
	.clk(clk),
	.rst(rst),
    .regr_0(regr_0),
    .regwr_0(regwr_0),
 	.regwr_1(regwr_1),
  	.regwr_2(regwr_2),
  	.regwr_3(regwr_3),
  	.regwr_4(regwr_4),
 	.regwr_5(regwr_5),
 	.regwr_6(regwr_6),
 	.regwr_7(regwr_7),
 	.regwr_8(regwr_8),
  	.regwr_9(regwr_9),
  	.regwr_10(regwr_10),
  	.regwr_11(regwr_11),
 	.regwr_12(regwr_12),
 	.regwr_13(regwr_13),
 	.regwr_14(regwr_14),
 	.regwr_15(regwr_15),
  	.regwr_16(regwr_16),
  	.regwr_17(regwr_17),
  	.regwr_18(regwr_18),
 	.regwr_19(regwr_19),
 	.regwr_20(regwr_20),
 	.regwr_21(regwr_21),
 	.regwr_22(regwr_22),
  	.regwr_23(regwr_23),
  	.regwr_24(regwr_24),
  	.regwr_25(regwr_25),
 	.regwr_26(regwr_26),
 	.regwr_27(regwr_27),
 	.regwr_28(regwr_28),
 	.regwr_29(regwr_29),
  	.regwr_30(regwr_30),
  	.regwr_31(regwr_31),
  	.regwr_32(regwr_32),
 	.regwr_33(regwr_33),
 	.regwr_34(regwr_34),
 	.regwr_35(regwr_35),
 	.regwr_36(regwr_36),
  	.regwr_37(regwr_37),
  	.regwr_38(regwr_38),
  	.regwr_39(regwr_39),
 	.regwr_40(regwr_40),
 	.regwr_41(regwr_41),
 	.regwr_42(regwr_42),
 	.regwr_43(regwr_43),
  	.regwr_44(regwr_44),
  	.regwr_45(regwr_45),
  	.regwr_46(regwr_46),
 	.regwr_47(regwr_47),
 	.regwr_48(regwr_48),
 	.regwr_49(regwr_49),
 	.regwr_50(regwr_50),
  	.regwr_51(regwr_51),
  	.regwr_52(regwr_52),
  	.regwr_53(regwr_53),
 	.regwr_54(regwr_54),
 	.regwr_55(regwr_55),
 	.regwr_56(regwr_56),
 	.regwr_57(regwr_57),
  	.regwr_58(regwr_58),
  	.regwr_59(regwr_59),
  	.regwr_60(regwr_60),
 	.regwr_61(regwr_61),
 	.regwr_62(regwr_62),
 	.regwr_63(regwr_63),
 	.regwr_64(regwr_64),
  	.regwr_65(regwr_65),
  	.regwr_66(regwr_66),
  	.regwr_67(regwr_67),
 	.regwr_68(regwr_68),
 	.regwr_69(regwr_69),
 	.regwr_70(regwr_70),
 	.regwr_71(regwr_71),
  	.regwr_72(regwr_72),
  	.regwr_73(regwr_73),
  	.regwr_74(regwr_74),
 	.regwr_75(regwr_75),
 	.regwr_76(regwr_76),
 	.regwr_77(regwr_77),
 	.regwr_78(regwr_78),
  	.regwr_79(regwr_79),
  	.regwr_80(regwr_80),
  	.regwr_81(regwr_81),
 	.regwr_82(regwr_82),
 	.regwr_83(regwr_83),
 	.regwr_84(regwr_84),
 	.regwr_85(regwr_85),
  	.regwr_86(regwr_86),
  	.regwr_87(regwr_87),
  	.regwr_88(regwr_88),
 	.regwr_89(regwr_89),
 	.regwr_90(regwr_90),
 	.regwr_91(regwr_91),
 	.regwr_92(regwr_92),
  	.regwr_93(regwr_93),
  	.regwr_94(regwr_94),
  	.regwr_95(regwr_95),
 	.regwr_96(regwr_96),
 	.regwr_97(regwr_97),
 	.regwr_98(regwr_98),
 	.regwr_99(regwr_99),
  	.regwr_100(regwr_100),
  	.regwr_101(regwr_101),
  	.regwr_102(regwr_102),
 	.regwr_103(regwr_103),
 	.regwr_104(regwr_104),
 	.regwr_105(regwr_105),
 	.regwr_106(regwr_106),
  	.regwr_107(regwr_107),
  	.regwr_108(regwr_108),
  	.regwr_109(regwr_109),
 	.regwr_110(regwr_110),
 	.regwr_111(regwr_111),
 	.regwr_112(regwr_112),
  	.regwr_113(regwr_113),
  	.regwr_114(regwr_114),
 	.regwr_115(regwr_115),
 	.regwr_116(regwr_116),
 	.regwr_117(regwr_117),
 	.regwr_118(regwr_118),
  	.regwr_119(regwr_119),
  	.regwr_120(regwr_120) 	
  	
  	);
  //************************
  
  //***** Top Network *****
   Top Network (  
    .regr_0(regr_0),
    .regwr_0(regwr_0),
 	.regwr_1(regwr_1),
  	.regwr_2(regwr_2),
  	.regwr_3(regwr_3),
  	.regwr_4(regwr_4),
 	.regwr_5(regwr_5),
 	.regwr_6(regwr_6),
 	.regwr_7(regwr_7),
 	.regwr_8(regwr_8),
  	.regwr_9(regwr_9),
  	.regwr_10(regwr_10),
  	.regwr_11(regwr_11),
 	.regwr_12(regwr_12),
 	.regwr_13(regwr_13),
 	.regwr_14(regwr_14),
 	.regwr_15(regwr_15),
  	.regwr_16(regwr_16),
  	.regwr_17(regwr_17),
  	.regwr_18(regwr_18),
 	.regwr_19(regwr_19),
 	.regwr_20(regwr_20),
 	.regwr_21(regwr_21),
 	.regwr_22(regwr_22),
  	.regwr_23(regwr_23),
  	.regwr_24(regwr_24),
  	.regwr_25(regwr_25),
 	.regwr_26(regwr_26),
 	.regwr_27(regwr_27),
 	.regwr_28(regwr_28),
 	.regwr_29(regwr_29),
  	.regwr_30(regwr_30),
  	.regwr_31(regwr_31),
  	.regwr_32(regwr_32),
 	.regwr_33(regwr_33),
 	.regwr_34(regwr_34),
 	.regwr_35(regwr_35),
 	.regwr_36(regwr_36),
  	.regwr_37(regwr_37),
  	.regwr_38(regwr_38),
  	.regwr_39(regwr_39),
 	.regwr_40(regwr_40),
 	.regwr_41(regwr_41),
 	.regwr_42(regwr_42),
 	.regwr_43(regwr_43),
  	.regwr_44(regwr_44),
  	.regwr_45(regwr_45),
  	.regwr_46(regwr_46),
 	.regwr_47(regwr_47),
 	.regwr_48(regwr_48),
 	.regwr_49(regwr_49),
 	.regwr_50(regwr_50),
  	.regwr_51(regwr_51),
  	.regwr_52(regwr_52),
  	.regwr_53(regwr_53),
 	.regwr_54(regwr_54),
 	.regwr_55(regwr_55),
 	.regwr_56(regwr_56),
 	.regwr_57(regwr_57),
  	.regwr_58(regwr_58),
  	.regwr_59(regwr_59),
  	.regwr_60(regwr_60),
 	.regwr_61(regwr_61),
 	.regwr_62(regwr_62),
 	.regwr_63(regwr_63),
 	.regwr_64(regwr_64),
  	.regwr_65(regwr_65),
  	.regwr_66(regwr_66),
  	.regwr_67(regwr_67),
 	.regwr_68(regwr_68),
 	.regwr_69(regwr_69),
 	.regwr_70(regwr_70),
 	.regwr_71(regwr_71),
  	.regwr_72(regwr_72),
  	.regwr_73(regwr_73),
  	.regwr_74(regwr_74),
 	.regwr_75(regwr_75),
 	.regwr_76(regwr_76),
 	.regwr_77(regwr_77),
 	.regwr_78(regwr_78),
  	.regwr_79(regwr_79),
  	.regwr_80(regwr_80),
  	.regwr_81(regwr_81),
 	.regwr_82(regwr_82),
 	.regwr_83(regwr_83),
 	.regwr_84(regwr_84),
 	.regwr_85(regwr_85),
  	.regwr_86(regwr_86),
  	.regwr_87(regwr_87),
  	.regwr_88(regwr_88),
 	.regwr_89(regwr_89),
 	.regwr_90(regwr_90),
 	.regwr_91(regwr_91),
 	.regwr_92(regwr_92),
  	.regwr_93(regwr_93),
  	.regwr_94(regwr_94),
  	.regwr_95(regwr_95),
 	.regwr_96(regwr_96),
 	.regwr_97(regwr_97),
 	.regwr_98(regwr_98),
 	.regwr_99(regwr_99),
  	.regwr_100(regwr_100),
  	.regwr_101(regwr_101),
  	.regwr_102(regwr_102),
 	.regwr_103(regwr_103),
 	.regwr_104(regwr_104),
 	.regwr_105(regwr_105),
 	.regwr_106(regwr_106),
  	.regwr_107(regwr_107),
  	.regwr_108(regwr_108),
  	.regwr_109(regwr_109),
 	.regwr_110(regwr_110),
 	.regwr_111(regwr_111),
 	.regwr_112(regwr_112),
  	.regwr_113(regwr_113),
  	.regwr_114(regwr_114),
 	.regwr_115(regwr_115),
 	.regwr_116(regwr_116),
 	.regwr_117(regwr_117),
 	.regwr_118(regwr_118),
  	.regwr_119(regwr_119),
  	.regwr_120(regwr_120) 
  	);
  //***********************
  
  //******* Test 7segment **********
  //wire [3:0] leds;
  
  //assign leds = regr_0;
  
  always@(*) begin
  case (regr_0)
   		4'd0   : segment <= 7'b1000000;
   		4'd1   : segment <= 7'b1111001;
   		4'd2   : segment <= 7'b0100100;
   		4'd3   : segment <= 7'b0110000;
   		4'd4   : segment <= 7'b0011001;
   		4'd5   : segment <= 7'b0010010;
   		4'd6   : segment <= 7'b0000010;
   		4'd7   : segment <= 7'b1111000;
   		4'd8   : segment <= 7'b0000000;
   		4'd9   : segment <= 7'b0010000;
       		default : segment <= 7'b0111111;
  endcase       
  end
  	
  assign AN = 8'b11111110;
  //*********************************
     
    
endmodule
