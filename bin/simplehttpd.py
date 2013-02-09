#!/usr/bin/env python
"""Starts a python http server in the current working directory.
Autoindexes files
"""
import argparse
import BaseHTTPServer
from SimpleHTTPServer import SimpleHTTPRequestHandler

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Simple Http Server in current directory')
    parser.add_argument('--port', dest='port', type=int, default=8000,
        help='default 8000')
    parser.add_argument('--addr', dest='addr', type=str, default='127.0.0.1',
        help='default 127.0.0.1')
    args = parser.parse_args()

    HandlerClass = SimpleHTTPRequestHandler
    ServerClass = BaseHTTPServer.HTTPServer
    Protocol = "HTTP/1.0"

    server_address = (args.addr, args.port)

    HandlerClass.protocol_version = Protocol
    httpd = ServerClass(server_address, HandlerClass)

    sa = httpd.socket.getsockname()
    print "Serving HTTP on", sa[0], "port", sa[1], "..."
    httpd.serve_forever()
