import 'package:flutter/material.dart';
import 'package:organsharing/eye.dart';
import 'package:organsharing/homepage.dart';
import 'package:organsharing/login.dart';
import 'package:organsharing/organdetails.dart';
import 'package:organsharing/patientdata.dart';
import 'package:organsharing/profile.dart';
import 'package:organsharing/register.dart';
import 'package:organsharing/status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:HomePage()
    );
  }
}



 