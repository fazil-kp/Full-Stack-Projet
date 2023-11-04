import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String token;
  final String userId;

  const HomePage({Key? key, required this.token, required this.userId})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? responseData; // Modify the type to accept a Map
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    fetchData();
  }

  Future fetchData() async {
    try {
      final url = Uri.parse(
          'http://localhost:3000/api/crud/userProfile/$userId');
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);

      print("Data status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Data body ${response.body}");
        final decodedResponse =
            jsonDecode(response.body); // Parse JSON response

        setState(() {
          this.responseData =
              decodedResponse; // Update the responseData variable
        });
      } else {
        print("Error ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error = $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the Home Page!"),
            SizedBox(height: 20),
            Text("UserId: $userId"),
            if (responseData != null)
              Container(
                child: Column(
                  children: [
                    Text(
                        "Name: ${responseData!['name']}"), // Access 'name' from responseData
                    Text(
                        "Email: ${responseData!['email']}"), // Access 'email' from responseData
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
