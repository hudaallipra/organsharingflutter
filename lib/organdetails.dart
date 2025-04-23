
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:organsharing/patientdata.dart';
import 'package:organsharing/services/loginapi.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganDetails extends StatefulWidget {
  const OrganDetails({super.key});

  @override
  State<OrganDetails> createState() => _OrganDetailsState();
}

class _OrganDetailsState extends State<OrganDetails> {
  List<Map<String, dynamic>> organs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final response = await Dio().get('$baseUrl/orgondonerlist');
      if (response.statusCode == 200) {
        setState(() {
          organs = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
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
        title: const Text(
          'Organ Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700],
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: organs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: organs.length,
                itemBuilder: (context, index) {
                  return _buildOrganCard(
                    context,
                    organName: organs[index]['category'] ?? "Unknown",
                    categoryId: organs[index]['categoryid'].toString(),
                    donors: organs[index]['donors'] as List<dynamic>,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildOrganCard(BuildContext context,
      {required String organName, required String categoryId, required List<dynamic> donors}) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganDetailPage(
                catid: categoryId,
                organName: organName,
                donors: donors,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[50]!, Colors.teal[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon(Icons.favorite, color: Colors.teal[700], size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  organName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900],
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.teal[700], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganDetailPage extends StatelessWidget {
  final String catid;
  final String organName;
  final List<dynamic> donors;

  const OrganDetailPage({super.key, required this.organName, required this.donors, required this.catid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$organName Donors',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700],
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: donors.isEmpty
            ? Center(
                child: Text(
                  'No donors available for $organName.',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: donors.length,
                itemBuilder: (context, index) {
                  final donor = donors[index];
                  return _buildDonorCard(context, donor: donor);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganDonationScreen(catid: catid),
            ),
          );
        },
        backgroundColor: Colors.teal[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDonorCard(BuildContext context, {required Map<String, dynamic> donor}) {
    return Card(
      elevation: 6,
      shadowColor: Colors.teal.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonorDetailPage(donor: donor),
            ),
          );
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
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: donor['profile_image'] != null && donor['profile_image'].isNotEmpty
                    ? NetworkImage(donor['profile_image'])
                    : null,
                child: donor['profile_image'] == null || donor['profile_image'].isEmpty
                    ? Text(
                        donor['user_name']?.substring(0, 1).toUpperCase() ?? 'D',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : null,
                backgroundColor: Colors.teal[700],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donor['user_name'] ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Blood Group: ${donor['bloodgroup'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.teal[700], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}




class DonorDetailPage extends StatefulWidget {
  final Map<String, dynamic> donor;

  const DonorDetailPage({super.key, required this.donor});

  @override
  _DonorDetailPageState createState() => _DonorDetailPageState();
}

class _DonorDetailPageState extends State<DonorDetailPage> {
  PlatformFile? selectedFile;
  bool isLoading = false;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
        });
        if (mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('File selected: ${selectedFile!.name}'),
          //     backgroundColor: Colors.teal[600],
          //   ),
          // );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: Colors.red[600],
          ),
        );
      }
    }
  }

  void _makePhoneCall(String phoneNumber) async {
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to make phone call'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _sendRequest(BuildContext context) async {
    // Validation
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a file before sending request'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.donor['donation_id'] == null || loginid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid donor or patient information'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'organ_id': widget.donor['donation_id'],
        'patient_id': loginid,
      });

      formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          selectedFile!.path!,
          filename: selectedFile!.name,
        ),
      ));

      final response = await dio.post(
        '$baseUrl/organrequest',
        data: formData,
      );

      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Request sent successfully to ${widget.donor['user_name']}'),
              backgroundColor: Colors.teal[600],
            ),
          );
          Navigator.pop(context); // Close dialog
          setState(() {
            selectedFile = null;
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to send request');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red[600],
          ),
        );
        setState(() => isLoading = false);
      }
    }
  }

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: const Text('Send Request'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _pickFile();
                      dialogSetState(() {}); // Update dialog state
                    },
                    icon: const Icon(Icons.attach_file, size: 18, color: Colors.white),
                    label: const Text('Pick File', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[600],
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal[200]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedFile != null ? selectedFile!.name : 'No file selected',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedFile != null ? Colors.teal[900] : Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: isLoading ? null : () => _sendRequest(context),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Send'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.donor['user_name'] ?? 'Donor'} Details',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700],
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shadowColor: Colors.teal.withOpacity(0.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.teal[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: widget.donor['profile_image']?.isNotEmpty == true
                            ? NetworkImage(widget.donor['profile_image'])
                            : null,
                        child: widget.donor['profile_image']?.isEmpty != false
                            ? Text(
                                widget.donor['user_name']?.substring(0, 1).toUpperCase() ?? 'D',
                                style: const TextStyle(fontSize: 40, color: Colors.white),
                              )
                            : null,
                        backgroundColor: Colors.teal[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDetail('Name', widget.donor['user_name'] ?? 'N/A'),
                    _buildDetail('Gender', widget.donor['gender'] ?? 'N/A'),
                    _buildDetail('Blood Group', widget.donor['bloodgroup'] ?? 'N/A'),
                    _buildDetail('Phone', widget.donor['phone_number'] ?? 'N/A'),
                    _buildDetail('Email', widget.donor['email'] ?? 'N/A'),
                    _buildDetail('Address', widget.donor['address'] ?? 'N/A'),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => _makePhoneCall(widget.donor['phone_number'] ?? ''),
                        icon: const Icon(Icons.phone, color: Colors.white),
                        label: const Text('Call Donor', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[700],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _showRequestDialog,
                        child: const Text('Send Request', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}