import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/Planning.dart';
import 'package:stocknsell/Screens/homescreen.dart';
import 'package:stocknsell/Screens/AuthentificationScreen.dart';
import 'package:stocknsell/Screens/GestClients.dart';

void main() => runApp(StocknSell());

class StocknSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MenuDashboardPage(),
        '/planning': (context) => Planning(),
        '/Clients' : (context) => Client(),
        '/Client' : (context) => Client(),
        '/home' : (context) => MenuDashboardPage(),
      },
    );
  }
}
