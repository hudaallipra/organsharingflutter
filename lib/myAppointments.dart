import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:organsharing/services/loginapi.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

// Appointment model
class Appointment {
  final int id;
  final int patientId;
  final int doctorId;
  final String? date;
  final String? time;
  final String status;
  final String doctorName;
  final String? prescription;
  final String? nextAppointmentDate;

  Appointment({
    required this.prescription,
    required this.nextAppointmentDate,
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.date,
    this.time,
    required this.status,
    required this.doctorName,
  });
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await Dio().get('$baseUrl/appointments/$loginid/');
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          List<Appointment> appointmentsss = data.map((json) {
            return Appointment(
              id: json['id'],
              patientId: json['patient_id'],
              doctorId: json['doctor_id'],
              date: json['appointment_date'],
              time: json['appointment_time'],
              status: json['status'],
              doctorName: json['doctor_name'],
              prescription: json['prescription_file'],
              nextAppointmentDate: json['next_visit_date'],
            );
          }).toList();
          appointments = appointmentsss.reversed.toList();
        });
      } else {
        throw Exception('Failed to load appointments');
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
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: appointments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 60,
                        color: Colors.teal[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No appointments scheduled.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.teal[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
              
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return _buildAppointmentCard(appointment);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Card(
      elevation: 6,
      shadowColor: Colors.teal.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          // Optionally navigate to a details page or show a dialog
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.teal[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal[700],
                child: Text(
                  appointment.doctorName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${appointment.doctorName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildStatusChip(appointment.status),
                    const SizedBox(height: 12),
                    if (appointment.status.toLowerCase() == 'accepted' &&
                        appointment.date != null &&
                        appointment.time != null) ...[
                      Text(
                        'Scheduled at:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${appointment.date}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                      Text(
                        'Time: ${appointment.time}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 12),
                      if(appointment.prescription!=null)
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: const Text('Prescription'),
                                          backgroundColor: Colors.teal[700],
                                        ),
                                        body: PDFView(
                                          filePath:
                                              '$baseUrl${appointment.prescription}',
                                          enableSwipe: true,
                                          swipeHorizontal: true,
                                          autoSpacing: false,
                                          pageFling: false,
                                          backgroundColor: Colors.grey,
                                          onRender: (_pages) {
                                            setState(() {});
                                          },
                                          onError: (error) {
                                            print(error.toString());
                                          },
                                          onPageError: (page, error) {
                                            print('$page: ${error.toString()}');
                                          },
                                        ),
                                      )));
                          // Handle prescription file download or view
                        },
                        label: Text('View Prescription'),
                        icon: Icon(Icons.file_open_sharp),
                      ),
                      if(appointment.prescription!=null)
                      IconButton(
                        onPressed: () {
                          // Handle prescription file download or view
                          launchUrl(
                            Uri.parse('$baseUrl${appointment.prescription}'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        icon: Icon(Icons.file_download),
                      ),
                       if(appointment.nextAppointmentDate!=null)
                      const SizedBox(height: 4),
                      if(appointment.nextAppointmentDate!=null)
                      Text(
                        'Next Appointment: ${appointment.nextAppointmentDate ?? 'N/A'}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    String label;
    IconData icon;
    switch (status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.teal[100]!;
        label = 'Pending';
        icon = Icons.hourglass_empty;
        break;
      case 'accepted':
        chipColor = Colors.teal[400]!;
        label = 'Accepted';
        icon = Icons.check_circle;
        break;
      default:
        chipColor = Colors.grey[400]!;
        label = 'Unknown';
        icon = Icons.info;
    }

    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 16),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
