"""
In this script you will find an example of how to use A-Connect in a fully connected neural network for handwritten digits recognition using
MNIST 28x28 dataset.
"""

#Import all the dependecies
import tensorflow as tf
import numpy as np

#Import A-Connect library
import AConnect

#Load dataset

(x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()

#Let's define our model architecture with one hidden layer of 128 neurons
#Here you can play with all the attributes that the layer has.
model = tf.keras.Sequential([
	tf.keras.layers.Flatten(input_shape=(28,28)),
	AConnect.layers.FC_AConnect(128,Wstd=0.5,Bstd=0.5,isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),
	tf.keras.layers.BatchNormalization(),
	tf.keras.layers.ReLU(),
	AConnect.layers.FC_AConnect(10,Wstd=0.5,Bstd=0.5,isBin="no",pool=None,Slice=1,d_type=tf.dtypes.float32,weights_regularizer=None,bias_regularizer=None),	
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

