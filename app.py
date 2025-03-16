import joblib
import numpy as np
import tensorflow as tf
import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel

# FastAPI app
app = FastAPI()

# Load trained model
model = tf.keras.models.load_model("ride_acceptance_model.keras")
# Load the same scaler used in training
scaler = joblib.load("scaler.pkl")

class RideRequest(BaseModel):
    feature1: float
    feature2: float
    feature3: float
    feature4: float
    feature5: float

@app.post("/predict/")
async def predict_ride_acceptance(data: RideRequest):
    # Convert input into NumPy array
    input_data = np.array([[data.feature1, data.feature2, data.feature3, data.feature4, data.feature5]])
    
    print("Raw Input:", input_data)  # Debugging
    input_data = scaler.transform(input_data)
    print("Scaled Input:", input_data)
   
    # Get prediction
    prediction = model.predict(input_data)[0][0]
    acceptance = int(prediction > 0.3)  # Convert probability to binary output
    return {"acceptance_probability": float(prediction), "accepted": acceptance}

if __name__ == "__main__":
    print("Starting FastAPI app...")
    uvicorn.run(app, host="0.0.0.0", port=5000)
