#!/bin/bash
yum update -y
yum install -y python3 mysql
pip3 install mysql-connector-python

cat <<EOF > /home/ec2-user/app.py
from http.server import BaseHTTPRequestHandler, HTTPServer
import mysql.connector

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        conn = mysql.connector.connect(
            host='your-rds-endpoint',
            user='admin',
            password='your-password',
            database='your-Database-Name'
        )
        cursor = conn.cursor()
        cursor.execute("SELECT content FROM messages LIMIT 1")
        result = cursor.fetchone()[0]
        conn.close()
        self.send_response(200)
        self.end_headers()
        self.wfile.write(result.encode())

server = HTTPServer(('', 4000), Handler)
server.serve_forever()
EOF

nohup python3 /home/ec2-user/app.py > /home/ec2-user/app.log 2>&1 &
