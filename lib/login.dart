import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:organsharing/homepage.dart';

import 'package:organsharing/register.dart';
import 'package:organsharing/services/loginapi.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Email Input Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Password Input Field
            TextField(
              controller: passwordController,
              obscureText: true, // to hide password
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Login Button
            ElevatedButton(
              onPressed: () async {
                Response? res = await performLogin(
                  emailController.text,
                  passwordController.text,
                );
                print(res?.data);
                if (res != null && res.statusCode == 200) {
                  // Handle successful login
                  if (res.data['status'] == 'success') {
                    // Store the login ID or token if needed
                    // loginid = res.data['loginid'];
                    print('Login ID: ${res.data['login_id']}');
                    loginid = int.tryParse(res.data['login_id']) ?? 0;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  } else {
                    // Handle invalid credentials or other errors
                    print('Invalid credentials: ${res.data}');
                  }
                  print('Login successful: ${res.data}');
                  // Navigate to the next screen or show a success message
                } else {
                  // Handle login failure
                  print('Login failed: ${res?.data}');
                  // Show an error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                elevation: 5,
              ),
            ),
            SizedBox(height: 10),
            // Sign-up Text (optional)
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
