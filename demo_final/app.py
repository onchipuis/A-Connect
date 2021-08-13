from flask import Flask, jsonify, render_template, request
import simplejson as json
import tensorflow as tf
import numpy as np
#import time
#import amazilia

app = Flask(__name__)
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/digit_prediction', methods=['POST'])

def digit_prediction():
	if(request.method == "POST"):
		img = request.get_json()
		img=255-np.array(img).reshape(28,28).astype(np.uint8)
		img = np.expand_dims(img,-1)
		img = tf.image.resize(img,[11,11],method=tf.image.ResizeMethod.BILINEAR,antialias=True)
		img = np.squeeze(img,-1)
		img = tf.cast(img,tf.uint8)
		img = np.array(img) 
		
		data = []
		data = img.flatten().tolist()
		#amazilia.write(data)
		with open('Image_demo.json', 'w') as file:
			json.dump(data, file) 
		np.savetxt('Image_demo',img, fmt='%d')        	
		#data = { "Prediction":prediction}
		return '''<p>Se creo la imagen ahora se va a pasar por la FPGA para hacer la predicción.</p>'''
if __name__ == "__main__":
    app.run(debug=True)
