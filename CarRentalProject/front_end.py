from flask import Flask, request, render_template, jsonify
import mysql.connector

app = Flask(__name__)

# MySQL configuration
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'SqlPassword1!',
    'database': 'carmanagement'
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_customers', methods=['GET'])
def get_customers():

    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor(dictionary=True)
    query = 'select name, email from customer'
    cursor.execute(query)
    rows = cursor.fetchall()
    cursor.close()
    connection.close()
    # Return a list of tuples containing the portfolio information
    #portfolios = [(1,"andrew","andrew"),(2,'zach',"andrew")]

    # Iterate through the rows
    customers = []
    for row in rows:
        name = row['name']
        email = row['email']
        tp = (name,email)
        customers.append(tp)

    if not rows:
        return 'No customer found', 201
    else:
        return render_template('customer.html', customers=customers)

@app.route('/add_customer_web', methods=['POST'])
def add_customer_web():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        name = request.form['name']
        email = request.form['email']
        query = "INSERT INTO customer (name, email) VALUES (%s, %s)"
        values = (name, email)
        cursor.execute(query, values)

        connection.commit()
        cursor.close()
        connection.close()

        add_customer_str = 'Customer ' + name + ' ' + email + ' Added!'
        return add_customer_str, 201
    except Exception as e:
        return 'Error adding customer', 500

@app.route('/remove_customer_web', methods=['POST'])
def remove_customer_web():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        #data = request.json
        name = request.form['name']
        email = request.form['email']
        query = "DELETE FROM customer WHERE name = %s and email = %s"
        values = (name, email)
        cursor.execute(query,values)

        connection.commit()
        cursor.close()
        connection.close()

        delete_string = 'Customer ' + name + ' removed successfully'
        return delete_string, 200
    except Exception as e:
        return 'Error removing customer', 500

@app.route('/update_customer_web', methods=['POST'])
def update_customer_web():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        new_name = request.form['new name']
        new_email = request.form['new email']
        old_name = request.form['name']
        old_email = request.form['email']
        #data = request.json
        query = "UPDATE customer SET name = %s, email = %s WHERE name = %s and email = %s"
        values = (new_name, new_email, old_name, old_email)
        cursor.execute(query, values)

        connection.commit()
        cursor.close()
        connection.close()

        return 'Customer updated successfully', 200
    except Exception as e:
        return 'Error updating customer', 500

@app.route('/add_customer', methods=['POST'])
def add_customer():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        data = request.json
        query = "INSERT INTO customer (name, email) VALUES (%s, %s)"
        values = (data['name'], data['email'])
        cursor.execute(query, values)

        connection.commit()
        cursor.close()
        connection.close()

        return jsonify({'message': 'Customer added successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/update_customer', methods=['PUT'])
def update_customer():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        data = request.json
        query = "UPDATE customer SET name = %s, email = %s WHERE name = %s and email = %s"
        values = (data['new_name'], data['new_email'],data['name'], data['email'])
        cursor.execute(query, values)

        connection.commit()
        cursor.close()
        connection.close()

        return jsonify({'message': 'Customer updated successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/delete_customer', methods=['DELETE'])
def delete_customer():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        data = request.json
        query = "DELETE FROM customer WHERE name = %s and email = %s"
        values = (data['name'], data['email'])
        cursor.execute(query,values)

        connection.commit()
        cursor.close()
        connection.close()

        return jsonify({'message': 'Customer deleted successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_customer', methods=['GET'])
def get_customer():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        data = request.json
        query = "SELECT name, email FROM customer WHERE name = %s and email = %s"
        values = (data['name'], data['email'])
        cursor.execute(query, values)
        customer = cursor.fetchone()

        cursor.close()
        connection.close()

        if customer:
            return jsonify(customer), 200
        else:
            return jsonify({'message': 'Customer not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500
if __name__ == '__main__':
     app.run(debug=True)

