# -*- coding: utf-8 -*-
"""
Created on Sat May 29 16:23:22 2021

@author: a
"""
import random
import pandas as pd
import numpy as np
import datetime as dt
from scipy import optimize
import math
import numpy_financial as npf
# import module
from mftool import Mftool
from pyxirr import xirr




class goalBased():
    def __init__(self, volThreshold, tenure, amountNeeded, maxInvestment):
        self.projectName = 'LYPH DataFrame'
        self.volThreshold = volThreshold
        self.liquidity = 'High' #goal.loc['Bike','Liquidity']
        self.tenure = tenure #goal.loc['Bike', 'Tenure']
        self.amountNeeded = amountNeeded #goal.loc['Bike', 'Amount Needed']
        self.maxInvestment = maxInvestment
        self.mf = Mftool()
        
    def createDummyDataFrame(self):
        headings = ['Name', 'Vehicle Type', 'Historical Annualized Returns', 'Volatility', 'Liquidity', 'Lockin Tenure', 'Tax Saving', 'Asset Class', 'Max Drawdown']
        
        liquidities = ['Low', 'Medium', 'High']
        vehicleTypes = ['Debt MF', 'Equity MF', 'FD', 'PPF', 'PF', 'Equities']
        taxSaving = ['Yes', 'No']
        assetClass = ['Debt', 'Equities', 'Commodities']
        Names = ['Smallcap MF', 'Bluechip MF', 'FD Bank', 'PPF', 'PF', 'Gilt MF', 'Overnight MF', 'Money Market MF']
        
        df = pd.DataFrame(index = [i for i in range(0,1000)], columns = headings)
        np.random.seed(123)
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
            
        return df
            
    
    def fetchTimeseriesData(self, instrumentID):
        data = self.mf.get_scheme_historical_nav(instrumentID)
        df = pd.DataFrame(data['data'])
        dates=[dt.datetime.strptime(x, '%d-%m-%Y').date() for x in df['date'].values]
        nav = [float(x) for x in df['nav'].values]
        df['date'] = dates
        df['nav'] = nav
        df = df.sort_values(by=['date'])
        return df
        
    
    def returnsOfInstrument(self, instrumentID):
        df =self.fetchTimeseriesData(instrumentID)
        df_1 = df.shift(1)
        returns = np.array(df['nav']/df_1['nav'] - 1)
        df['Returns'] = returns
        return df
    
    def cagrMF(self, instrumentID):
        df =self.returnsOfInstrument(instrumentID).dropna()
        df = df[df['date']>= dt.date(2015,1,1)]
        if len(df) !=0 and df['date'].values[-1] >= dt.date(2021,8,1) and df['date'].values[0] <= dt.date(2018,1,1):
            vol = df.dropna()['Returns'].std() * math.sqrt(252)
            cagr = xirr([df['date'].values[0], df['date'].values[-1]], [-1* df['nav'].values[0], df['nav'].values[-1]])
        else:
            vol = np.nan
            cagr = np.nan
        return (cagr,vol)
    
    def mfInfo(self, instrumentID):
        details = self.mf.get_scheme_details(instrumentID)
        scheme_type = details['scheme_type']
        if 'Close Ended' not in scheme_type:
            mfType = 'Debt MF' if 'Debt' in details['scheme_category'] else 'Equity MF'
            cagr, vol = self.cagrMF(instrumentID)
            
        else:
            mfType, cagr, vol = (np.nan, np.nan, np.nan)
        name = details['scheme_name']
        return (name, mfType, cagr, vol)
    
    def createDf(self):
        listDf = pd.read_excel(r'C:\Users\hemes\OneDrive\LYPH\MF_AdityaBirla.xlsx')
        df = pd.DataFrame(index = listDf['Code'].values, columns = ['Name', 'Asset Class', 'CAGR', 'Volatility'])
        df['Name'] = listDf['Name'].values
        for instrumentID in df.index:
            name, mfType, cagr, vol = self.mfInfo(instrumentID)
            df.loc[instrumentID, 'Name'] = name
            df.loc[instrumentID, 'Asset Class'] = mfType
            df.loc[instrumentID, 'CAGR'] = cagr
            df.loc[instrumentID, 'Volatility'] = vol
        return df
        
    def resultsFiltering(self):
    #goal = goalDf.loc[:'Bike']
        import pandas as pd
        df = pd.read_excel(r'C:\Users\hemes\OneDrive\LYPH\MF_AdityaBirla_stats.xlsx')#self.createDummyDataFrame()
        vol = self.volThreshold# goal.loc['Bike','Allowed Risk']
        liquidity = self.liquidity#goal.loc['Bike','Liquidity']
        tenure = self.tenure#goal.loc['Bike', 'Tenure']
        amountNeeded = self.amountNeeded #goal.loc['Bike', 'Amount Needed']
        maxInvestment = self.maxInvestment #goal.loc['Bike','Monthly Max Investment']
        
        
        #listDf_liquidityFiltered = df[df['Liquidity']==liquidity]
        listDf = df#listDf_liquidityFiltered
        #listDf = listDf_liquidityFiltered[listDf_liquidityFiltered['Volatility']<=vol]
        ##listDf_tenureFiltered = listDf_volFiltered[df['Liquidity']==liquidity]
        listDf.insert(len(listDf.columns), 'Investment Amount Needed', [np.nan for i in listDf.index])
        listDf.insert(len(listDf.columns), 'Goal Achievable in years', [np.nan for i in listDf.index])
        listDf.insert(len(listDf.columns), 'Risk Adjusted', [np.nan for i in listDf.index])
        listDf.insert(len(listDf.columns), 'Sharpe Ratio', [np.nan for i in listDf.index])
        
        np.random.seed(123)
        for i in listDf.index:
            expectedReturns = listDf.loc[i, 'CAGR']
            monthlyInvestmentNeeded  = npf.pmt(expectedReturns/12.0, tenure*12, 0, amountNeeded, 'end')
            listDf.loc[i, 'Investment Amount Needed'] = monthlyInvestmentNeeded*-1.
            listDf.loc[i, 'Risk Adjusted'] = monthlyInvestmentNeeded*-1. * listDf.loc[i,'Volatility']
            listDf.loc[i, 'Sharpe Ratio'] = expectedReturns / listDf.loc[i,'Volatility']
            for years in range(1,int(tenure)):
                futureValue = npf.fv(expectedReturns/12.0, years, -1*maxInvestment, 0)
                if futureValue >= amountNeeded:
                    listDf.loc[i,'Goal Achievable in years'] = years/12.0
                    break

        listDf = listDf[listDf['Investment Amount Needed']<= self.maxInvestment]
                
        listDf = listDf.sort_values(by = ['Sharpe Ratio'], ascending = False)
        debtDf = listDf[listDf['Asset Class'] == 'Debt MF'].sort_values(by = ['Sharpe Ratio'], ascending = False)[0:3]        
        equityDf = listDf[listDf['Asset Class'] == 'Equity MF'].sort_values(by = ['Sharpe Ratio'], ascending = False)[0:3]
        import pandas as pd
        finalDf = pd.concat([equityDf, debtDf])
        #commodityDf = listDf[listDf['Asset Class'] == 'Commodities']
        return finalDf
        

    def optimalWeights(self, cov, expectedReturns, volThreshold):
        weights = np.ones(len(cov))/len(cov)
        weights_bound = [(0,1) for i in range(len(cov))]
        w_constraint = {'type': 'eq', 'fun': lambda weights: sum(weights) - 1.0}
        var_constraint = {'type': 'eq', 'fun': lambda weights: math.sqrt(weights.dot(cov.dot(weights.T))*252) - volThreshold}
        returns = lambda weights: -1* expectedReturns.dot(weights.T)*252.
        
        
        optimal_w = optimize.minimize(returns, weights.flatten(), method = 'SLSQP', constraints = [w_constraint, var_constraint],  bounds = weights_bound)
        return np.array(optimal_w.x)



    def finalWeights(self):
        startDate = dt.date(2018,1,2)
        #endDate = dt.date.today()
        #dates=[]
        #date = startDate
        #while date<=endDate:
        #    dates.append(date)
        #    date = date+dt.timedelta(1)
        shortlistedDf = self.resultsFiltering()
        securitiesName = np.array(shortlistedDf['Name'])
        securitiesCode = np.array(shortlistedDf['Code'])
        shortlistedDf.index= securitiesName
        cagr = np.array(shortlistedDf['CAGR'])
        
        
        timeseries = self.returnsOfInstrument(securitiesCode[0])
        timeseries.index = timeseries['date'].values
        df = pd.DataFrame(columns = securitiesCode, index = timeseries[timeseries['date']>=startDate].index)
        for code in securitiesCode:
            timeseries = self.returnsOfInstrument(code)
            timeseries.index = timeseries['date']
            returns = timeseries[timeseries['date']>=startDate]['Returns']
            for i in returns.index:
                df.loc[i,code] = float(returns.loc[i,])

        df  = df.dropna()  
        cov = df.astype(float).cov()
        expectedCagr = np.array([((1+x)**(1/252) - 1)  for x in cagr])
        meanReturnsLast2Years = np.array(df.mean())
        expectedReturns = (expectedCagr*1.0+meanReturnsLast2Years*0.0)
        weights = self.optimalWeights(cov, expectedReturns, self.volThreshold)
        expectedPortflioReturns = expectedReturns.dot(weights)
        monthlyInvestmentNeeded  = npf.pmt(expectedPortflioReturns*22, self.tenure*12, 0, self.amountNeeded, 'end')
        
        
        
        allocationDf = pd.DataFrame(weights,index = securitiesName, columns = ['Weights'])
        
        for num, name in enumerate(securitiesName):
            allocationDf.loc[name, 'InvestmentAmount'] = -1*weights[num]* monthlyInvestmentNeeded      
        
        portfolioRisk = math.sqrt(weights.dot(cov.dot(weights.T))*252)
        return [allocationDf[abs(allocationDf['Weights'])>1e-5].drop(['Weights'],axis=1), portfolioRisk]
        
            
        

















    
    