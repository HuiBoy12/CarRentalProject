import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
from datetime import date
from datetime import datetime
import numpy as np 
from decimal import Decimal


import yfinance as yf
import Sql as SQL

class Analytics:
    
    def get_historical_price_data(self, ticker_symbol, start_date, end_date):
        try:
            # Fetch historical data from Yahoo Finance
            stock_data = yf.download(ticker_symbol, start=start_date, end=end_date).reset_index()
            print(stock_data)
            return stock_data
        except Exception as e:
            print(f"Error fetching data for {ticker_symbol}: {e}")
            return None

    def calculatereturn(self, historical_data, npv):
        try:
            #print(historical_data)
            # Calculate daily returns
            historical_data['Daily_Return'] = historical_data['Close'].pct_change()
            # Replace NaN with 0
            historical_data['Daily_Return'].fillna(0, inplace=True)
            print(historical_data)
            #calculate daily p&l
            historical_data['DailyPL'] = historical_data['Daily_Return'] * npv
            print("Return calculated...")
            return historical_data

        except Exception as e:
            print(f"Error calculating returns: {e}")
            return None

    def calculateVaR(self, returns, start_date, end_date, confidence_level):
        try:

            # Calculate log returns
            returns['log_returns'] = np.log(1 + returns['Daily_Return'])
            # Calculate volatility 
            volatility = returns['Daily_Return'].std()
            #calculate time length
            start_date_format = datetime.strptime(start_date, '%Y-%m-%d')
            end_date_format = datetime.strptime(end_date, '%Y-%m-%d')
            duration = end_date_format - start_date_format
            num_days = duration.days
            num_years = num_days / 365.25
            time_length = num_years
            #VaR Calculation
            VaR = -1 * np.sqrt(time_length) * volatility * np.quantile(returns['log_returns'], confidence_level)
            print("VaR calculated...")
            returns['Var'] = VaR #currently set to that all values between start and end date have VaR value 
            return returns

        except Exception as e:
            print(f"Error calculating VaR: {e}")
            return None


    def calculateVaR2(self, portfolio_value, returns, confidence_level):
        try:
            sorted_df = returns.sort_values(by='Daily_Return', ascending=True)
            print(sorted_df)

            #calculate time length
            # start_date_format = datetime.strptime(start_date, '%Y-%m-%d')
            # end_date_format = datetime.strptime(end_date, '%Y-%m-%d')
            # duration = end_date_format - start_date_format
            # num_days = duration.days
            # num_years = num_days / 365.25
            # #time_length = num_years
            # VaR Calculation
            confidence_level_dec = Decimal(confidence_level)
            quantile_point = np.quantile(sorted_df['Daily_Return'], confidence_level_dec)
            print(quantile_point)
            var = quantile_point * portfolio_value
            print("VaR calculated...")
            #returns['Var'] = VaR #currently set to that all values between start and end date have VaR value 
            return var

        except Exception as e:
            print(f"Error calculating VaR: {e}")
            return None

    def calculateTotalVaR(self, start_date, end_date, portfolio_value, pldata, confidence_level):

        # Create a date range
        date_range = pd.date_range(start=start_date, end=end_date, freq='D')
        # Create the DataFrame
        total_df = pd.DataFrame({'Date': date_range})
        # Convert datetime64[ns] to datetime.date
        total_df['Date'] = total_df['Date'].dt.date
        print(type(total_df['Date'].iloc[0]))

        total_df['TotalPL'] = 0
        total_df['DailyPL'] = 0
        #print(total_df)
        selected_columns = ['Date', 'DailyPL']

        for security_df in pldata.values(): #security value = key values = dataframe
            #security_df = security_df.reset_index()
            pl_df = security_df[selected_columns]
            total_date = total_df['Date']
            pl_date = pl_df['Date']
            print(total_date)
            print(pl_date)
            merged_df = pd.merge(total_df, pl_df, on='Date')
            merged_df['TotalPL'] =  merged_df['TotalPL'] + merged_df['DailyPL_y']        
            merged_df.rename(columns={'DailyPL_y': 'DailyPL'}, inplace=True)
            merged_df.drop(columns=['DailyPL_x'], inplace=True)
            total_df = merged_df

            #addition done here into total_df
        confidence_level_dec = Decimal(confidence_level)
        total_VaR = np.quantile(total_df['TotalPL'], confidence_level_dec) 
        #print(total_VaR)
        return total_VaR


    def retrieveCurrentStockPrice(self, returns):
        try:
            #Get end date stock price
            print(returns)
            latest_close_price = returns.iloc[-1]['Close']
            print(type(latest_close_price))
            return latest_close_price

        except Exception as e:
            print(f"Error calculating currentstockprice: {e}")
            return None

