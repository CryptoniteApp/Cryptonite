from flask import Flask
from flask import request
import socket
from random import randint
import crypt
import json
from Crypto.Hash import SHA256

def get_lan_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("gmail.com", 80))
    ip = str(s.getsockname()[0])
    s.close()
    return ip

lolz = ['#420blaze','trump is the one true ruler','spread my legs and shit between','i bleached my asshole for this','clorox is my breakfast']

app = Flask(__name__)

@app.route('/')
def shitNuggets():
    return "shit nuggets"

@app.route('/choice', methods=["GET", "POST"])
def executeChoice():
    incoming = request.data
    print incoming
    textFile = open("/home/vishnu/Desktop/choices", 'w')
    textFile.write(incoming)
    textFile.close()
    return 'buttcheeks'

@app.route('/authcolors', methods=["GET", "POST"])
def authColors():
    incoming = request.data
    if SHA256.new(incoming).hexdigest() == SHA256.new(crypt.HEXKEY).hexdigest():
        return True
    else:
        return False

@app.route('/authtext', methods=["GET", "POST"])
def authText():
    incoming = request.data
    if SHA256.new(incoming).hexdigest() == SHA256.new(crypt.TEXTKEY).hexdigest():
        return True
    else:
        return False

@app.route('/phonetopc', methods=["GET", "POST"])
def updatePC():
    incoming = request.data
    print incoming
    textFile = open("/home/vishnu/Desktop/temp", 'w')
    textFile.write(incoming)
    i =(lolz[randint(0, 4)])

    return str(i)

@app.route('/combine', methods=["GET", "POST"])
def combine():
    incoming = request.data
    print incoming
    incoming = crypt.decrypt(crypt.KEY,crypt.IV,incoming)
    incoming = incoming[:incoming.rfind(']') + 1]
    list1 = json.loads(incoming)
    list2 = crypt.getList()
    list3 = list1 + list2
    list4_set = set(map(tuple, list3))
    list4 = map(list, list4_set)
    textFile = open("/home/vishnu/Desktop/temp", 'w')
    print list4
    outgoing = crypt.encrypt(crypt.KEY,crypt.IV,json.dumps(list4))
    textFile.write(outgoing)


    return outgoing

app.run(host=get_lan_ip(), port=4200, debug=False)