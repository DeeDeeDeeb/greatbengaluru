from sklearn.preprocessing import StandardScaler

# Define input features and target label
X = df.drop(columns=["accepted"]).values  # Features (excluding target)
y = df["accepted"].values  # Labels (1 = Accepted, 0 = Not Accepted)

# Normalize numerical features
scaler = StandardScaler()
X = scaler.fit_transform(X)

# Save the scaler for later use
import joblib
joblib.dump(scaler, "scaler.pkl")
