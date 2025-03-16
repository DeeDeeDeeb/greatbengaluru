import 'package:flutter/material.dart';

class GamificationScreen extends StatefulWidget {
  @override
  _GamificationScreenState createState() => _GamificationScreenState();
}

class _GamificationScreenState extends State<GamificationScreen> {
  int points = 0;
  bool isDailySelected = true;

  List<Map<String, dynamic>> dailyChallenges = [
    {"task": "Complete 10 rides", "points": 20, "done": false},
    {"task": "Get 5-star rating from 3 customers", "points": 15, "done": false},
    {"task": "Drive 50 km today", "points": 25, "done": false},
    {"task": "Pick up at least 3 passengers from the metro", "points": 10, "done": false},
  ];

  List<Map<String, dynamic>> weeklyChallenges = [
    {"task": "Complete 50 rides in a week", "points": 50, "done": false},
    {"task": "Get 10 5-star ratings", "points": 30, "done": false},
    {"task": "Drive 300 km this week", "points": 40, "done": false},
    {"task": "Complete 5 night-time rides", "points": 20, "done": false},
  ];

  void _updatePointsAndRemoveCompleted() {
    setState(() {
      var selectedList = isDailySelected ? dailyChallenges : weeklyChallenges;
      selectedList.removeWhere((challenge) {
        if (challenge["done"]) {
          points += (challenge["points"] as int);
          return true; // Remove the challenge
        }
        return false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentChallenges = isDailySelected ? dailyChallenges : weeklyChallenges;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Gamification"),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Points Display
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
                ],
              ),
              child: Column(
                children: [
                  Text("Your Points", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Text("$points", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Challenge Selection Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChallengeButton("Daily", isDailySelected, () {
                  setState(() => isDailySelected = true);
                }),
                SizedBox(width: 10),
                _buildChallengeButton("Weekly", !isDailySelected, () {
                  setState(() => isDailySelected = false);
                }),
              ],
            ),
            SizedBox(height: 20),

            // Challenge List
            Expanded(
              child: currentChallenges.isNotEmpty
                  ? ListView.builder(
                      itemCount: currentChallenges.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(currentChallenges[index]["task"]),
                          subtitle: Text("+${currentChallenges[index]["points"]} points"),
                          value: currentChallenges[index]["done"],
                          onChanged: (bool? value) {
                            setState(() {
                              currentChallenges[index]["done"] = value!;
                            });
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No challenges left! 🎉",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                      ),
                    ),
            ),

            // Submit Button
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _updatePointsAndRemoveCompleted,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2)),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: isSelected ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}