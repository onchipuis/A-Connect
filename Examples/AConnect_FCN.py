"""
In this script you will find an example of how to use A-Connect in a fully connected neural network for handwritten digits recognition using
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

#Let's define our model architecture with one hidden layer of 128 neurons
#Here you can play with all the attributes that the layer has.
model = tf.keras.Sequential([
	tf.keras.layers.Flatten(input_shape=(28,28)),
	layers.FC_AConnect(128,Wstd=0.5,Bstd=0.5,isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),
	tf.keras.layers.BatchNormalization(),
	tf.keras.layers.ReLU(),
	layers.FC_AConnect(10,Wstd=0.5,Bstd=0.5,isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),	
	tf.keras.layers.Softmax()
])

#Also you can change the metrics, the optimizer, and training parameters.

top5 = tf.keras.metrics.TopKCategoricalAccuracy(
    k=5, name='top_5_categorical_accuracy', dtype=None
)
optimizer = tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9)
model.compile(optimizer=optimizer,loss=['sparse_categorical_crossentropy'],metrics=['accuracy',top5])
history = model.fit(x_train,y_train,validation_split=0.2,epochs = 10,batch_size=256)
loss, accuracy, top5acc = model.evaluate(x_test,y_test)

#After this,we can apply a monte carlo simulation

accuracy = scripts.MonteCarlo(model,x_test,y_test,1000,0.5,0.5,"no",net_name="MNIST28X28_8Bits",custom_objects={"AConnect":AConnect},
optimizer=tf.keras.optimizers.SGD(learning_rate=0.1,momentum=0.9),loss=['sparse_categorical_crossentropy'],metrics=['accuracy',top5],top5=True)
scripts.plotBox(accuracy,50,"AConnect 50%",[0,0,1],[43/51,227/255,240/255])



