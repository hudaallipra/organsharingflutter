import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'johndoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('+123 456 7890'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('New York, USA'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Male'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.bloodtype),
                        title: Text('O+'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('johndoe@example.com'),
                      ),
                    ],
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
