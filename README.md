# A-Connect
Custom library for A-Connect training methodology for neural networks. Available only in Keras/TensorFlow.

## What is A-Connect?

As it was mentioned before, A-Connect is a training methodology for neural networks. A-Connect improves the performance of a neural network when this is used on a inaccurate hardware. Also A-Connect provides an accurate way to binarize the weights of a neural network during the training process.

## How A-Connect works?

If you are similar to a regularization techniques like DropOut or DropConnect, you should found that A-Connect is very similar to this algorithms. However, the purpose of A-Connect is very different. A-Connect is focused on mitigate the hardware mismatch of a DNN (Deep Neural Network) accelerator. So how A-Connect can do this? To answer this in the figure 1 you can see how DropOut or DropConnect works. The first one, DropOut in figure 1.b, uses a Bernoulli distribution to turn-off some neurons to improves the model adaptation. In figure 1.c, DropConnect also uses a Bernoulli distribution, but instead of turning off the neurons, DropConnect turns off the weights of the layer. As consequence of this, with DropOut and DropConnect it is possible to reduce the overfitting of a model. Now lets see the figure 1.d, this figure ilustrates how A-Connect, instead of using a Bernoulli distribution to turning off the weights, A-Connect uses a normal distribution and then as ample of this distribtuion it is multiplied with the weights.

![Figure 1](./fig1.jpg "Fig1")
