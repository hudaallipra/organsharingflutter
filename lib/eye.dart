import 'package:flutter/material.dart';

class Patient {
  final String name;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String gender;
  final String bloodGroup;
  final String email;
  final String hospitalName;
  final int age;

  Patient({
    required this.name,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.bloodGroup,
    required this.email,
    required this.hospitalName,
    required this.age,
  });
}

class EyePage extends StatelessWidget {
  EyePage({Key? key}) : super(key: key);

  final List<Patient> patients = [
    Patient(
      name: "John Doe",
      fullName: "Johnathan Doe",
      phoneNumber: "123-456-7890",
      address: "123 Elm Street, NY",
      gender: "Male",
      bloodGroup: "A+",
      email: "johndoe@example.com",
      hospitalName: "City Hospital",
      age: 30,
    ),
    Patient(
      name: "Jane Smith",
      fullName: "Jane Alicia Smith",
      phoneNumber: "987-654-3210",
      address: "456 Maple Avenue, LA",
      gender: "Female",
      bloodGroup: "B-",
      email: "janesmith@example.com",
      hospitalName: "General Hospital",
      age: 25,
    ),
    Patient(
      name: "Michael Brown",
      fullName: "Michael James Brown",
      phoneNumber: "555-123-4567",
      address: "789 Oak Road, TX",
      gender: "Male",
      bloodGroup: "O+",
      email: "michaelbrown@example.com",
      hospitalName: "Metro Hospital",
      age: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eye Patients'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(patients[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Blood Group: ${patients[index].bloodGroup}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetailPage(patient: patients[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PatientDetailPage extends StatelessWidget {
  final Patient patient;
  
  PatientDetailPage({required this.patient});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name: ${patient.fullName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Phone Number: ${patient.phoneNumber}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Address: ${patient.address}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Gender: ${patient.gender}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Blood Group: ${patient.bloodGroup}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Email: ${patient.email}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Hospital Name: ${patient.hospitalName}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Age: ${patient.age}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add request action
                },
                child: Text("Request"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
