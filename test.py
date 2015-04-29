import cv2 as oc
import numpy as np

import socket
import SocketServer
import SimpleHTTPServer

PORT = 80

class CustomHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def log_message(self, format, *args):
        return
 
    def do_GET(self):
        print self.path 	
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

filename = 'chessboard.jpg'
img = oc.imread(filename)
gray = oc.cvtColor(img,oc.COLOR_BGR2GRAY)
gray = np.float32(gray)
dst = oc.cornerHarris(gray,2,3,0.04)

dst = oc.dilate(dst,None)

img[dst>0.01*dst.max()]=[0,0,255]

oc.imwrite('dst.jpg',img)

httpd = SocketServer.ThreadingTCPServer(('', PORT),CustomHandler)
 
print "serving at port", PORT
httpd.serve_forever()