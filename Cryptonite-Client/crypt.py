import binascii

import time
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
import json
import qrcode
import socket
from flask import Flask
import os

app = Flask(__name__)

MODE = AES.MODE_CFB
BLOCK_SIZE = 16
SEGMENT_SIZE = 128
IV = ''

TEXTKEY = 'MrKrabs@123'
HEXKEY = "#2980B9#27860#E67E22#AE44AB#2C3E50#F1C40F"



def main():
    pass

def beginSession():
    passInfo = json.loads(decrypt(KEY, IV, open('/home/vishnu/Desktop/bms.txt','r').read()))
    print passInfo

def endSession():
    encryptedText = encrypt(KEY, IV, json.dumps(passInfo))
    print encryptedText
    textFile = open("/home/vishnu/Desktop/bms.txt", 'w')
    textFile.write(encryptedText)

def combine():
    inp1 = open('/home/vishnu/Desktop/temp', 'r').read()
    inp1 = decrypt(KEY, IV, inp1)
    inp1 = inp1[:inp1.rfind(']') + 1]
    list1 = json.loads(inp1)
    os.remove('/home/vishnu/Desktop/temp')
    print list1
    return list1

def getList():
    return passInfo

def syncComputerToPhone():
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(encrypt(KEY, IV, json.dumps(passInfo)))
    qr.make(fit=True)

    qrimg = qr.make_image()
    qrimg.show()

def syncPhoneToComputer():

    inp = decrypt(KEY, IV, open('/home/vishnu/Desktop/temp', 'r').read())
    inp = inp[:inp.rfind(']')+1]
    os.remove('/home/vishnu/Desktop/temp')
    return json.loads(inp)

def get_lan_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("gmail.com", 80))
    ip = str(s.getsockname()[0])
    s.close()
    return ip

def genKey(hex, password):
    seed = 0
    for i in range(len(password)):
        seed += ord(password[i])

    seed **= 4
    nums = list(str(seed))

    for x in nums:
        pos1 = int(str(x))
        pos2 = int(str(nums[pos1]))
        temp = nums[pos1]
        nums[pos1] = nums[pos2]
        nums[pos2] = temp

    for x in nums:
        pos = int(""+x)
        hex = hex[:pos]+chr(65+pos)+hex[pos:]

    return SHA256.new(hex).hexdigest()[:32]

def genIV(hex, password):
    seed = 0
    for i in range(len(password)):
        seed += ord(password[i])

    seed **= 4
    nums = list(str(seed))

    for x in nums:
        pos1 = int(str(x))
        pos2 = int(str(nums[pos1]))
        temp = nums[pos1]
        nums[pos1] = nums[pos2]
        nums[pos2] = temp

    for x in nums:
        pos = int(""+x)
        hex = hex[:pos]+chr(65+pos)+hex[pos:]

    rawIV = SHA256.new(hex).hexdigest()
    return rawIV[48:]


KEY = genKey(HEXKEY,TEXTKEY)
IV = genIV(HEXKEY,TEXTKEY)

def encrypt(key, iv, plainText):
    aes = AES.new(key, MODE, iv, segment_size=SEGMENT_SIZE)
    plainText = _pad_string(plainText)
    encryptedText = aes.encrypt(plainText)
    return binascii.b2a_hex(encryptedText).rstrip()

def writeEncryptedFile():
    enc = encrypt(KEY,IV,str(passInfo))
    textFile = open("/home/vishnu/Desktop/encryptedList", 'w')
    textFile.write(enc)

def decrypt(key, iv, encryptedText):
    aes = AES.new(key, MODE, iv, segment_size=SEGMENT_SIZE)
    encryptedText_bytes = binascii.a2b_hex(encryptedText)
    dencryptedText = aes.decrypt(encryptedText_bytes)
    dencryptedText = _unpad_string(dencryptedText)
    return dencryptedText


def _pad_string(value):
    length = len(value)
    pad_size = BLOCK_SIZE - (length % BLOCK_SIZE)
    return value.ljust(length + pad_size, '\x00')


def _unpad_string(value):
    while value[-1] == '\x00':
        value = value[:-1]
    return value

def genQR():
    host = get_lan_ip()
    port = 4200
    print "", host, ":", port
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data("" + str(host) + ":" + str(port))
    qr.make(fit=True)

    qrimg = qr.make_image()
    qrimg.show()

passInfo = json.loads(decrypt(KEY, IV, open('/home/vishnu/Desktop/bms.txt','r').read()))

if __name__ == "__main__":
    beginSession()
    writeEncryptedFile()
    textFile = open("/home/vishnu/Desktop/choices", 'w')
    textFile.write('0')
    textFile.close()
    print open("/home/vishnu/Desktop/choices", 'r').read()
    choice = int(open("/home/vishnu/Desktop/choices", 'r').read())
    print "1. Sync to phone\n2. Sync to PC\n3. Combine database\n4. Exit"
    while(choice!=4):
        time.sleep(1)
        choice = int(open("/home/vishnu/Desktop/choices", 'r').read())
        if(choice!=0 and choice!=4):
            if(choice==1):
                syncComputerToPhone()
            elif choice==2 or choice==3:
                genQR()
            elif choice==33:
                passInfo = combine()
                endSession()
                print passInfo
            elif choice==22:
                passInfo = syncPhoneToComputer()
                endSession()
                print passInfo
            textFile = open("/home/vishnu/Desktop/choices", 'w')
            textFile.write("0")
            textFile.close()
            endSession()
    endSession()
    main()