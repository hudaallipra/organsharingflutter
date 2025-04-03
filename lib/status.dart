import 'package:flutter/material.dart';

class Statuspage extends StatelessWidget {
  const Statuspage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> userData = {
      "Name": "John Doe",
      "Date & Time": "April 2, 2025 - 10:00 AM",
      "Status": "Approved",
      "Doctor": "Dr. Smith"
    };

    Color statusColor;
    switch (userData["Status"]) {
      case "Approved":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.blue;
        break;
      case "Rejected":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Page'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userData.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "${entry.key}: ${entry.value}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: entry.key == "Status" ? statusColor : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
