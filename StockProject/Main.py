import pandas as pd
import mysql.connector as msql
from mysql.connector import Error

#import data as a dataframe
empdata = pd.read_csv('/Users/Zack admin/Documents/VisualStudio/SummerProjects/StockProject/historical_stock_data.csv', index_col=0)


#create table 
try:
    conn = msql.connect(host='localhost', database='test', user='root', password='No1CanGuess!')
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)
        cursor.execute('DROP TABLE IF EXISTS test_data;')
        print('Creating table....')
# in the below line please pass the create table statement which you want #to create ERROR HERE
        cursor.execute("CREATE TABLE test_data(date DATE,open DECIMAL(10, 2),high DECIMAL(10, 2),low DECIMAL(10, 2),close DECIMAL(10, 2),volume DECIMAL(20, 4),dividends DECIMAL(10, 2),stocksplits DECIMAL(10, 2),symbol VARCHAR(255))")
        print("Table is created....")
        #loop through the data frame
        for i,row in empdata.iterrows():
            #here %S means string values 
            sql = "INSERT INTO test.test_data VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(sql, tuple(row))
            print("Record inserted")
            # the connection is not auto committed by default, so we must commit to save our changes
            conn.commit()
except Error as e:
            print("Error while connecting to MySQL", e)


# Execute query
sql = "SELECT * FROM employee.employee_data"
cursor.execute(sql)
# Fetch all the records
result = cursor.fetchall()
for i in result:
    print(i)



def main():
    get_historical_stock_data('A', 11/23/2000, 11/25,2009)
    return "Finished"


