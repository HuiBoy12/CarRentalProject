from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# MySQL configuration
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'SqlPassword1!',
    'database': 'var'
}

@app.route('/add_security', methods=['POST'])
def add_security():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        data = request.json
        query = "INSERT INTO security (symbol, industry, currency) VALUES (%s, %s, %s)"
        values = (data['symbol'], data['industry'], data['currency'])
        cursor.execute(query, values)

        connection.commit()
        cursor.close()
        connection.close()

        return jsonify({'message': 'Customer added successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/add_portfolio', methods=['POST'])
def add_portfolio():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        data = request.json
        query = "INSERT INTO portfolio (name, description) VALUES (%s, %s)"
        values = (data['name'], data['description'])
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

