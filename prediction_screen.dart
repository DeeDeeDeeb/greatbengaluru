import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  double predictedDemand = 0.0;  // Variable to store the predicted demand
  bool isLoading = false;        // Variable to track loading state

  // Function to call the API and get the predicted demand
  Future<void> predictDemand() async {
    setState(() {
      isLoading = true;  // Show loading indicator
    });

    try {
      // Define the API endpoint
      final url = Uri.parse('http://127.0.0.1:5000/predict');  // Replace with your Render URL if deployed

      // Define input data
      final data = {
        'location_id': 2,  // Replace with user input
        'hour': 08,        // Replace with user input
        'day_of_week': 1,  // Replace with user input
      };

      // Send a POST request to the API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      // Print the response for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response
        final result = json.decode(response.body);
        setState(() {
          predictedDemand = result['predicted_demand'];  // Update the predicted demand
        });
      } else {
        throw Exception('Failed to load prediction');
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get prediction. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;  // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demand Prediction', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card to display the predicted demand
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Predicted Demand',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        predictedDemand.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Button to trigger the prediction
              ElevatedButton(
                onPressed: isLoading ? null : predictDemand,  // Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.deepPurple)  // Show loading indicator
                    : Text(
                        'Predict Demand',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}