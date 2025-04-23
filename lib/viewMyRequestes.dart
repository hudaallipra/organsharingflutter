
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:organsharing/services/loginapi.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  Future<List<OrganRequest>> fetchRequests() async {
    try {
      final response = await Dio().get('$baseUrl/OrganDonorRequestAPIView/$loginid');
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => OrganRequest.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load requests');
      }
    } catch (e) {
      throw Exception('Error fetching requests: $e');
    }
  }

  // Future<void> createAppointment(String organRequestId) async {
  //   try {
  //     final response = await Dio().post('$baseUrl/appointments/$organRequestId/');
  //     if (response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Appointment created successfully')),
  //       );
  //     } else {
  //       throw Exception('Failed to create appointment');
  //     }
  //   } catch (e) {
  //     String errorMessage = 'Error creating appointment: $e';
  //     if (e is DioError && e.response != null) {
  //       errorMessage = e.response!.data['error'] ?? errorMessage;
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(errorMessage)),
  //     );
  //   }
  // }

  late Future<List<OrganRequest>> futureRequests;

  @override
  void initState() {
    super.initState();
    futureRequests = fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Organ Requests'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<OrganRequest>>(
        future: futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No requests found'));
          }

          final requests = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return RequestCard(
                request: request,
                // onCreateAppointment: () => createAppointment(request.id),
              );
            },
          );
        },
      ),
    );
  }
}

class OrganRequest {
  final String id;
  final String organName;
  final String organDonorName;
  final String? doctorName;
  final String createdAt;
  final String patientId;
  final String organId;
  final String? assignedDoctor;
  final String patientname;
  final String patientPhoneNumber;
  final String doctorPhoneNumber;

  OrganRequest({
    required this.patientPhoneNumber,
    required this.doctorPhoneNumber,
    required this.patientname,
    required this.id,
    required this.organName,
    required this.organDonorName,
    this.doctorName,
    required this.createdAt,
    required this.patientId,
    required this.organId,
    this.assignedDoctor,
  });

  factory OrganRequest.fromJson(Map<String, dynamic> json) {
    return OrganRequest(
      id: json['id'].toString(),
      organName: json['organ_name'],
      organDonorName: json['organ_donor_name'],
      doctorName: json['doctor_name'],
      createdAt: json['created_at'],
      patientId: json['patient_id'].toString(),
      organId: json['organ_id'].toString(),
      assignedDoctor: json['assigneddoctor']?.toString(),
      patientname: json['patient_name'] ?? "Not assigned",
      patientPhoneNumber: json['user_phone'] ?? "Not assigned",
      doctorPhoneNumber: json['doctor_phone'] ?? "Not assigned",
    );
  }
}

class RequestCard extends StatelessWidget {
  final OrganRequest request;
  // final VoidCallback onCreateAppointment;

  const RequestCard({
    super.key,
    required this.request,
    // required this.onCreateAppointment,
  });

   void _makePhoneCall(String phoneNumber,context) async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to make phone call'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organ: ${request.organName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Text(
            //   'Donor: ${request.organDonorName}',
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            // const SizedBox(height: 8),
            Text(
              'Doctor: ${request.doctorName ?? "Not assigned"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
              Text(
              'Patient: ${request.patientname ?? "Not assigned"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
             ElevatedButton.icon(
                  onPressed:()=>_makePhoneCall(request.doctorPhoneNumber,context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Contact Doctor'),
                  icon: const Icon(Icons.phone),
                ),
            const SizedBox(height: 6),
                 ElevatedButton.icon(
                  onPressed:()=>_makePhoneCall(request.patientPhoneNumber,context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Contact Patient'),
                  icon: const Icon(Icons.phone),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               SizedBox(),
                
                Text(
                  request.createdAt.substring(0, 10),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
