# -*- coding: utf-8 -*-
"""
Created on Sat May 29 16:23:22 2021

@author: a
"""
import random
import pandas as pd
import numpy as np


headings = ['Name', 'Vehicle Type', 'Historical Annualized Returns', 'Volatility', 'Liquidity', 'Lockin Tenure', 'Tax Saving', 'Asset Class', 'Max Drawdown']

liquidities = ['Low', 'Medium', 'High']
vehicleTypes = ['Debt MF', 'Equity MF', 'FD', 'PPF', 'PF', 'Equities']
taxSaving = ['Yes', 'No']
assetClass = ['Debt', 'Equities', 'Commodities']
Names = ['Smallcap MF', 'Bluechip MF', 'FD Bank', 'PPF', 'PF', 'Gilt MF', 'Overnight MF', 'Money Market MF']

df = pd.DataFrame(index = [i for i in range(0,1000)], columns = headings)

for i in df.index:
    rand = random.randint(0,20)
    df.loc[i, 'Name'] = Names[rand%len(Names)] + ' ' + str(random.randint(0, 1000)%1000)
    df.loc[i, 'Vehicle Type'] = vehicleTypes[rand%len(vehicleTypes)]
    df.loc[i, 'Historical Annualized Returns'] = (rand + random.random())/100
    df.loc[i, 'Volatility'] = (random.randint(0, 28)+ random.random())/100
    df.loc[i, 'Liquidity'] = liquidities[rand%len(liquidities)]
    df.loc[i, 'Lockin Tenure'] = random.randint(0, 10)
    df.loc[i, 'Tax Saving'] = taxSaving[rand%len(taxSaving)]
    df.loc[i, 'Asset Class'] = assetClass[rand%len(assetClass)]
    df.loc[i, 'Max Drawdown'] = (random.randint(30, 55)+random.random())/100
    
    
goal = goalDf.loc[:'Bike']
vol = goal.loc['Bike','Allowed Risk']
liquidity = goal.loc['Bike','Liquidity']
tenure = goal.loc['Bike', 'Tenure']
amountNeeded = goal.loc['Bike', 'Amount Needed']
maxInvestment = goal.loc['Bike','Monthly Max Investment']


listDf_liquidityFiltered = df[df['Liquidity']==liquidity]
listDf = listDf_liquidityFiltered[listDf_liquidityFiltered['Volatility']<=vol]
##listDf_tenureFiltered = listDf_volFiltered[df['Liquidity']==liquidity]
listDf.insert(len(listDf.columns), 'Investment Amount Needed', [np.nan for i in listDf.index])
listDf.insert(len(listDf.columns), 'Goal Achievable in years', [np.nan for i in listDf.index])
listDf.insert(len(listDf.columns), 'Risk Adjusted', [np.nan for i in listDf.index])
listDf.insert(len(listDf.columns), 'Sharpe Ratio', [np.nan for i in listDf.index])


for i in listDf.index:
    expectedReturns = listDf.loc[i, 'Historical Annualized Returns']
    monthlyInvestmentNeeded  = np.pmt(expectedReturns/12.0, tenure*12, 0, amountNeeded, 'end')
    listDf.loc[i, 'Investment Amount Needed'] = monthlyInvestmentNeeded*-1.
    listDf.loc[i, 'Risk Adjusted'] = monthlyInvestmentNeeded*-1. * listDf.loc[i,'Volatility']
    listDf.loc[i, 'Sharpe Ratio'] = expectedReturns / listDf.loc[i,'Volatility']
    for years in range(1,tenure*12):
        futureValue = np.fv(expectedReturns/12.0, years, -1*maxInvestment, 0)
        if futureValue >= amountNeeded:
            listDf.loc[i,'Goal Achievable in years'] = years/12.0
            break
        
listDf = listDf.sort_values(by = ['Sharpe Ratio'], ascending = False)



from scipy import optimize
import math
def optimalWeights(cov, expectedReturns, volThreshold):
    weights = np.ones(len(cov))/len(cov)
    weights_bound = [(0,1) for i in range(len(cov))]
    w_constraint = {'type': 'eq', 'fun': lambda weights: sum(weights) - 1.0}
    var_constraint = {'type': 'eq', 'fun': lambda weights: math.sqrt(weights.dot(cov.dot(weights.T))*252) - volThreshold}
    returns = lambda weights: -1* expectedReturns.dot(weights.T)*252.
    
    
    optimal_w = optimize.minimize(returns, weights.flatten(), method = 'SLSQP', constraints = [w_constraint, var_constraint],  bounds = weights_bound)
    return optimal_w




















    
    