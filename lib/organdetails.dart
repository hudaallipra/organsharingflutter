import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class OrganDetails extends StatelessWidget {
  final List<String> organs = ['Eye', 'Kidney', 'Lungs', 'Liver'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organ Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: organs.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(organs[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrganDetailPage()),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrganDetailPage extends StatelessWidget {
  final List<Map<String, String>> donors = [
    {'organ': 'Eye', 'name': 'Alice Brown', 'bloodGroup': 'A+', 'contact': '1234567890', 'email': 'alice@example.com', 'gender': 'Female', 'address': '123 Street, City', 'hospital': 'City Hospital', 'image': 'assets/alice.jpg'},
    {'organ': 'Kidney', 'name': 'Bob Smith', 'bloodGroup': 'O-', 'contact': '0987654321', 'email': 'bob@example.com', 'gender': 'Male', 'address': '456 Avenue, City', 'hospital': 'General Hospital', 'image': 'assets/bob.jpg'},
    {'organ': 'Lungs', 'name': 'Charlie Johnson', 'bloodGroup': 'B+', 'contact': '1122334455', 'email': 'charlie@example.com', 'gender': 'Male', 'address': '789 Road, City', 'hospital': 'Healthcare Center', 'image': 'assets/charlie.jpg'},
    {'organ': 'Liver', 'name': 'David Williams', 'bloodGroup': 'AB+', 'contact': '2233445566', 'email': 'david@example.com', 'gender': 'Male', 'address': '101 Circle, City', 'hospital': 'City Medical Center', 'image': 'assets/david.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organ Donor Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: donors.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(donors[index]['image']!),
                ),
                title: Text(donors[index]['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Blood Group: ${donors[index]['bloodGroup']}'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorDetailPage(donor: donors[index])),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to add a new donor
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

class DonorDetailPage extends StatelessWidget {
  final Map<String, String> donor;
  DonorDetailPage({required this.donor});

  void _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${donor['name']} Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.teal, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(donor['image']!),
                ),
                SizedBox(height: 20),
                Text('Name: ${donor['name']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('Gender: ${donor['gender']}', style: TextStyle(fontSize: 18)),
                Text('Blood Group: ${donor['bloodGroup']}', style: TextStyle(fontSize: 18)),
                Text('Contact: ${donor['contact']}', style: TextStyle(fontSize: 18)),
                Text('Email: ${donor['email']}', style: TextStyle(fontSize: 18)),
                Text('Address: ${donor['address']}', style: TextStyle(fontSize: 18)),
                Text('Hospital: ${donor['hospital']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _makePhoneCall(donor['contact']!),
                  icon: Icon(Icons.phone),
                  label: Text('Call Donor'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Request Sent to ${donor['name']}')),
                    );
                  },
                  child: Text('Send Request'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
