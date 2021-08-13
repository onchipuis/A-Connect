`timescale 1ns / 1ps


module ReLu#(parameter size_image = 8)(
    input signed [2*size_image-1:0] in_relu,
    output [2*size_image-1:0] out_relu
    );
    assign out_relu = (in_relu[2*size_image-1] == 0)? in_relu : 0;   //if the sign bit is high, send zero on the output else send the input
      
endmodule
