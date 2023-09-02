import mysql.connector as msql
from mysql.connector import Error
from datetime import date
from datetime import datetime



class SqlFunc:
    #def __init__(self, connection):
       # self.conn = connection  

    def __init__(self, host = "localhost", user = "root", password = "SqlPassword1!", database = "carmanagement"):
        
        self.db_conn = msql.connect(
            host= host,
            user= user,
            password= password,
            database= database
        )  
    def __del__(self):
        self.db_conn.close()


    def is_available(self, vehicle_type, hire_date, return_date): #check if car is avaliable
        #Query vehicle inventory table to see if car is avaliable
        cursor = self.db_conn.cursor()

        select_query = """
        SELECT vi.count, vi.typeid from vehicleinventory vi, vehicletype vt where vi.typeid = vt.ID and vt.type = %s
        """
        cursor.execute(select_query, (vehicle_type,))
         # Fetch all rows of data
        data = cursor.fetchall()
        count = data[0][0] #count
        typeID = data[0][1] #typeID

        if count < 1:
            return False

        new_count = count - 1 #update count
        self.updateInventory(typeID, new_count)

        #update count in database
        cursor.close()
        return True #result contain two true/false and cost of vehicle

    def get_cost(self, vehicle_type):
        cursor = self.db_conn.cursor()

        select_query = """
        SELECT DailyCost from vehicletype where Type = %s
        """
        cursor.execute(select_query, (vehicle_type,))
         # Fetch all rows of data
        data = cursor.fetchall()
        cursor.close()  
        return data     

    def updateInventory(self, typeID, new_count):
        cursor = self.db_conn.cursor()

        update_query = """     
        update vehicleinventory set count = %s where typeid = %s
        """
        cursor.execute(update_query, (typeID, new_count))
        cursor.close()
        return
  
    def get_vehicle_typeID(self, vehicle_type):
        cursor = self.db_conn.cursor()

        select_query = """
        SELECT ID from vehicletype where Type = %s
        """
        cursor.execute(select_query, (vehicle_type,))
         # Fetch all rows of data
        data = cursor.fetchall()
        cursor.close()  
        return data[0][0]

    def add_booking_db(self, Inquiry):

        cursor = self.db_conn.cursor()

        typeID = self.get_vehicle_typeID(Inquiry.vehicle_type)
        insert_query = """
        INSERT INTO booking (TypeID, CustomerName, InquireDate, HireDate, ReturnDate)
        VALUES (%s, %s, %s, %s, %s)
        """
        booking_data = (typeID, Inquiry.customer.name, Inquiry.inquire_date, Inquiry.hire_date, Inquiry.return_date)
        cursor.execute(insert_query, booking_data)

        self.db_conn.commit()

        # Get the last inserted ID
        booking_id = cursor.lastrowid
        cursor.close()

        return booking_id

    
    def add_customer_db(self, customer):

        cursor = self.db_conn.cursor()

        insert_query = """
        INSERT INTO customer (name, email)
        VALUES (%s, %s)
        """
        customer_data = (customer.name, customer.email)
        cursor.execute(insert_query, customer_data)

        self.db_conn.commit()
        cursor.close()


    