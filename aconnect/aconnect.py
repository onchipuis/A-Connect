import tensorflow as tf
import numpy as np
from Layers import AConnect
from Layers import ConvAConnect
from Scripts import classify
from Scripts import load_ds
from Scripts import MCsim
from Scripts import plotters

"""
Top script for the library. Here you will find all the layers that it was made. And maybe, some useful scripts.

HOW TO:
from AConnect import layers

FC = layers.FC_AConnect(...)
"""

class layers():
	def FC_AConnect(output_size,Wstd=0,Bstd=0,isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None):
		return AConnect.AConnect(output_size,Wstd=Wstd,Bstd=Bstd,isBin=isBin,pool=pool,Slice=Slice,d_type=d_type,weights_regularizer=weights_regularizer,bias_regularizer=bias_regularizer)
	def Conv_AConnect(filters,kernel_size,strides=1,padding="VALID",Wstd=0,Bstd=0,pool=None,isBin='no',Op=1
			,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None):
		return ConvAConnect.ConvAConnect(filters,kernel_size,strides=strides,padding=padding,Wstd=Wstd,Bstd=Bstd,pool=pool,isBin=isBin,Op=Op
			,Slice=Slice,d_type=d_type,weights_regularizer=weights_regularizer,bias_regularizer=bias_regularizer)			
			
class scripts():
	#Function to make the monte carlo simulation. To see more please go to the original file in Scripts
	def MonteCarlo(net,Xtest,Ytest,M,Wstd,Bstd,force,Derr=0,net_name="Network",custom_objects=None,dtype='float32',
	optimizer=tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9),loss=['sparse_categorical_crossentropy'],metrics=['accuracy'],top5=False):
		return MCsim.MCsim(net,Xtest,Ytest,M,Wstd,Bstd,force,Derr=0,net_name="Network",custom_objects=None,dtype='float32',
		optimizer=tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9),loss=['sparse_categorical_crossentropy'],metrics=['accuracy'],top5=False)		
	#Function to do inference. You also could have the top-5 accuracy if you passed to the model metrics and then setting top5=True
	def classify(net,Xtest,Ytest,top5):
		return classify.classify(net,Xtest,Ytest,top5)
	#Function to load the MNIST dataset. THis function could load the standard 28x28 8 or 4 bits dataset, or 11x11 8 or 4 bits dataset.		
	def load_ds(imgSize=[28,28], Quant=8):
		return load_ds.load_ds(imgSize=[28,28], Quant=8)
	#Function to plot the box chart
	def plotBox(data,labels,legends,color,color_fill,path):
		return plotters.plotBox(data,labels,legends,color,color_fill,path)
		
#For more information please see the github readme or the source code for every function or layer we use here.		
