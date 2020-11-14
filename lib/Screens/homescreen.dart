import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/ClientItem.dart';
import 'package:intl/intl.dart';
import 'package:stocknsell/Screens/GestClients.dart';
import 'package:stocknsell/Screens/Planning.dart';
import 'package:stocknsell/Screens/Stockscreen.dart';
import 'package:stocknsell/Screens/historyscreen.dart';
import 'package:stocknsell/Services/database.dart';

import 'DayItem.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  static String id = '/home';
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _ChiffreAffaire = 0;
  int _articlevendu = 0;
  int _nbclientavisiter = 0;
  int _Prodrestfourgon = 0;
  String _productname1 = "Produit1";
  String _nbvente1 = "Nb vente 1";
  String _productname2 = "Produit2";
  String _nbvente2 = "Nb vente 2";
  String _productname3 = "Produit3";
  String _nbvente3 = "Nb vente 3";

  raffraichirCA(double value) {
    setState(() => _ChiffreAffaire = value);
  }

  raffraichirAV(int value) {
    setState(() => _articlevendu = value);
  }

  raffraichirfourgon(int value) {
    setState(() => _Prodrestfourgon = value);
  }

  raffraichirprod1(String value) {
    setState(() => _productname1 = value);
  }

  raffraichirnb1(String value) {
    setState(() => _nbvente1 = value);
  }

  raffraichirprod2(String value) {
    setState(() => _productname2 = value);
  }

  raffraichirnb2(String value) {
    setState(() => _nbvente2 = value);
  }

  raffraichirprod3(String value) {
    setState(() => _productname3 = value);
  }

  raffraichirnb3(String value) {
    setState(() => _nbvente3 = value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("Bienvenu Zaki !",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Fredoka One')),
                    )),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                    child: ListTile(
                      title: Text("Acceuil",
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                      leading: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.reverse();
                        isCollapsed = !isCollapsed;
                      });
                    }),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Stock",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.store_mall_directory_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, StockPage.id);
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Clients",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.perm_contact_cal_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Clients.id);
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Planification",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Planning.id);
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Historique",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.history_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, HistoriquePage.id);
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    String covertinttoday(int day) {
      String jour = "";
      if (day == 1) jour = "Lundi";
      if (day == 2) jour = "Mardi";
      if (day == 3) jour = "Mercredi";
      if (day == 4) jour = "Jeudi";
      if (day == 5) jour = "Vendredi";
      if (day == 6) jour = "Samedi";
      if (day == 7) jour = "dimanche";
      return jour;
    }

    double ChiffreAffaire;
    final today = DateTime.now().weekday;
    List<dynamic> secteurs = new List<String>();
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                            } else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("Acceuil",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Secteur a visiter Aujourd'hui",
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("planification")
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot data =
                                          snapshot.data.docs[index];
                                      secteurs = data[covertinttoday(today)];
                                      return DayItem(Secteurs: [secteurs]);
                                    },
                                  );
                          },
                        ),
                        const Divider(
                          color: Colors.white70,
                          height: 20,
                          thickness: 2,
                        ),
                        Center(
                          child: Text(
                            "Client a visiter aujourd'hui ",
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.4,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("clients")
                                .snapshots(),
                            builder: (context, snapshot) {
                              _nbclientavisiter = 0;
                              return !snapshot.hasData
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot data =
                                            snapshot.data.docs[index];
                                        if (secteurs
                                            .contains(data['Secteur'])) {
                                          _nbclientavisiter =
                                              _nbclientavisiter + 1;
                                          return ClientItem(
                                            nom: data['nom'],
                                            documentSnapshot: data,
                                            id: data.id,
                                            url: data['URL'],
                                            phone: data['phone'],
                                            email: data['email'],
                                            secteur: data['Secteur'],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      });
                            },
                          ),
                        ),
                        const Divider(
                          color: Colors.white70,
                          height: 20,
                          thickness: 2,
                        ),
                        Center(
                          child: Text(
                            "Tournée d'aujourd'hui ",
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Center(
                            child: Card(
                          margin: EdgeInsets.only(bottom: 30, top: 10),
                          elevation: 5,
                          color: Colors.white70,
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_bus_rounded,
                                color: Colors.green,
                                size: 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                color: Colors.black45,
                                height: 200,
                                width: 2,
                              ), //Divider
                              Container(
                                  child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Nombre de Clients a Visiter : ",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          _nbclientavisiter.round().toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "Produits restants au fourgon : ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _Prodrestfourgon.round().toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.orange,
                                            onPressed: () async {
                                              int count = 0;
                                              await DatabaseService()
                                                  .getnbproduitrestantfourgon()
                                                  .then((QuerySnapshot
                                                          querySnapshot) =>
                                                      {
                                                        querySnapshot.docs
                                                            .forEach((doc) {
                                                          count = count + 1;
                                                        })
                                                      });
                                              raffraichirfourgon(count);
                                            },
                                            child: const Text(
                                              'Raffraichir',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white70,
                          height: 20,
                          thickness: 2,
                        ),
                        Center(
                          child: Text(
                            "Finance",
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Center(
                            child: Card(
                          margin: EdgeInsets.only(bottom: 30, top: 10),
                          elevation: 5,
                          color: Colors.white70,
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                                size: 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                color: Colors.black45,
                                height: 200,
                                width: 2,
                              ), //Divider
                              Container(
                                  child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Articles Vendus : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          _articlevendu.round().toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "CA : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _ChiffreAffaire.round().toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                          textColor: Colors.white,
                                          color: Colors.orange,
                                          onPressed: () async {
                                            double som = 0;
                                            int articlevendu = 0;
                                            await DatabaseService()
                                                .getTotaltoday()
                                                .then((QuerySnapshot
                                                        querySnapshot) =>
                                                    {
                                                      querySnapshot.docs
                                                          .forEach((doc) {
                                                        som = som +
                                                            doc['couttotale'];
                                                        articlevendu =
                                                            articlevendu +
                                                                doc['nb_product'];
                                                      })
                                                    });
                                            raffraichirCA(som);
                                            raffraichirAV(articlevendu);
                                          },
                                          child: const Text(
                                            'Raffraichir',
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white70,
                          height: 20,
                          thickness: 2,
                        ),
                        Center(
                          child: Text(
                            "Produits les plus achetes",
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Center(
                            child: Card(
                          margin: EdgeInsets.only(bottom: 30, top: 10),
                          elevation: 5,
                          color: Colors.white70,
                          child: Row(
                            children: [
                              Icon(
                                Icons.article,
                                color: Colors.green,
                                size: 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                color: Colors.black45,
                                height: 200,
                                width: 2,
                              ), //Divider
                              Container(
                                  child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("$_productname1 : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          "$_nbvente1 ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "$_productname2 : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "$_nbvente2",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "$_productname3 : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "$_nbvente3",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Center(
                                          child: RaisedButton(
                                            textColor: Colors.white,
                                            color: Colors.orange,
                                            onPressed: () async {
                                              List<String> list =
                                                  new List<String>();
                                              await DatabaseService()
                                                  .getmostselledproducts()
                                                  .then((QuerySnapshot
                                                          querySnapshot) =>
                                                      {
                                                        querySnapshot.docs
                                                            .forEach((doc) {
                                                          list.add(
                                                              doc['reference']
                                                                  .toString());
                                                          list.add(
                                                              doc['nbvente']
                                                                  .toString());
                                                        })
                                                      });
                                              raffraichirprod1(list[0]);
                                              raffraichirnb1(list[1]);
                                              raffraichirprod2(list[2]);
                                              raffraichirnb2(list[3]);
                                              raffraichirprod3(list[4]);
                                              raffraichirnb3(list[5]);
                                            },
                                            child: const Text(
                                              'Raffraichir',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )),
                      ],
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
