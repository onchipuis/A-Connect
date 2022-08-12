"""
In this script you will find an example of how to use A-Connect in a recurrent neural network for handwritten digits recognition using
MNIST 28x28 dataset.

You can select which cell to use by changing the cell variable to either FastGRNNCell_AConnect, LSTMCell_AConnect, GRUCell_AConnect
"""

import tensorflow as tf
import numpy as np

from aconnect.layers import FastGRNNCell_AConnect
from aconnect.layers import LSTMCell_AConnect
from aconnect.layers import GRUCell_AConnect

from aconnect.scriptsn import MonteCarlo
monteCarloConfig = {}

cell = GRUCell_AConnect
unroll = True # Setting it to True might increase performance

# Build the RNN model

epochs = 4
batch_size = 64
input_dim = 28
units = 64
output_size = 10  # labels are from 0 to 9

def build_model(recurrent_cell, Wstd, Bstd):
    model = tf.keras.models.Sequential(
      [
        tf.keras.layers.Input(shape=(28, 28)),
        tf.keras.layers.RNN(recurrent_cell(units, Wstd=Wstd, Bstd=Bstd, pool=2, isBin=False, implementation=2), input_shape=(None, input_dim), unroll=False),
        tf.keras.layers.Dense(output_size),
      ]
    )
    return model
    
Wstds = [0.0, 0.3, 0.5, 0.7]
Bstds = [0.0, 0.3, 0.5, 0.7]

models = [build_model(cell, Wstd, Bstd) for Wstd, Bstd in zip(Wstds, Bstds)]

# Download dataset

mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

trainDataset = tf.data.Dataset.from_tensor_slices((x_train, y_train)).batch(batch_size).cache().prefetch(tf.data.AUTOTUNE)
testDataset = tf.data.Dataset.from_tensor_slices((x_test, y_test)).batch(10000).cache().prefetch(tf.data.AUTOTUNE)

# Print the summary for a model, should be the same for every model as only the variability is different

for model in models:
  model.compile(
      loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
      optimizer="adam",
      metrics=["accuracy"],
  )

models[0].summary()

# Train every model

for model, Wstd, Bstd in zip(models, Wstds, Bstds):
  print(f"Training model: Wstd:{Wstd}, Bstd:{Bstd}")
  model.fit(trainDataset, None, epochs=4)
  
# Test every model with a Monte Carlo of 1000 samples
simWstds = [0.0, 0.3, 0.5, 0.7]
simBstds = [0.0, 0.3, 0.5, 0.7]

for model, Wstd, Bstd in zip(models, Wstds, Bstds):
  print(f"Testing model: Wstd:{Wstd}, Bstd:{Bstd}")
  for simWstd, simBstd in zip(simWstds, simBstds):
    M = 1000
    if simWstd == 0.0 and simBstd == 0.0:
      M = 1
    MonteCarlo(model, testDataset, None, M=M, batch_size=None, Wstd=simWstd, Bstd=simBstd, runEagerly=False, save_path=None, useTfVariable=True)