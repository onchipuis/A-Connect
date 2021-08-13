//`timescale 1ns / 1ps
module neuron_out#(parameter size_word = 8, parameter number_image = 121, parameter size_weight = 1)(
	input signed [size_word*number_image-1:0] Image,
	input [number_image-1:0] Weight,
		
	output [(2*size_word)-1:0] out
);


//**** Internal signals ****
wire signed [(2*size_word)-1:0] aux_mult [number_image-1:0]; //Se agrega un bit más para el signo y vaya de -254,255
wire [size_word-1:0] aux_image [number_image-1:0];

wire aux_weight [number_image-1:0];
reg signed [(2*size_word)-1:0] aux_sum;
integer j; 
//***********************

//**** To archieve neuron output
genvar i;
generate
	for(i=0;i<number_image;i=i+1) begin // Llenamos todo en un vector para poder hacer la mult elemento por elemento
		assign aux_image[i] = Image[(size_word)*(i+1)-1:size_word*i];
		
		assign aux_weight[i] = Weight[(number_image-1)-i];
	end
	
	for(i=0;i<number_image;i=i+1)begin
		assign aux_mult[i] = aux_weight[i] ? aux_image[i] : -aux_image[i];
		//assign aux_mult[i] = aux_weight[i] ? aux_image[i] : 0;
	end
endgenerate

always@(*)begin
	aux_sum = 0;
	for(j=0;j<number_image;j=j+1)begin
		aux_sum = aux_sum + aux_mult[j];	
	end

end

assign out = aux_sum;

//***********************    

endmodule
