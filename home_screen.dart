import 'package:flutter/material.dart';
import 'traffic_heat_map_screen.dart';
import 'gamification_screen.dart';
import 'prediction_screen.dart';  // Import the PredictionScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          "Namma Yatri",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              _buildOptionCard(
              icon: Icons.emoji_events_outlined,
              text: "Gamification",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamificationScreen()),
                );
              },
            ),
            _buildOptionCard(
              icon: Icons.insights_outlined,
              text: "Ride demand analysis",
              onTap: () {
                // Navigate to PredictionScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PredictionScreen()),
                );
              },
            ),

            _buildOptionCard(
              icon: Icons.insights_outlined,
              text: "AI driven Driver behaviour prediction",
              onTap:(){},
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.blueAccent),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}