# -*- coding: utf-8 -*-
"""
Created on Fri Aug 20 18:29:08 2021

@author: hemes
"""

from wordcloud import WordCloud, STOPWORDS
import matplotlib.pyplot as plt
import pandas as pd
import json

data=[]
for val in df['messages'].values:
    
    if len(val['text'])!=0:
        if isinstance(val['text'][-1], dict):
            string = val['text'][-1]['text']
            message = string
        else:
            string = val['text'][-1]
            if 'wrote:' in string:
                message = string.split('wrote:')[-1]
            else:
                message = string
    else:
        message = ''
        
    data.append(message)