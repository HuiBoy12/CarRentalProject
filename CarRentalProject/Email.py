import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import mailtrap as mt


class EmailAppNew:
    def __init__(self, sender = "mailtrap@example.com", reciever = "zackoo9000@email.com", client_id = "351560f9171854d96615e1025a3ee3dc" ):
        self.sender = sender
        self.reciever = reciever
        self.client_id = client_id

    def sendConfirmation(self, invoice):
        # create mail object
        mail = mt.Mail(
            sender=mt.Address(email= self.sender, name="Mailtrap Test"),
            to=[mt.Address(email= self.reciever)],
            subject = "Confirmation of Booking",
            message = "Dear Mr. "+invoice.customer.name + "here is comfirmation of your booking " + invoice.get_invoice() #fix??
        )
        # create client and send
        client = mt.MailtrapClient(token= self.client_id)
        client.send(mail)



class EmailApp:
    def __init__(self, smtp_server = "smpt.gmail.com", smtp_port = 587, smtp_username = "zachhui88@gmail.com", smtp_password = "Puffy12345"):
        self.smtp_server = smtp_server
        self.smtp_port = smtp_port
        self.smtp_username = smtp_username
        self.smtp_password = smtp_password
    

    def sendConfirmation(self, invoice):
        # Email configuration
        sender_email = "zachhui88@gmail.com"
        receiver_email = invoice.customer.email
        subject = "Confirmation of Booking"
        message = "Dear Mr. "+invoice.customer.name + "here is comfirmation of your booking " + invoice.get_invoice()

        # Create a MIMEText object to represent the email body
        email_body = MIMEText(message, "plain")

        # Create a MIMEMultipart message
        msg = MIMEMultipart()
        msg["From"] = sender_email
        msg["To"] = receiver_email
        msg["Subject"] = subject

        # Attach the email body to the message
        msg.attach(email_body)

        # Connect to the SMTP server (for Gmail)
        smtp_server = self.smtp_server
        smtp_port = self.smtp_port
        smtp_username = self.smtp_username
        smtp_password = self.smtp_password # Use an app password if using Gmail

        # Create a secure connection to the server
        server = smtplib.SMTP('64.233.184.108')
        #server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()

        # Log in to the server
        server.login(smtp_username, smtp_password)

        # Send the email
        server.sendmail(sender_email, receiver_email, msg.as_string())

        # Disconnect from the server
        server.quit()
