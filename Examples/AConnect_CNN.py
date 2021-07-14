"""
In this script you will find an example of how to use A-Connect in a convolutional neural network for handwritten digits recognition using
MNIST 28x28 dataset.
"""

#Import all the dependecies
import tensorflow as tf
import numpy as np

#Import A-Connect library
import aconnect.layers as layers
import aconnect.scripts as scripts

#Load dataset
(x_train, y_train), (x_test, y_test) = scripts.load_ds() #Custom script to load MNIST data set, you can pass imgSize = [11,11] and Quant=4 to get mnist 11x11
# 4bits. By defaul you will load mnist 28x28 8 bits

Wstd = [0.3,0.5,0.7]
Bstd = [0.3,0.5,0.7]
#Let's define our model architecture with one hidden convolutional layer with 5 filters of 2,2
#Here you can play with all the attributes that the layer has.
for k in range(3):
	model = tf.keras.Sequential([
		tf.keras.layers.InputLayer(input_shape=[28,28]),
		tf.keras.layers.Reshape((28,28,1)), #Make sure that we include the depth dimension. For Gray-scale is 1 for RGB 3.
		layers.Conv_AConnect(5,(2,2),strides=1,padding="VALID",Wstd=Wstd[k],Bstd=Bstd[k],pool=None,isBin='no',Op=1
				,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),
		tf.keras.layers.BatchNormalization(),
		tf.keras.layers.ReLU(),
		tf.keras.layers.Flatten(),	
		layers.FC_AConnect(10,Wstd=Wstd[k],Bstd=Bstd[k],isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),	
		tf.keras.layers.Softmax()
	])

	#Also you can change the metrics, the optimizer, and training parameters.
	wstd = str(int(100*Wstd[k]))
	print("Training A-Connect with ", wstd+"%")
	top5 = tf.keras.metrics.SparseTopKCategoricalAccuracy(
	k=5, name='top_5_categorical_accuracy', dtype=None
	)
	optimizer = tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9)
	model.compile(optimizer=optimizer,loss=['sparse_categorical_crossentropy'],metrics=['accuracy',top5])
	history = model.fit(x_train,y_train,validation_split=0.2,epochs = 20,batch_size=256)
	loss, accuracy, top5acc = model.evaluate(x_test,y_test)
	model.save("MNIST_test_CNN_"+wstd+".h5", include_optimizer=True)
#After this,we can apply a monte carlo simulation
Simerr = [0,0.3,0.5,0.7]
for j in range(3):
	wstd = str(int(100*Wstd[j]))
	print("Testing A-Connect network trained with: ", wstd)
	for i in range(len(Simerr)):

		if Simerr[i] != Wstd[j]:
		    force = "yes"
		else:
		    force = "no"

		if Simerr[i] == 0:
			N = 1
		else:
			N = 1000
		print("Testing with error: ", str(int(Simerr[i])))
		acc = scripts.MonteCarlo("MNIST_test_CNN_"+wstd+".h5",x_test,y_test,N,Simerr[i],Simerr[i],force,net_name="MNIST_CNN_"+wstd,custom_objects={'FC_AConnect':layers.FC_AConnect,'Conv_AConnect':layers.Conv_AConnect},
		optimizer=tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9),loss=['sparse_categorical_crossentropy'],metrics=['accuracy',top5],top5=True)

a = np.loadtxt('MNIST_CNN_'+'30'+'_simerr_0_0.txt')
a = a.flatten()
b = np.loadtxt('MNIST_CNN_'+'30'+'_simerr_30_30.txt')
b = b.flatten()
c = np.loadtxt('MNIST_CNN_'+'30'+'_simerr_50_50.txt')
c = c.flatten()
d = np.loadtxt('MNIST_CNN_'+'30'+'_simerr_70_70.txt')
d = d.flatten()
data1 = [a,b,c,d]
a = np.loadtxt('MNIST_CNN_'+'50'+'_simerr_0_0.txt')
a = a.flatten()
b = np.loadtxt('MNIST_CNN_'+'50'+'_simerr_30_30.txt')
b = b.flatten()
c = np.loadtxt('MNIST_CNN_'+'50'+'_simerr_50_50.txt')
c = c.flatten()
d = np.loadtxt('MNIST_CNN_'+'50'+'_simerr_70_70.txt')
d = d.flatten()
data2 = [a,b,c,d]
a = np.loadtxt('MNIST_CNN_'+'70'+'_simerr_0_0.txt')
a = a.flatten()
b = np.loadtxt('MNIST_CNN_'+'70'+'_simerr_30_30.txt')
b = b.flatten()
c = np.loadtxt('MNIST_CNN_'+'70'+'_simerr_50_50.txt')
c = c.flatten()
d = np.loadtxt('MNIST_CNN_'+'70'+'_simerr_70_70.txt')
d = d.flatten()
data3 = [a,b,c,d]
x = [data1,data2,data3]
blue_line = [0, 0, 1]
blue_fill = [43/255, 227/255, 240/255]
red_line = [1, 0, 0]
red_fill = [1, 213/255, 213/255]
green_line = [44/255, 189/255, 110/255]
green_fill = [160/255, 233/255, 193/255]
scripts.plotBox(x, [0, 30, 50, 70], ["AConnect 30%", "AConnect 50%", "AConnect 70%"], [
		            red_line, blue_line, green_line], [red_fill, blue_fill, green_fill], 'MNIST_test_A-Connect_30_50_70')


