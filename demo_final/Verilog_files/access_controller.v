/**********************************************************************
 * Modified by Edward Silva 
 * Last Rev.: 05-24-2021
 * SPI SLAVE INTERFACE for FPGA implementation of Inference Neural Network
 **********************************************************************/
//`timescale 1ns / 1ps
module access_controller #(parameter size_word = 8, parameter nregwr = 121, parameter nregr = 1)//You have 122 register on the bank. 121 for write and 1 for read 
	(
	input clk,
	input rst,

	output  reg we, // Indicate if it's write mode (we=1) or read mode (we=0)
	output reg [size_word-1:0]data_out,//The data to write on registers bank
	output reg [$clog2(nregwr+nregr)-1:0]addr,// Address to write or read
	input [size_word-1:0]data_in,//The data to read from registers bank.

	output reg ready,
	output [size_word-1:0]datar, //The data that will read and send to the Master(PC)
	input [size_word-1:0]dataw, //Added a bit more to indicate if will write or read on register banks. The MSB don't care.
	input valid // Indicates id everything is working properly.
		);
	localparam adrr_s = 0;
	localparam write = 1;
	localparam read = 2;
	//localparam burst=3;
	
	reg [$clog2(nregwr)-1:0]write_cnt;
	reg [1:0] state;
	always @(posedge clk) begin
		if(rst)begin
			state <= adrr_s;
		end
		else if( state==adrr_s & dataw[size_word-1] & valid)begin // If data sent has MSB equal to 1 then, to move to Write state
			state <= write;
		end
		else if( state==adrr_s & ~dataw[size_word-1] & valid)begin //If data sent has MSB equal to 0 then, to move to Write state
			state <= read;
		end
		else if( state==write & write_cnt==(nregwr) )begin
			state<=adrr_s;		
		end
		else if( state==read & valid )begin
			state <= adrr_s;
		end
	end
	//reg read_we;
	//reg write_we;
	//assign we = single_we;
    assign datar = data_in;
	always @(posedge clk) begin

		//****sampling address*******
		if(rst)
			addr <= 0;
		else if( state==adrr_s & valid)
			addr <= dataw[$clog2(nregwr+nregr)-1:0]; // Requiero 8 bits para ubicar los registros
			
		else if (state==write)
			addr <= write_cnt;
		//*********************	
		//****Read transaction actions**
		if(rst)begin
			ready <= 0;
		end 
		else if(state==read)begin
			ready <= 1;
		end
		else
			ready <= 0;
		//**************
		//****Write transaction actions**
		if(rst | state==write & write_cnt==(nregwr) )begin
			write_cnt <= 0;
			data_out <= 0;
			we <= 0;
		end
		else if(state==write & valid )begin
			write_cnt <= write_cnt + 1;
			we  <= 1 ;
			data_out <= dataw;
		end
		else 
			we <= 0;

		//*******************************
	end
endmodule