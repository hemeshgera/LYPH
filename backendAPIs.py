# -*- coding: utf-8 -*-
"""
Created on Sat May 22 19:13:39 2021

@author: a
"""
from flask import Flask, jsonify
from dummyData import goalBased
import numpy as np
import pandas as pd

app = Flask(__name__)







@app.route('/goalBasedPage/<volThreshold>/<tenure>/<amount>/<maxInvestment>', methods = ['GET'])
def goalBasedPage(volThreshold, tenure, amount, maxInvestment):
    
    idx = goalBased(float(volThreshold), float(tenure), float(amount), float(maxInvestment))
    df = pd.read_excel(r'C:\Users\hemes\OneDrive\LYPH\MF_AdityaBirla_stats.xlsx')
    weights  = idx.finalWeights()
    names = np.array(weights[0].index)
    
    indexDict = {'Overall': {'Total Monthly Amount': weights[0].sum()['InvestmentAmount']}}
    for name in names:
        dictData = {
                        'Name': name,
                        'Investment Amount': weights[0].loc[name,'InvestmentAmount'],
                        'Asset Class': df[df['Name'] == name]['Asset Class'].values[0],
                        'Historical Returns': df[df['Name'] == name]['CAGR'].values[0],

                   }
        indexDict[name] = dictData
    return jsonify(indexDict), 200






app.run(host = 'localhost', port = 5000)