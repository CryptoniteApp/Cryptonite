from flask import Flask
from flask import request
import socket

def get_lan_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("gmail.com", 80))
    ip = str(s.getsockname()[0])
    s.close()
    return ip

app = Flask(__name__)



@app.route('/')
def hello_world():
    print 'shit nuggets'
    return 'shit nuggets'


@app.route('/poopass')
def hello_worlz():
    print 'poop ass'
    return 'poop ass'


@app.route('/phonetopc', methods=["GET", "POST"])
def updatePC():
    incoming = request.data
    textFile = open("/home/vishnu/Desktop/temp", 'w')
    textFile.write(incoming)
    return 'booty'

@app.route('/combine', methods=["GET", "POST"])
def combine():
    incoming = request.data
    textFile = open("/home/vishnu/Desktop/temp", 'w')
    textFile.write(incoming)
    return 'hmmmLetsPork'

app.run(host=get_lan_ip(), port=4200, debug=False)