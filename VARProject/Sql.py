import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
from datetime import date
from datetime import datetime
import numpy as np 

import yfinance as yf

class SqlFunc:
    #def __init__(self, connection):
       # self.conn = connection  

    def __init__(self, host = "localhost", user = "root", password = "SqlPassword1!", database = "var"):
        
        self.conn = msql.connect(
            host= host,
            user= user,
            password= password,
            database= database
        )  
    def __del__(self):
        self.conn.close()

    def getSecurityID(self, symbol):
        cursor = self.conn.cursor()
        query1 = "select ID from security where symbol = %s" #securityID from symbol
        cursor.execute(query1, (symbol,))
        data = cursor.fetchall()
        cursor.close()  
        return data[0][0]

    def getSecuritySymbol(self, securityID):
        cursor = self.conn.cursor()
        query1 = "select symbol from security where ID = %s" #securityID from symbol
        cursor.execute(query1, (securityID,))
        data = cursor.fetchall()
        cursor.close()  
        return data[0][0]


    def getPortfolioID(self, name): 
        cursor = self.conn.cursor()
        query1 = "select ID from portfolio where name = %s" #securityID from symbol
        cursor.execute(query1, (name,))
        data = cursor.fetchall()
        cursor.close()  
        return data[0][0]

    def getPortfolioData(self, portfolioID): 
        cursor = self.conn.cursor()
        query1 = "select portfolioID, securityID, quantity from portfoliodata where portfolioID = %s" #securityID from symbol
        cursor.execute(query1, (portfolioID,))
        data = cursor.fetchall()
        cursor.close()  
        return data

    def getDatafromDB(self, security_ID, start_date, end_date):
        cursor = self.conn.cursor()
        query1 = "select Date, Open, High, Low, CLose, Volume from data where securityID = %s and date >= %s and date <= %s" #securityID from symbol
        cursor.execute(query1, (security_ID, start_date, end_date ))
        data = cursor.fetchall()
        cursor.close() 
        # Column names for dataframe
        columns = ['Date', 'Open', 'High', 'Low', 'Close', 'Volume']
        # Create a DataFrame with column names
        data = pd.DataFrame(data, columns=columns)
        print(data)
        return data        

    def insertdata(self, historical_data, securityID):
        cursor = self.conn.cursor()
        #securityID = self.getSecurityID(symbol)
        # Save data to the database
        print(historical_data)
        for index, row in historical_data.iterrows():
            print(type(index))
            #print(index, row)
            print(row[0])
            date = row[0].strftime('%Y-%m-%d')
            #date = row['Date'].strftime('%Y-%m-%d')
            open_price = row['Open']
            high = row['High']
            low = row['Low']
            close = row['Close']
            volume = row['Volume']

            query = "INSERT IGNORE INTO data (securityID,date,open,high,low,close,volume) " \
                    "VALUES (%s, %s, %s, %s, %s, %s, %s)"
            values = (securityID, date, open_price, high, low, close, volume)
            cursor.execute(query, values)

        print("Data Inserted....")
        # Commit changes and close the connection
        self.conn.commit()

    def insertreturndata(self, returns, securityID):

        cursor = self.conn.cursor()

        # Save data to the database
        for index, row in returns.iterrows():
            date = row[0].strftime('%Y-%m-%d')
            Daily_return = row['Daily_Return']

            query = "INSERT INTO returndata (securityID, date, Daily_return) " \
                    "VALUES (%s, %s, %s)"
            values = (securityID, date, Daily_return)
            cursor.execute(query, values)

        print("Data Inserted....")
        # Commit changes and close the connection
        self.conn.commit()

        
    def insertVaRdata(self, returns, symbol):
        
        cursor = self.conn.cursor()

        # Save data to the database
        for index, row in returns.iterrows():
            date = index.strftime('%Y-%m-%d')
            Daily_return = row['Daily_Return']
            VaR = row['VaR']

            query = "INSERT INTO VaR_data (date, symbol, Daily_return, VaR) " \
                    "VALUES (%s, %s, %s, %s)"
            values = (date, symbol, Daily_return, VaR)
            cursor.execute(query, values)

        print("Data Inserted....")
        # Commit changes and close the connection
        self.conn.commit()

    def retrievedata(self, securityID): #retrieve historical data from a securityID
        try:

            # Create a cursor to execute SQL queries
            cursor = self.conn.cursor()
            # Define the SELECT query
            select_query = "SELECT securityID, date, open, high, low, close, volume FROM data where securityID = %s"\
            # Execute the SELECT query
            cursor.execute(select_query, (securityID,))
            # Fetch all rows of data
            data = cursor.fetchall()
            # Close the cursor and database connection
            print("Data returned....")
            cursor.close()
            return data

        except Exception as e:
            print(f"Error retrieving data: {e}")
            return None

    def retrievePortfoliodata(self):
        try:

            # Create a cursor to execute SQL queries
            cursor = self.conn.cursor()
            # Define the SELECT query
            select_query = "SELECT quantity FROM Portfolio_data"\
            # Execute the SELECT query
            cursor.execute(select_query)
            # Fetch all rows of data
            data = cursor.fetchall()

            converted_value = float(data[0][0]) #convert from tuple to varchar
            return converted_value
            # Close the cursor and database connection
            print("Data returned....")
            cursor.close()
            

        except Exception as e:
            print(f"Error retrieving data: {e}")
            return None

    def insertPortfoliodata(self, symbol, quantity):

        cursor = self.conn.cursor()
        query = "INSERT INTO Portfolio_data (symbol, quantity) " \
                    "VALUES (%s, %s)"
        values = (symbol, quantity)
        cursor.execute(query, values)

        print("Portfolio Stock Data Inserted....")
        # Commit changes and close the connection
        self.conn.commit()



