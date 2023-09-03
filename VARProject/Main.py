import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
import datetime
import numpy as np 
import Var as vt

#import data as a dataframe
#VAR_data = pd.read_csv('/Users/Zack admin/Documents/VisualStudio/SummerProjects/VARProject/historical_VAR_stock_data.csv', index_col=0)

import yfinance as yf
import Calculation as CAL
import Sql as SQL


if __name__ == "__main__":
    sql_obj = SQL.SqlFunc() #sql object from class sqlfunc
    portfolio_name = 'Zach'
    var_obj = vt.Var(sql_obj, portfolio_name)
    var_obj.generatevar('2022-01-01')




    

