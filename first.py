import datetime as dt
from flask import Flask, jsonify
import hashlib
import json
from collections import OrderedDict
class Blockchain:
    def __init__(self):
        self.chain = []
        self.create_block(proof = 1, prevHash='0')


    def create_block(self, proof, prevHash):
        block = {
                    'Index': len(self.chain)+1,
                    'Timestamp': str(dt.datetime.now()),
                    'proof': proof,
                    'prevHash': prevHash,
                }
        self.chain.append(block)

        return block
    
    def getPrevBlock(self):
        return self.chain[-1]
    
    def proofOfWork(self, prevProof):
        newProof = 1
        checkProof = False
        while not checkProof:
            hashOperation = hashlib.sha256(str(newProof**2 - prevProof**2).encode()).hexdigest()
            if hashOperation[:4] == '0000':
                checkProof = True
            else:
                newProof += 1
        
        return newProof
    
    def hash(self, block):
        encodedBlock = json.dumps(block, sort_keys = True).encode()
        return hashlib.sha256(encodedBlock).hexdigest()
    
    def validityCheck(self, chain):
        prevBlock = chain[0]
        index = 1
        while index<len(chain):
            block = chain[index]
            if block['prevHash'] != self.hash(prevBlock):
                return (False, 'Hash does not match for block ' + str(block['Index']))
            prevProof = prevBlock['proof']
            currentProof = block['proof']
            hashValue = hashlib.sha256(str(currentProof**2 - prevProof**2).encode()).hexdigest()
            if hashValue[:4] != '0000':
                return (False, 'Proof does not validate for block ' + str(block['Index']))
            prevBlock = block
            index += 1
            
        return (True, 'Blockchain is Valid')
                
    
    
