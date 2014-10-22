import utils

class Slave(object):
    def __init__(self, name):
        self.name = name
        self.machine = utils.config.get(name, 'machine')
