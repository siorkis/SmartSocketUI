import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SocketToggle extends StatefulWidget {
  final String name;

  SocketToggle({required this.name});

  @override
  _SocketToggleState createState() => _SocketToggleState();
}

class _SocketToggleState extends State<SocketToggle> {
  bool isOn = false;
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6IlRvZGlyYXNjdUlsaWUiLCJFbWFpbCI6InRvZGlyYXNjdWlsaWVAZ21haWwuY29tIiwibmJmIjoxNjg2ODI0NDgzLCJleHAiOjE2ODY5MTA4ODMsImlhdCI6MTY4NjgyNDQ4M30.gAYDJdbHPUnixLBE6L5oQkSVMOwl0Y_Q8CJsSwUGKKE";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await performGetRequest();
      final parsedResponse = jsonDecode(response);
      final status = parsedResponse['state'];
      setState(() {
        isOn = status == true;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error if needed
    }
  }

  void toggleSocket() {
    setState(() {
      isOn = !isOn;
    });
    performPostRequest();
  }

  Future<String> performGetRequest() async {
    var url = Uri.parse('https://pbliotapi.fly.dev/api/state/05642d02-009d-479a-b43e-772994edd241');
    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Request was successful
      print(response.body);
      return response.body;// Print the response body
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  void performPostRequest() async {
    var url = Uri.parse('https://pbliotapi.fly.dev/api/state/change/05642d02-009d-479a-b43e-772994edd241');
    var headers = {'Authorization': 'Bearer $token'};
    // var body = '{"name": "John", "age": 30}';

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      // Request was successful
      print('POST request successful');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket ${widget.name}'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.6, // Adjust the fraction as per your preference
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle, // Make the container circular
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: isOn,
                    onChanged: (value) {
                      toggleSocket();
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    isOn ? 'On' : 'Off',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
