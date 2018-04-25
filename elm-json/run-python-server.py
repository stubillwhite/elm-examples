#!/usr/bin/python

from SimpleHTTPServer import SimpleHTTPRequestHandler
import SocketServer

class CORSRequestHandler (SimpleHTTPRequestHandler):

    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        SimpleHTTPRequestHandler.end_headers(self)

handler = CORSRequestHandler

httpd = SocketServer.TCPServer(("", 8080), handler)
httpd.serve_forever()
