import htmlPy, crypt, cgi

class Cryptonite(htmlPy.object):
    def __init__(self):
        super(Cryptonite, self).__init__()
        crypt.passInfo = self.passInfo

    @htmlPy.Slot()
    def fill_table(self):
