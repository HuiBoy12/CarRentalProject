from datetime import datetime, timedelta
import Email as em

class Customer: 
    def __init__(self, booking_id, name, email):
        self.booking_id = booking_id
        self.name = name
        self.email = email

class Inquiry:
    def __init__(self, customer, vehicle_type, inquire_date, hire_date, return_date):
        self.customer = customer
        self.vehicle_type = vehicle_type
        self.inquire_date = inquire_date
        self.hire_date = hire_date
        self.return_date = return_date
        
    def validate(self):
        date_difference = self.return_date - self.hire_date
        advance_difference = self.hire_date - self.inquire_date
        if date_difference.days > 7:
            print("Cannot rent vehicle for more than 7 days")
            return False
        if advance_difference.days > 7:
            print("Cannot book a vehicle more than 7 days in advance")
            return False
        return True 

class Invoice:
    def __init__(self, inquiry, total_cost):
        self.customer = inquiry.customer    
        self.inquire_date = inquiry.inquire_date
        self.vehicle_type = inquiry.vehicle_type
        self.hire_date = inquiry.hire_date
        self.return_date = inquiry.return_date
        self.total_cost = total_cost

    def print_invoice(self):
        message = self.get_invoice()
        print(message)

    def get_invoice(self):
        hire_date_format = self.hire_date.strftime("%Y-%m-%d %H:%M:%S")
        inquire_date_format = self.inquire_date.strftime("%Y-%m-%d %H:%M:%S")
        return_date_format = self.return_date.strftime("%Y-%m-%d %H:%M:%S")
        total_cost_str = str(self.total_cost)
        new_line = "\n"
        customer_name_f = self.customer.name
        customer_email_f = self.customer.email
        vehicle_type_f = self.vehicle_type
        formated_mesage = f"{customer_name_f}{new_line},{customer_email_f}{new_line}, Car Type: {vehicle_type_f}, Inquiry Date{inquire_date_format}:, Hire Date{hire_date_format}:, Return Date{return_date_format}, Total Cost{total_cost_str}"
        message = "Customer Name: " + self.customer.name + new_line +  "Customer Email: " + self.customer.email + new_line + "Car Type: " \
                    + self.vehicle_type + new_line \
                    + "Inquiry Date: " + inquire_date_format + new_line  \
                    + "Hire Date:" + hire_date_format + new_line \
                    + "Return Date: " + return_date_format + new_line \
                    + "Total Cost: " + total_cost_str
        return message

class BookingSystem:
    def __init__(self, SqlObj):
        self.SqlObj = SqlObj

    def make_booking(self, inquiry):
        result = self.SqlObj.is_available(inquiry.vehicle_type, inquiry.hire_date, inquiry.return_date)
        if result:
            total_days = inquiry.return_date - inquiry.hire_date #change later on
            cost = self.SqlObj.get_cost(inquiry.vehicle_type)
            days = total_days.days
            dailycost = cost[0][0]
            total_cost = dailycost*days #calculate cost of rental
            booking_ID = self.SqlObj.add_booking_db(inquiry)
            #inquiry.customer.booking_ID = booking_ID
            self.SqlObj.add_customer_db(inquiry.customer)
            invoice_obj = Invoice(inquiry, total_cost)
            invoice_obj.print_invoice() #fix implementation
            #self.send_confirmation(invoice_obj) #email not working due to google no longer allows insecure login through stmp port 
            return True
        else:
            print("Vehicle Not Avaliable")
        return False

    def send_confirmation(self, invoice):
        # Send confirmation letter to the customer
        date_difference = invoice.hire_date - invoice.inquire_date 
        if date_difference.days > 0:
            email_object = em.EmailAppNew()
            email_object.sendConfirmation(invoice)   
        return
