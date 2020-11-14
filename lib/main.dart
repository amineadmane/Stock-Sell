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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        MenuDashboardPage.id: (context) => MenuDashboardPage(),
        HistoriquePage.id: (context) => HistoriquePage(),
        HistoriquedetailPage.id: (context) => HistoriquedetailPage(),
        Client.idd: (context) => Client(),
        StockPage.id: (context) => StockPage(),
        ProductDetailPage.id: (context) => ProductDetailPage(),
        ProductaddPage.id: (context) => ProductaddPage(),
        Planning.id: (context) => Planning(),
        Clients.id: (context) => Clients(),
        VenteScreen.id: (context) => VenteScreen(),
        ClientSearch.id: (context) => ClientSearch(),
      },
    );
  }
}
