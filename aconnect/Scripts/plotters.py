import matplotlib.pyplot as plt
"""
Script to plot and save a box chart with custom style.
"""

def plotChart(ax,x,color=0,color_fill=0,labels=None): #Script that plots the box, needed in the script below
    boxprops = dict(linestyle='-', linewidth=3,facecolor=color_fill,color=color)
    whiskerprops = dict(color=color, linewidth=3)
    flierprops = dict(marker='.', markerfacecolor=color, markersize=6,
                  markeredgecolor=color)   
    capprops = dict(color=color) 
    medianprops = dict(color=color)
    b = ax.boxplot(x,notch=False,widths=0.2,labels=labels,patch_artist=True,
                boxprops=boxprops,whiskerprops=whiskerprops,flierprops=flierprops,
                capprops=capprops,medianprops=medianprops
                )
    return b
    
def plotBox(data,labels,legends,color,color_fill,path): #Top script  to plot the box with custom style
	"""
	HOW TO:
	data: Data that you want to plot, should be a list or a list of list (maximum 3 list) i.e. data= [data1,data2,data3] where data1 = [x1,x2,...], 
	data2=[y1,y2,...], data3=[z1,z2,...]
	labels: Labels for the x-axis. Must have the same dimension as the data that you are going to plot.
	legends: String. Legends for the plot. Must have the same dimension as the data parameter e.g. data = [data1,data2], legends=[legend1,legend2]
	color: Color for the lines. Should be a list of size 3 with RGB Color.
	color_fill: Color for filling the boxes. Should be a list of size 3 with RGB Color.
	path: String. Where you want to save the image and the name of the archive. By default you do not need to indicate a saving format. By default all
	the images are saved in png format."""
	font = {'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 12}      
	fig = plt.figure(figsize=(5,10))
	ax = fig.add_axes([0.1,0.1,0.8,0.8])
    #plt.rcParams['mathtext.rm'] = 'Arial'
	plt.rc('font',**font)            
	ax.set_xlabel("Simulation Error (%)",fontdict={'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 15})
	ax.set_ylabel("Validation Accuracy (%)",fontdict={'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 17})  
	d_size = len(data)   
	if d_size == 1:     
		b1 = plotChart(ax,data,color=color,color_fill=color_fill,labels=labels)
		ax.legend([b1["boxes"][0]],legends, loc='lower left',prop={'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 12})	    
	elif d_size == 2:
		b1 = plotChart(ax,data[0],color=color[0],color_fill=color_fill[0],labels=labels)	        
		b2 = plotChart(ax,data[1],color=color[1],color_fill=color_fill[1],labels=labels)
		ax.legend([b1["boxes"][0], b2["boxes"][0]],[legends[0], legends[1]], loc='lower left',prop={'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 12})
	else:
		b1 = plotChart(ax,data[0],color=color[0],color_fill=color_fill[0],labels=labels)	        
		b2 = plotChart(ax,data[1],color=color[1],color_fill=color_fill[1],labels=labels)
		b3 = plotChart(ax,data[2],color=color[2],color_fill=color_fill[2],labels=labels)	    
		ax.legend([b1["boxes"][0], b2["boxes"][0],b3["boxes"][0]],[legends[0], legends[1], legends[2]], loc='lower left',prop={'family':'serif','style':'normal','weight' : 'semibold',
        'size'   : 12})	        
 
	ax.spines['top'].set_linewidth(1.4)
	ax.spines['right'].set_linewidth(1.4)
	ax.spines['bottom'].set_linewidth(1.4)
	ax.spines['left'].set_linewidth(1.4)
	plt.savefig(path+'.png')   
