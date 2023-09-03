import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
from datetime import datetime
from datetime import date
import numpy as np 
import Sql as SQL
import Calculation as CAL

class Var:

    def __init__(self, sql_obj, portfolio_name):
        self.sql_obj = sql_obj
        self.portfolio_name = portfolio_name

    def getData(self, security_ID, start_date, end_date): #from database
        analytics_obj = CAL.Analytics() #analytics object from class analytics
        data = self.sql_obj.getDatafromDB(security_ID, start_date, end_date)
        symbol = self.sql_obj.getSecuritySymbol(security_ID)
        if len(data) == 0: #dataset empty
            historical_data = analytics_obj.get_historical_price_data(symbol, start_date, end_date)
            self.sql_obj.insertdata(historical_data, security_ID)
            data = self.sql_obj.getDatafromDB(security_ID, start_date, end_date)
        else:
            datadate = data['Date'].iloc[-1]
            date_format = "%Y-%m-%d"
            #date_dt = datadate.date()
            end_date_dt = datetime.strptime(end_date, date_format).date() #convert to datetime to do comparison
            if datadate < end_date_dt:
                historical_data = analytics_obj.get_historical_price_data(symbol, datadate, end_date)
                self.sql_obj.insertdata(historical_data, security_ID)
                data = self.sql_obj.getDatafromDB(security_ID, start_date, end_date)
        
        #historical_data = pd.DataFrame(data)
        # Convert 'date_column' from object to datetime

        return data
          

    def processportfoliodata(self, start_date, end_date, portfolio_data):
        analytics_obj = CAL.Analytics() #analytics object from class analytics

        results = {}  # Create an empty dictionary to store results

        for row in portfolio_data: #iterate through each row in portfolio_data
            security_ID = row[1]
            stock_quantity = int(row[2])

            symbol = self.sql_obj.getSecuritySymbol(security_ID)

            historical_data = self.getData(security_ID, start_date, end_date) #get historical data of a symbol from a specific range of dates

            if historical_data is not None:
                print(historical_data) #print historical data if exists

            #security_ID = Sql_obj.getSecurityID(ticker_symbol)
            #self.sql_obj.insertdata(historical_data, security_ID) #insert data from historical_data into data table 
            #retrieved_data = self.sql_obj.retrievedata(security_ID) #format not the same as a DF

            latest_close_price = analytics_obj.retrieveCurrentStockPrice(historical_data) #get latest stock price
            num_shares = stock_quantity #get num of shares from Portfolio 
            security_value = num_shares * latest_close_price #get npv value

            returns = analytics_obj.calculatereturn(historical_data, security_value) #get returns and p&l for historical data
            print(returns)
            results[security_ID] = returns #contain results dataframe for each security ID

            self.sql_obj.insertreturndata(returns, security_ID) #insert data from historical_data into test_return_data
 
            security_var = analytics_obj.calculateVaR2(security_value, returns, 0.02) #calculate VaR
            print("security symbol= ", symbol, "npv = ", security_value, "Security VaR = ", security_var) #VaR for every stock      

        Var = analytics_obj.calculateTotalVaR(start_date, end_date, security_value, results, 0.02) #calculate VaR
        print(Var)
        return(Var)
 


    def generatevar(self, start_date, end_date = None):
        # Replace 'AAPL' with the ticker symbol of the stock you want to fetch data for
        #ticker_symbol = 'AAPL'
        start_date = start_date

        if(end_date is None):
            today = date.today()
            #current_date = datetime.datetime.now().date()
            end_date = today.strftime('%Y-%m-%d')   #current end date

        portfolio_ID = self.sql_obj.getPortfolioID(self.portfolio_name)
        portfolio_data = self.sql_obj.getPortfolioData(portfolio_ID)

        self.processportfoliodata(start_date, end_date, portfolio_data)

    
