import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/ClientSearch.dart';
import 'package:stocknsell/Screens/GestClients.dart';
import 'package:stocknsell/Screens/Historydetail.dart';
import 'package:stocknsell/Screens/Planning.dart';
import 'package:stocknsell/Screens/Stockscreen.dart';
import 'package:stocknsell/Screens/Vente.dart';
import 'package:stocknsell/Screens/homescreen.dart';
import 'package:stocknsell/Screens/AuthentificationScreen.dart';
import 'package:stocknsell/Screens/historyscreen.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/productaddscreen.dart';
import 'package:stocknsell/Screens/productdetailScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StocknSell());
}

class StocknSell extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MenuDashboardPage(),
        '/home': (context) => MenuDashboardPage(),
        HistoriquePage.id: (context) => HistoriquePage(),
        '/historydetail': (context) => HistoriquedetailPage(),
        '/client': (context) => Client(),
        '/stock': (context) => StockPage(),
        '/productdetail': (context) => ProductDetailPage(),
        '/productadd': (context) => ProductaddPage(),
        '/planning': (context) => Planning(),
        '/Clients': (context) => Clients(),
        '/vente' : (context) => VenteScreen(),
        '/search' : (context) => ClientSearch(),
      },
    );
  }
}
