import requests
from bs4 import BeautifulSoup
import pandas as pd

# URL of the webpage to scrape
url = "https://www.wtatennis.com/stats"

# Send an HTTP GET request to the URL
response = requests.get(url)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Parse the HTML content of the page with BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find the table containing the data you want (you may need to inspect the webpage's HTML to identify the specific table)
    #table = soup.find('table', {'class': 'stats-list'})  # Replace 'your-table-class' with the actual class of the table
    table = soup.find_all('table')[0]

    # Initialize empty lists to store data
    data_rows = []

    # Loop through table rows and extract data
    for row in table.find_all('tr'):
        columns = row.find_all('td')
        if len(columns) > 0:
            data_row = [col.get_text(strip=True) for col in columns]
            data_rows.append(data_row)

    # Create a DataFrame from the scraped data
    df = pd.DataFrame(data_rows, columns=["Column1", "Column2", ...])  # Replace with actual column names

    # Print the DataFrame
    print(df)

else:
    print("Failed to fetch data")