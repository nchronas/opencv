import cv2 as oc
import numpy as np

from flask import Flask, request, redirect, render_template

app = Flask(__name__)
@app.route("/", methods=['GET', 'POST'])
def hello_monkey():
	return render_template('index.html')


if __name__ == "__main__":
	print "Hello Opencv"
	filename = 'chessboard.jpg'
	img = oc.imread(filename)
	gray = oc.cvtColor(img,oc.COLOR_BGR2GRAY)

	gray = np.float32(gray)
	dst = oc.cornerHarris(gray,2,3,0.04)

	#result is dilated for marking the corners, not important
	dst = oc.dilate(dst,None)

	# Threshold for an optimal value, it may vary depending on the image.
	img[dst>0.01*dst.max()]=[0,0,255]

	oc.imwrite('dst.jpg',img)


	app.run( host='0.0.0.0', debug=True, port = 80)