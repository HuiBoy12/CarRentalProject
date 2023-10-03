import yfinance as yf
import pandas as pd
import pytz

def get_historical_stock_data(symbols, start_date, end_date):
    data = {}
    
    for symbol in symbols:
        # Fetch the stock data from Yahoo Finance
        stock = yf.Ticker(symbol)
        stock_data = stock.history(start=start_date, end=end_date)

        # Store the data in a dictionary
        data[symbol] = stock_data

    return data

def get_historical_stock_data2(symbols, start_date, end_date):
    data = pd.DataFrame()
    
    for symbol in symbols:
        # Fetch the stock data from Yahoo Finance
        stock = yf.Ticker(symbol)
        stock_data = stock.history(start=start_date, end=end_date)

        # Add a symbol column to the stock_data dataframe
        stock_data['Symbol'] = symbol

        # Concatenate the stock_data dataframe with the existing data
        data = pd.concat([data, stock_data])

    return data

def save_to_csv(data, file_path):
    with pd.ExcelWriter(file_path) as writer:
        for symbol, stock_data in data.items():
            stock_data.to_excel(writer, sheet_name=symbol)

    print(f'Stock data saved to {file_path}.')

# Set the stock symbols, start date, and end date
symbols = ['AAPL', 'GOOGL', 'MSFT', 'AMZN']
start_date = '2020-01-01'
end_date = '2023-06-01'

# Get the historical stock data
historical_data = get_historical_stock_data2(symbols, start_date, end_date)
stock_historical_data = pd.DataFrame(historical_data)
print(stock_historical_data)
print("Data collected:")

#reset indices
df = stock_historical_data.reset_index()

# Convert datetime column to a specific timezone and then remove timezone information
timezone = 'America/New_York'
df['Date'] = pd.to_datetime(df['Date']).dt.tz_localize(None)

print(df)

# Save the data to a CSV file
df.to_csv(path_or_buf='/Users/Zack admin/Documents/VisualStudio/SummerProjects/StockProject/historical_stock_data.csv') # relative position


# Export DataFrame to Excel
#output_file = 'data.xlsx'
#df.to_excel(output_file, index=False)

# Save the data to a CSV file
#csv_file_path = 'C:\Users\Zack admin\Documents\VisualStudio\SummerProjects\StockProject\historical_stock_data.xlsx'
#csv_file_path = '/Users/Zack admin/Documents/VisualStudio/SummerProjects/StockProject/historical_stock_data.xlsx'
#csv_file_path = '/StockProject\historical_stock_data.xlsx'
#save_to_csv(df, csv_file_path)
print("Data converted to CSV file:")