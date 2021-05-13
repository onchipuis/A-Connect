# Library for A-Connect
Here you will find the main script for the library. 

## How to

Copy and paste this script in the same folder of your project to start using it. Then, import the library to your project where you are creating the NN model.
```
import AConnect as ac
```

## Content description

### Layers

#### Fully-Connected A-Connect 
This layer is a custom fully-connected or dense layer with A-Connect during the training process. This layer has this attributes:

1.**output_size**: This is the number of neurons that you want to use. 

2.**Wstd**: Standard deviation for the weights. Should be a number between 0 and 1. By default is 0.

3.**Bstd**: Standard deviation for the bias. Should be a number between 0 and 1. By default is 0.

4.**isBin**: String, "yes" or "no", for using or not using weights binarization. By default is "no".

5.**pool**: Number of error matrices that you want to use for model regularization or mismatch mitigation. This value should be equal or less than the batch size. By default is None. (Same number of error matrices as the batch size).

6.**Slice**: Integer for batch slicing. Used for reducing memory consumption. The layer only accepts slice into 2,4 or 8 minibatches. By default is 1 (no slice).

7.**d_type**: Data type of the weights, bias and error matrices. By default is floating point 32 bits. (tf.float32)

8.**weights_regularizer**: Any of tf.keras.regularizers for the weights. By default is None.

9.**bias_regularizer**: Any of tf.keras.regularizers for the biases. By default is None.

#### Convolutional A-Connect 
This layer is a custom convolutional layer with A-Connect during the training process. This layer has this attributes:

1.**filters**: This is the number of filters that you want to use. 

2.**kernel_size**: Kernel size. Must be a tuple (n,n).

3.**strides**: Strides for the convolution. Must be a integer to generate a stride of (1,n,n,1).

4.**padding**:  Integer for padding. Use "VALID" if you want to reduce the input size. Use "SAME" if you want to keep the input size.

5.**Wstd**: Standard deviation for the kernel. Should be a number between 0 and 1. By default is 0.

6.**Bstd**: Standard deviation for the bias. Should be a number between 0 and 1. By default is 0.

7.**pool**: Number of error matrices that you want to use for model regularization or mismatch mitigation. This value should be equal or less than the batch size. By default is None. (Same number of error matrices as the batch size).

8.**isBin**: String, "yes" or "no", for using or not using weights binarization. By default is "no".

9.**Op**:  Integer 1 or 2. There are two options to make the batch convolution. The first option, 1, uses a function from tensorflow called tf.map_fn, this function applies the convolution to all the elements in axis 0 or batch. This option has less memory consumption, but it is slow. The second one, 2, applies some reshapes over the input data and the kernel to do a depth-wise convolution. This option is faster when it is used for small images, but has higher memory usage.

10.**Slice**: Integer for batch slicing. Used for reducing memory consumption. The layer only accepts slice into 2,4 or 8 minibatches. By default is 1 (no slice).

11.**d_type**: Data type of the weights, bias and error matrices. By default is floating point 32 bits. (tf.float32)

12.**weights_regularizer**: Any of tf.keras.regularizers for the weights. By default is None.

13.**bias_regularizer**: Any of tf.keras.regularizers for the biases. By default is None.
