import pymongo
import random

# Connect to MongoDB
client = pymongo.MongoClient("mongodb+srv://deekshabhaskar27:deeksha@cluster0.7qqkz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
db = client["your_database"]
collection = db["your_collection"]

# Update all documents where accepted is 2, changing it to 0
#collection.update_many({"accepted": 2}, {"$set": {"accepted": 0}})
#print("Updated all records: changed accepted 2 -> 0")
# Generate 1000 random data entries
entries = []
for _ in range(1000):
    trip_distance_km = round(random.uniform(1, 50), 2)
    traffic_condition = random.choice([1, 2, 3])  # 1 = Low, 2 = Medium, 3 = High
    time_of_day = random.randint(0, 23)  # 24-hour format 
    ride_price = round(trip_distance_km * random.uniform(15, 30), 2)  # Approximate fare calculation
    accepted = random.choices([1, 0], weights=[50, 50])[0]  
    acceptance_rate = round(random.uniform(0.5, 1.0), 2) if accepted == 1 else round(random.uniform(0.1, 0.5), 2)

    entry = {
        "trip_distance_km": trip_distance_km,
        "traffic_condition": traffic_condition,
        "time_of_day": time_of_day,
        "ride_price_inr": ride_price,
        "accepted": accepted,
        "acceptance_rate": acceptance_rate
    }
    entries.append(entry)

# Insert all 1000 entries at once
collection.insert_many(entries)

print("Inserted 1000 random entries successfully!")


'''import numpy as np
from pymongo import MongoClient

# Ensure your data is correctly formatted
def convert_numpy_types(doc):
    return {key: int(value) if isinstance(value, np.integer) else value for key, value in doc.items()}

# MongoDB connection
client = MongoClient("mongodb+srv://deekshabhaskar27:deeksha@cluster0.7qqkz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
db = client["your_database"]
collection = db["your_collection"]

# Example data (before inserting, convert types)
data = [
    {"acceptance_rate": np.int32(88), "trip_distance": 8.07, "traffic_condition": np.int32(3), 
     "time_of_day": np.int32(10), "ride_price": 12, "accepted": np.int32(1)}
]

# Convert NumPy int types to Python int
converted_data = [convert_numpy_types(doc) for doc in data]

# Insert data into MongoDB
collection.insert_many(converted_data)

print("Data inserted successfully!")'''
