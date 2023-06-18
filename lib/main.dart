import 'package:flutter/material.dart';
import 'package:iot/pages/landing.dart';
import 'package:iot/pages/connect.dart';
import 'package:iot/pages/socket_switch.dart';

void main() => runApp(MaterialApp(
  title: "Welcome App",
  theme: ThemeData(
    primarySwatch: Colors.teal,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => LandingPage(),
    '/connect': (context) => Connect(),
    '/socket_toggle': (context) => SocketToggle(name: 'Bedroom',),
  },
));
