#!/usr/bin/python3
import Aconnect_FC
import simplejson as json
import sys
def main():
	if(sys.argv[1] =='r'):
		print(Aconnect_FC.read(int(sys.argv[2])))
	elif(sys.argv[1] =='w'):
		with open(sys.argv[2], 'r') as file:
			aux=json.load(file)
		file.close()
		data=[]
		for i in range(len(aux)):
			data.append(int(aux[i]))
		Aconnect_FC.write(data)
		print("Its working")
	elif(sys.argv[1] =='ra'):
		out=Aconnect_FC.multiread(int(sys.argv[2]),int(sys.argv[3]))
		for i in range(int(sys.argv[2]),1+int(sys.argv[3])):
			print("address: "+ str(i) + "\tdata: " + str(out[i]))
	else:
		print("Invalid arguments")


main()
