import binascii
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
import json
import qrcode

MODE = AES.MODE_CFB
BLOCK_SIZE = 16
SEGMENT_SIZE = 128
IV = ''
passInfo = [
    ['facebook','herp@derp.com','password'],
    ['pornhub','lenny@face.com','lenny']
]

def beginSession():
    passInfo = json.loads(decrypt(KEY, IV, open('/home/vishnu/Desktop/bms.txt','r').read()))
    print passInfo

def endSession():
    encryptedText = encrypt(KEY, IV, json.dumps(passInfo))
    print encryptedText
    textFile = open("/home/vishnu/Desktop/bms.txt", 'w')
    textFile.write(encryptedText)

def syncComputerToPhone():
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(encrypt(KEY, IV, json.dumps(passInfo)))
    qr.make(fit=True)

    qr.make_image().show()

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

KEY = genKey('#d40909#1aa72c#d40909#0f1de1#fda115#f617c0','Vishnu@123abcdef3841@#')
IV = genIV('#d40909#1aa72c#d40909#0f1de1#fda115#f617c0','Vishnu@123abcdef3841@#')

def encrypt(key, iv, plainText):
    aes = AES.new(key, MODE, iv, segment_size=SEGMENT_SIZE)
    plainText = _pad_string(plainText)
    encryptedText = aes.encrypt(plainText)
    return binascii.b2a_hex(encryptedText).rstrip()


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

beginSession()
syncComputerToPhone()
endSession()
#print KEY