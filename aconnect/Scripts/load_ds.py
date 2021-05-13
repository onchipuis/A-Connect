import tensorflow as tf
import numpy as np
import math
import matplotlib.pyplot as plt

#Function that reshapes or quantizies the MNIST dataset

def load_ds(imgSize=[28,28], Quant=8):

	(x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()
	if (imgSize != [28,28]):
		x_train, x_test = np.expand_dims(x_train,-1),np.expand_dims(x_test,-1) #Need an extra dimension to apply tf.image.resize
		x_train = tf.image.resize_with_pad(x_train,imgSize[0],imgSize[1], method=tf.image.ResizeMethod.BICUBIC,antialias=True) #This function applies a resize similar to imresize in matlab
		x_test = tf.image.resize_with_pad(x_test,imgSize[0],imgSize[1], method=tf.image.ResizeMethod.BICUBIC,antialias=True)
		x_train, x_test = np.squeeze(x_train,-1),np.squeeze(x_test,-1) #Remove the extra dimension
	if(Quant !=8):
		xlsb = 256/2**Quant 
		x_train = np.floor(np.divide(x_train,xlsb))
		x_test = np.floor(np.divide(x_test,xlsb))
	
	return (x_train,y_train),(x_test,y_test)
	

#print(np.shape(x_train))

#plt.figure()
#plt.subplot(3,1,1)
#plt.imshow(x_train[0])
#plt.subplot(3,1,2)
#plt.imshow(x_train1[0])
#plt.subplot(3,1,3)
#plt.imshow(x_train2[0])
#plt.show()	

