import 'package:flutter/material.dart';
import 'package:organsharing/services/getprofile.dart';
import 'package:organsharing/services/loginapi.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data here if needed
    getProfile(loginid.toString()).then((_) {
      setState(() {
        // Update the state with the fetched profile data
      });
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: Text('Profile',style: TextStyle(color: Colors.white),),
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
                backgroundImage: NetworkImage('$baseUrl${profileData['image']}' ?? 'https://via.placeholder.com/150'),
              ),
              SizedBox(height: 16),
              Text(
                profileData['user_name'] ?? 'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                profileData['email'] ?? 'JohnDoe@gmail.com',
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
                        title: Text(profileData['phone_number'] ?? '123-456-7890'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(profileData['address'] ?? ' 123 Main St, City, Country'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(profileData['gender'] ?? 'Male'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.bloodtype),
                        title: Text(profileData['blood_group'] ??'O+'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text(profileData['email'] ??'johndoe@example.com'),
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
