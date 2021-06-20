# -*- coding: utf-8 -*-
"""
Created on Sat May 22 19:13:39 2021

@author: a
"""
from flask import Flask, jsonify
from first import Blockchain

app = Flask(__name__)
blockchain = Blockchain()


@app.route('/mineBlock', methods = ['GET'])
def mineBlock():
    prevBlock = blockchain.getPrevBlock()
    prevProof = prevBlock['proof']
    proof = blockchain.proofOfWork(prevProof)
    prevHash = blockchain.hash(prevBlock)
    block = blockchain.create_block(proof, prevHash)
    
    indexDict = {
                    'message': 'Block mined',
                    'index': block['Index'],
                    'timestamp': block['Timestamp'],
                    'proof': block['proof'],
                    'prevHash': block['prevHash'],
                }
    return jsonify(indexDict), 200



@app.route('/getChain', methods = ['GET'])
def getChain():
    response = {
                    'Chain': blockchain.chain,
                    'Length of Chain': len(blockchain.chain),
                }
    return jsonify(response), 200
    
    
@app.route('/isValid', methods = ['GET'])
def isValid():
    return jsonify(blockchain.validityCheck(blockchain.chain)[1]), 200
    
    


app.run(host = '0.0.0.0', port = 5000)