// import 'package:flutter/material.dart';

// class PatientData extends StatefulWidget {
//   const PatientData({super.key});

//   @override
//   _PatientDataState createState() => _PatientDataState();
// }

// class _PatientDataState extends State<PatientData> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _hospitalController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   String? _selectedGender;
//   String? _selectedBloodGroup;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Patient Data Form'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name',
//                     hintText: 'Enter your full name',
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your full name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     hintText: 'Enter your phone number',
//                     prefixIcon: Icon(Icons.phone),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     hintText: 'Enter your address',
//                     prefixIcon: Icon(Icons.home),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your address';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: _selectedGender,
//                   decoration: InputDecoration(
//                     labelText: 'Gender',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   items: ['Male', 'Female', 'Other']
//                       .map((gender) => DropdownMenuItem(
//                             value: gender,
//                             child: Text(gender),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGender = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select your gender';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: _selectedBloodGroup,
//                   decoration: InputDecoration(
//                     labelText: 'Blood Group',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   items: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
//                       .map((bloodGroup) => DropdownMenuItem(
//                             value: bloodGroup,
//                             child: Text(bloodGroup),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedBloodGroup = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select your blood group';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     hintText: 'Enter your email',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _hospitalController,
//                   decoration: InputDecoration(
//                     labelText: 'Hospital Name',
//                     hintText: 'Enter hospital name',
//                     prefixIcon: Icon(Icons.local_hospital),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _ageController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Age',
//                     hintText: 'Enter your age',
//                     prefixIcon: Icon(Icons.cake),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Submitting patient data...')),
//                       );
//                     }
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                     elevation: 5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:organsharing/services/loginapi.dart';

class OrganDonationScreen extends StatefulWidget {
  const OrganDonationScreen({super.key, required this.catid});
  final String? catid;

  @override
  _OrganDonationScreenState createState() => _OrganDonationScreenState();
}

class _OrganDonationScreenState extends State<OrganDonationScreen> {
  bool isCaptchaChecked = false;
  PlatformFile? selectedFile; // Store the selected file

  // File picker function
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Allow any file type (you can restrict to specific types)
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  void _confirmDonation() {
    if (!isCaptchaChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify the CAPTCHA')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Donation'),
        content: const Text('Are you sure you want to donate your organs?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _sendDonationData();
            },
            child: const Text('Yes, Donate'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendDonationData() async {
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'organ_type': widget.catid,
        'user_id': loginid,
      
      });

      // Add file to FormData if selected
      if (selectedFile != null) {
        formData.files.add(MapEntry(
          'file', // Field name expected by the backend
          await MultipartFile.fromFile(
            selectedFile!.path!,
            filename: selectedFile!.name,
          ),
        ));
      }

      final response = await dio.post(
        '$baseUrl/organdonation',
        data: formData,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Donation data sent successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send donation data.')),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Organ Donation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QUOTE CARD
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.format_quote, color: Colors.teal[400], size: 30),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '"You don’t need to be a doctor to save lives – just be an organ donor."',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.teal[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // DESCRIPTION TEXT
            const Text(
              'Organ donation is a selfless act that gives others a second chance at life. '
              'One donor can save up to eight lives and improve countless others. '
              'Your decision can make a lasting impact.',
              style: TextStyle(fontSize: 16.5, height: 1.5),
            ),

            const SizedBox(height: 20),

            // FILE PICKER
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file, size: 18),
                  label: const Text('Pick File'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[100],
                    foregroundColor: Colors.teal[900],
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedFile != null ? selectedFile!.name : 'No file selected',
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedFile != null ? Colors.black : Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // CAPTCHA CARD
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCaptchaChecked,
                      onChanged: (value) {
                        setState(() {
                          isCaptchaChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "I'm not a robot",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/RecaptchaLogo.svg/1024px-RecaptchaLogo.svg.png',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // DONATE BUTTON
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: _confirmDonation,
                  child: const Text(
                    'Donate My Organ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}