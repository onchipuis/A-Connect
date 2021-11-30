/**********************************************************************
 * Modified by Edward Silva 
 * Last Rev.: 05-24-2021
 * SPI SLAVE INTERFACE for FPGA implementation of Inference Neural Network
 **********************************************************************/
 
 module Top_SPI(
 input SCK,
 input CS,
 input MOSI,
 input clk,
 input rst,
 output MISO,
 
 input [3:0]regr_0,
 	
  output [7:0] regwr_0,
  output [7:0] regwr_1,
  output [7:0] regwr_2,
  output [7:0] regwr_3,
  output [7:0] regwr_4,
  output [7:0] regwr_5,
  output [7:0] regwr_6,
  output [7:0] regwr_7,
  output [7:0] regwr_8,
  output [7:0] regwr_9,
  output [7:0] regwr_10,
  output [7:0] regwr_11,
  output [7:0] regwr_12,
  output [7:0] regwr_13,
  output [7:0] regwr_14,
  output [7:0] regwr_15,
  output [7:0] regwr_16,
  output [7:0] regwr_17,
  output [7:0] regwr_18,
  output [7:0] regwr_19,
  output [7:0] regwr_20,
  output [7:0] regwr_21,
  output [7:0] regwr_22,
  output [7:0] regwr_23,
  output [7:0] regwr_24,
  output [7:0] regwr_25,
  output [7:0] regwr_26,
  output [7:0] regwr_27,
  output [7:0] regwr_28,
  output [7:0] regwr_29,
  output [7:0] regwr_30,
  output [7:0] regwr_31,
  output [7:0] regwr_32,
  output [7:0] regwr_33,
  output [7:0] regwr_34,
  output [7:0] regwr_35,
  output [7:0] regwr_36,
  output [7:0] regwr_37,
  output [7:0] regwr_38,
  output [7:0] regwr_39,
  output [7:0] regwr_40,
  output [7:0] regwr_41,
  output [7:0] regwr_42,
  output [7:0] regwr_43,
  output [7:0] regwr_44,
  output [7:0] regwr_45,
  output [7:0] regwr_46,
  output [7:0] regwr_47,
  output [7:0] regwr_48,
  output [7:0] regwr_49,
  output [7:0] regwr_50,
  output [7:0] regwr_51,
  output [7:0] regwr_52,
  output [7:0] regwr_53,
  output [7:0] regwr_54,
  output [7:0] regwr_55,
  output [7:0] regwr_56,
  output [7:0] regwr_57,
  output [7:0] regwr_58,
  output [7:0] regwr_59,
  output [7:0] regwr_60,
  output [7:0] regwr_61,
  output [7:0] regwr_62,
  output [7:0] regwr_63,
  output [7:0] regwr_64,
  output [7:0] regwr_65,
  output [7:0] regwr_66,
  output [7:0] regwr_67,
  output [7:0] regwr_68,
  output [7:0] regwr_69,
  output [7:0] regwr_70,
  output [7:0] regwr_71,
  output [7:0] regwr_72,
  output [7:0] regwr_73,
  output [7:0] regwr_74,
  output [7:0] regwr_75,
  output [7:0] regwr_76,
  output [7:0] regwr_77,
  output [7:0] regwr_78,
  output [7:0] regwr_79,
  output [7:0] regwr_80,
  output [7:0] regwr_81,
  output [7:0] regwr_82,
  output [7:0] regwr_83,
  output [7:0] regwr_84,
  output [7:0] regwr_85,
  output [7:0] regwr_86,
  output [7:0] regwr_87,
  output [7:0] regwr_88,
  output [7:0] regwr_89,
  output [7:0] regwr_90,
  output [7:0] regwr_91,
  output [7:0] regwr_92,
  output [7:0] regwr_93,
  output [7:0] regwr_94,
  output [7:0] regwr_95,
  output [7:0] regwr_96,
  output [7:0] regwr_97,
  output [7:0] regwr_98,
  output [7:0] regwr_99,
  output [7:0] regwr_100,
  output [7:0] regwr_101,
  output [7:0] regwr_102,
  output [7:0] regwr_103,
  output [7:0] regwr_104,
  output [7:0] regwr_105,
  output [7:0] regwr_106,
  output [7:0] regwr_107,
  output [7:0] regwr_108,
  output [7:0] regwr_109,
  output [7:0] regwr_110,
  output [7:0] regwr_111,
  output [7:0] regwr_112,
  output [7:0] regwr_113,
  output [7:0] regwr_114,
  output [7:0] regwr_115,
  output [7:0] regwr_116,
  output [7:0] regwr_117,
  output [7:0] regwr_118,
  output [7:0] regwr_119,
  output [7:0] regwr_120
  
 );
 
 //**** SPI ****
 
 localparam size_word = 8;
 wire ready; //Conexión entre la salida ready de access_controller.v y entrada ready spi_model.v
 wire [size_word-1:0]datar; // Conexión con la entrada datar del modulo spi_model.v que viene de la salida datar de access_controller.v
 wire [size_word-1:0]dataw; // Conexión con la salida dataw del modulo spi_model.v
 wire valid;
 
 spi_model#(size_word) SPI(
 
 	.SCK(SCK),
 	.CS(CS),
 	.MOSI(MOSI),
	.MISO(MISO),
	.clk(clk),
	.rst(rst),
	.ready(ready),
	.datar(datar),
	.dataw(dataw),
	.valid(valid)
);
// *******************
// **** Access Controller ****
localparam nregwr = 121; // Número de registros para la carga de la imagen-1
localparam nregr = 1; // Número de registros para la predicción del modelo

wire we;
wire [size_word-1:0]data_out; //Conexión entre salida data_out de access_controller.v y entrada dataw de registers.v
wire [size_word-1:0]data_in; //Conexión entre entrada data_in de access_controller.v y salida datar de registers.v
wire [$clog2(nregwr + nregr)-1:0]addr;

access_controller#(size_word, nregwr, nregr) CONTROL(
	.clk(clk),
	.rst(rst),
	.we(we),
	.data_out(data_out),
	.addr(addr),
	.data_in(data_in),
	.ready(ready),
	.datar(datar),
	.dataw(dataw),
	.valid(valid)
);
//********************
//**** Register banks ****
registers REGISTER(
	.clk(clk),
 	.rst(rst),
  	.we(we),
  	.dataw(data_out),
 	.addr(addr),
 	.datar(data_in),
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
endmodule