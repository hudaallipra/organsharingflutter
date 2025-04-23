import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:organsharing/services/loginapi.dart';

class Statuspage extends StatefulWidget {
  const Statuspage({super.key});

  @override
  State<Statuspage> createState() => _StatuspageState();
}

class _StatuspageState extends State<Statuspage> {
  List<Map<String,dynamic>>datas=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
 void fetchData() async {
    try {
      final response = await Dio().get('$baseUrl/organrequest/$loginid');
      if (response.statusCode == 200) {
        
        print(response.data);
        datas=List<Map<String,dynamic>>.from(response.data);
        setState(() {
          
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void sendAppointmentRequest( requestId) async {
    try {
      final response = await Dio().post(
        '$baseUrl/appointments/$loginid/',
        data: {'request_id': requestId},
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment request sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send appointment request.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Status Page'),
      backgroundColor: Colors.teal,
    ),
    body: datas.isEmpty
        ? Center(child:Text('No data available'))
        : ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) {
              final item = datas[index];

              String status = item['status'] ?? 'Pending'; // Add status if available
              Color statusColor;
              switch (status) {
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

              return Card(
                margin: const EdgeInsets.all(16.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Organ: ${item['organ_name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Donor Name: ${item['organ_donor_name'] ?? 'Not assigned'}"),
                      Text("Doctor: ${item['doctor_name'] ?? 'Not assigned'}"),
                      Text("Created At: ${item['created_at']?.toString().split('T')[0] ?? ''}"),
                      Text("Status: $status", style: TextStyle(color: statusColor, fontWeight: FontWeight.w600)),
                      SizedBox(height:10),
                      if(item['status']=='accepted')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        onPressed: () {
                          sendAppointmentRequest(item['id']); // Pass the request ID to the function
                          // Navigate to the details page
                        },child: Text('Take Appointment',style: TextStyle(color: Colors.white),),),
                    ],
                  ),
                ),
              );
            },
          ),
  );
}
}