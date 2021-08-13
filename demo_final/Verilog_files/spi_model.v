/**********************************************************************
 * Created by Edward Silva take on base SPI protocol for Amazilia. 
 * Last Rev.: 26-05-2021
 * SPI SLAVE INTERFACE for FPGA implementation of Inference Neural Network
 **********************************************************************/
//`timescale 1ns / 1ps
module spi_model#(parameter size_word = 8)
	(
	input SCK,
	input CS,
	input MOSI,
	output MISO,
	input clk,
	input rst,
	input ready,
	input [size_word-1:0]datar, // It's the ouput data from FPGA, what indicated all over preditions of the model.
	output [size_word-1:0]dataw, //Added a bit more to indicate if will write or read on register banks. The MSB don't care.
	output reg valid
		);
	genvar i;
	//******** CS SYNCRONIZER*****
	reg [1:0]CS_sync;
	always @(posedge clk)begin
		CS_sync[0] <= CS;
		CS_sync[1] <= CS_sync[0];
	end
	//*****************************
	//******* SCK ANALYZER *******
	reg [1:0]SCK_sync;
	always @(posedge clk)begin
		if(rst)
			SCK_sync <= 0; //due to spi mode
		else
			SCK_sync[0] <= SCK;
			SCK_sync[1] <= SCK_sync[0];
	end
	reg late_SCK;
	always @(posedge clk)begin
		if(rst)
			late_SCK <= 0; //due to spi mode
		else
			late_SCK <= SCK_sync[1];
	end
	wire SCK_RE; // Syncronizer clock-Raise edge 
	wire SCK_FE; // Syncronizer clock-Fall edge
	assign SCK_RE=~late_SCK & SCK_sync[1] & ~CS_sync[1]; // Posedge detector of SCK
	assign SCK_FE= late_SCK &~SCK_sync[1] & ~CS_sync[1]; // Negedge detector of SCK
	//**************************************

	//***** STATE COUNTER ********
	reg [3:0]counter;
	always @(posedge clk)begin
		if(rst || (counter==(size_word-1) & SCK_FE))
			counter <= 0;
		else if(SCK_FE)
			counter <= counter+1;
	end

	always @(posedge clk)begin
		if(rst)
			valid <= 0;
		else
		 	valid <= counter==(size_word-1) & SCK_RE; // To indicated that all over the datas were received.
	end
	//**********************************

	//***** MOSI SHIFT REGISTER ********
	reg [1:0]MOSI_sync; // Master Out-Slave int
	always @(posedge clk)begin
		if(rst)
			MOSI_sync <= 2'b11; //due to spi mode
		else
			MOSI_sync[0] <= MOSI;
			MOSI_sync[1] <= MOSI_sync[0];
	end
	reg [size_word-1:0] MOSI_SR; //Must be similar to dataw input(word size)
	always @(posedge clk)begin
		if(rst)
			MOSI_SR <= 8'b1111_1111; //due to spi mode
		else if(SCK_RE) begin
			MOSI_SR[0] <= MOSI_sync[1];  // Registro de desplazamiento de 8 bits
			MOSI_SR[size_word-1:1] <= MOSI_SR[size_word-2:0];
		end
	end
	assign dataw = MOSI_SR;
	//**********************************

	//***** MIS0 SHIFT REGISTER ********  // Master int-Slave Out
	reg [size_word-1:0] MISO_SR;
	reg sending;
	always @(posedge clk)begin
		if( CS_sync[1] | rst)begin
			MISO_SR <= 8'b1111_1111; //due to spi mode
			sending <= 0;
		end
		else if( SCK_FE & ready & ~sending)begin //Loading all data from datar input on MISO_SR register. Change state of sending to 1
			MISO_SR <= datar;
			sending <= 1;
		end
		else if( SCK_FE & ready & sending) //Sending the data through MISO output to Master(PC) 
			MISO_SR[size_word-1:1]<=MISO_SR[size_word-2:0];		
	end
	assign MISO = MISO_SR[size_word-1]; 
	//**********************************
endmodule