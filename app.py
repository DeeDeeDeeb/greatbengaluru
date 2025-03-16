from flask import Flask, request, jsonify
from flask_cors import CORS  # Import CORS
import joblib
import pandas as pd

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Load the trained model
model = joblib.load('demand_prediction_model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    # Get input data from the request
    data = request.json

    # Convert input data into a DataFrame
    input_data = pd.DataFrame([data])

    # Ensure the columns match the training data
    input_data = input_data[['location_id', 'hour', 'day_of_week']]

    # Make a prediction
    prediction = model.predict(input_data)

    # Return the prediction as a JSON response
    return jsonify({'predicted_demand': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)