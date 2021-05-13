### Script to change the error matrix during inference or introduce the error to the layer weights
### HOw to
"""
Input Parameters
net: Loaded model
Wstd: Weights standard deviation for simulation
Bstd: Bias standard deviation for simulation
force: When you want to use the training deviation or the simulation deviation
Derr: Deterministic error
SRAMsz: ERror matrix size
SRAMBsz: Error vector size
This function returns a NoisyNet and the values of Wstd and Bstd used
"""
import numpy as np
import tensorflow as tf

def add_Wnoise(net,Wstd,Bstd,force,Derr,dtype='float32'):
	layers = net.layers #Get the list of layers used in the model
	Nlayers = np.size(layers) #Get the number of layers
	
	#Merr = np.random.randn(SRAMsz[0],SRAMsz[1]) #Takes from a normal distribution a matrix with the defined dimensions
	#Merr = Merr.astype(dtype)	
	#MBerr = np.random.randn(SRAMBsz[0]) #Takes from a normal distribution a vector with the defined dimensions
	#MBerr = MBerr.astype(dtype)	
#	
	for i in range(Nlayers): #Iterate over the number of layers
		if layers[i].count_params() != 0: #If the layer does not have training parameters it is omitted

			if hasattr(layers[i],'kernel') or hasattr(layers[i],'W'):  #Does the layer have weights or kernel?

				Wsz = np.shape(layers[i].weights[0]) #Takes the weights/kernel size
				Bsz = np.shape(layers[i].weights[1]) #Takes the bias size
				MBerr_aux = np.random.randn(Bsz[0])
				if hasattr(layers[i],'strides'): #If the layer have the attribute strides means that it is a convolutional layer
					Merr_aux = np.random.randn(Wsz[0],Wsz[1],Wsz[2],Wsz[3])
				else:
					Merr_aux = np.random.randn(Wsz[0], Wsz[1]) #If the layer does not have strides, it is a FC layer
				
				if hasattr(layers[i], 'Wstd'): #Does the layer have Wstd? if it is true is an A-Connect or DropConnect network
					if(layers[i].Wstd != 0): #IF the value it is different from zero, the layer is working with the algorithm
						if force == "no": #Do you want to take the training or simulation Wstd value?
							Wstd = layers[i].Wstd
						else:
							Wstd = Wstd
					else: #If it is false, it means that is working as a normal FC layer
						Wstd = Wstd
				else:
					Wstd = Wstd #If it is false, is a FC layers
				if hasattr(layers[i], 'Bstd'): #The same logic is applied for Bstd
					if(layers[i].Bstd != 0):
						if force == "no":
							Bstd = layers[i].Bstd
						else:
							Bstd = Bstd
					else:
						Bstd = Bstd
				else:
					Bstd = Bstd
				if hasattr(layers[i],'Werr') or hasattr(layers[i],'Berr') or hasattr(layers[i],'infWerr') or hasattr(layers[i],'infBerr'): #Now if the layer have Werr or Berr is an A-Conenct or DropConnect layer
					#print(i)#					
					Werr = abs(1+Wstd*Merr_aux) #Create the error matrix taking into account the Wstd and Bstd
					Berr = abs(1+Bstd*MBerr_aux)
					if(layers[i].isBin == 'yes'): 
						if(Derr != 0): #Introduce the deterministic error when BW are used
							weights = layers[i].weights[0]
							wp = weights > 0
							wn = weights <= 0 
							wn = wn.numpy()
							wp = wp.numpy()
							Werr = Derr*wn*Werr + Werr*wp
					if hasattr(layers[i], 'Wstd'):
						if(layers[i].Wstd != 0):
							layers[i].infWerr = Werr #Change the inference error matrix
						else:			
							#print(layers[i].Werr)                            
							layers[i].Werr = Werr
					else:
							layers[i].Werr = Werr					
					if hasattr(layers[i], 'Bstd'):
						if(layers[i].Bstd != 0):
							layers[i].infBerr = Berr #Change the inference error matrix
						else:
							layers[i].Berr = Berr
					else:
						layers[i].Berr = Berr
				else:                #if the layer is not A-Conenct or DropCOnnect the error must be introduced to the weights because it is a normal FC or normal Conv layer
					Werr = abs(1+Wstd*Merr_aux) #Error matrices
					Berr = abs(1+Bstd*MBerr_aux)
					weights = layers[i].weights[0]*Werr #Introduce the mismatch to the weights
					bias = layers[i].weights[1]*Berr #Introduce the mismatch to the bias
					local_weights = [weights,bias] #Create the tuple of modified values
					layers[i].set_weights(local_weights) #Update the values of the weights

	

		
	#layers = [tf.keras.layers.Flatten(input_shape=(28,28)),tf.keras.layers.Dense(10),tf.keras.layers.Softmax()]		
	NoisyNet = tf.keras.Sequential(layers)
	#net.compile(optimizer,loss,metrics)	
	return NoisyNet,Wstd,Bstd
				
