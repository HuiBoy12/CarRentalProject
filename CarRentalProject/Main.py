import datetime
import CarManagement as cm
import Sql

if __name__ == "__main__":
 
    customer1 = cm.Customer(None, "Zach", "zach123579123456@hotmail.com")
    current_date = datetime.date.today()
    # Define the number of days in the future
    days_in_future = 7  # For example, 7 days from today
    days_in_future_more = 10
    # Calculate the future date
    hire_date = current_date + datetime.timedelta(days=days_in_future)
    return_date = current_date + datetime.timedelta(days=days_in_future_more)
    inquiry_obj = cm.Inquiry(customer1, "Small Car", current_date, hire_date, return_date)
    time_difference = return_date - hire_date
    status = inquiry_obj.validate() #validate if inquiry is true
    if status == False: #checks if false
        print("Invalid Inquiry")
        exit()
    sql_obj = Sql.SqlFunc() #get connection
    booking_obj = cm.BookingSystem(sql_obj)
    booking_obj.make_booking(inquiry_obj)

