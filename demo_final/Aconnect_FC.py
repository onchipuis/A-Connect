#!/usr/bin/python3
from pyftdi.spi import SpiController
import struct

TOTAL_REGS=121
# Instantiate a SPI controller
spi = SpiController()

# Configure the first interface (IF/1) of the FTDI device as a SPI master
spi.configure('ftdi://ftdi:232h/1')

# Get a port to a SPI slave w/ /CS on A*BUS3 and SPI mode 0 @ 12MHz
slave = spi.get_port(cs=0, freq=12E6, mode=0)


def read(addr):
		out=slave.exchange([addr],1)
		out=struct.unpack('>B',out)[0]
		return out

def write(data):
		assert(len(data)==TOTAL_REGS) # Comprueba que se cumpla la condición
		data.insert(0,0xFF)
		slave.exchange(data,0)#Envio dos datos y no recibo ninguno

def multiread(initial,final):
		assert((final-initial)<=TOTAL_REGS)
		regs=[]
		for i in range(initial,1+final):
			out=slave.exchange([i],1)
			out=struct.unpack('>B',out)[0]
			regs.append(out)
		return regs






