import requests

# Define the API endpoint
url = 'http://127.0.0.1:5000/predict'  # Replace with your Render URL if deployed

# Define input data
data = {
    'location_id': 5,
    'hour': 17,
    'day_of_week': 4
}

# Send a POST request to the API
response = requests.post(url, json=data)

# Print the response
print(response.json())