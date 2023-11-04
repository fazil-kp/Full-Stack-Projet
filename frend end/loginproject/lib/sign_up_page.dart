import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginproject/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // variable to store the response data
  var responsed = '';

  // Declare the allData map at the class level
  Map<String, String> allData = {
    "username": "",
    "email": "",
    "password": "",
  };

  Future post(Map<String, String> allData) async {
    try {
      final url = Uri.parse('http://localhost:3000/api/data/postdata');
      final headers = {'Content-Type': 'application/json'};
      final jsonData = jsonEncode(allData);
      final response = await http.post(url, headers: headers, body: jsonData);

      print("Data status code : ${response.statusCode}");
      if (response.statusCode == 200) {
        print("data body ${response.body}");
      } else {
        print("Error ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error = $e");
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: username,
                prefixIcon: Icons.person,
                label: "Enter User Name",
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: email,
                prefixIcon: Icons.email,
                label: "Enter Email",
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: password,
                prefixIcon: Icons.lock,
                label: "Enter Password",
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Access the user input:
                  final enteredUsername = username.text;
                  final enteredEmail = email.text;
                  final enteredPassword = password.text;

                  // Set the values in the allData map
                  allData["username"] = enteredUsername;
                  allData["email"] = enteredEmail;
                  allData["password"] = enteredPassword;

                  // Call the post method to send data to the backend
                  post(allData);
                },
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 30),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String label,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
