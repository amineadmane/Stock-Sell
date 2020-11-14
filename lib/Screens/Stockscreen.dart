import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';

import 'package:stocknsell/Components/productItem.dart';
import 'package:stocknsell/Components/productItemfourg.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/GestClients.dart';
import 'package:stocknsell/Screens/Planning.dart';
import 'package:stocknsell/Screens/historyscreen.dart';
import 'package:stocknsell/Screens/homescreen.dart';
import 'package:stocknsell/Services/database.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class StockPage extends StatefulWidget {
  static String id = "/stock";
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
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

  Color green = Colors.green;
  Color red = Colors.pink;
  String ajouter = 'Ajouter';
  String renetialiser = 'Réinitialiser';
  String buttontext = 'Ajouter';
  Color buttoncolor = Colors.green;
  IconData add = Icons.add_business_rounded;
  IconData minus = Icons.remove_shopping_cart_rounded;
  IconData buttonicon = Icons.add_business_rounded;
  String reference = 'reference';
  String marque = 'marque';
  String prix = 'promprice';
  String article = 'nbunitstock';
  String articlef = 'nbunitfourgon';
  String order1 = 'reference';
  String order2 = 'reference';
  int index = 0;
  int tag = 0;
  List<String> options = [
    'Référence',
    'Marque',
    'Article restants',
    'Prix',
  ];

  _openPopup(context) {
    Alert(
        context: context,
        title: "Filtres",
        style: AlertStyle(
            backgroundColor: Colors.grey[200],
            titleStyle: TextStyle(
                fontFamily: 'Mom cake',
                fontWeight: FontWeight.bold,
                fontSize: 34)),
        content: SizedBox(
          width: screenWidth,
          height: screenHeight * 0.20,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text(
                  "Trier par :",
                ),
                Expanded(
                  child: ChipsChoice<int>.single(
                    value: tag,
                    onChanged: (val) {
                      switch (val) {
                        case 0:
                          {
                            order1 = reference;
                            order2 = reference;
                          }
                          break;
                        case 1:
                          {
                            order1 = marque;
                            order2 = marque;
                          }
                          break;
                        case 2:
                          {
                            order1 = article;
                            order2 = articlef;
                          }
                          break;
                        case 3:
                          {
                            order1 = prix;
                            order2 = prix;
                          }
                          break;
                      }
                      setState(() {
                        tag = val;
                      });
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    choiceStyle: C2ChoiceStyle(
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buttons: [
          DialogButton(
            color: Colors.pink,
            onPressed: () {
              order1 = reference;
              order2 = reference;
              setState(() {});
              Navigator.pop(context);
            },
            child: Text(
              "Annuler",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          DialogButton(
            color: green,
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: Text(
              "Filtrer",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          )
        ]).show();
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
                      Navigator.pushNamed(context, MenuDashboardPage.id);
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
                    setState(() {
                      _controller.reverse();
                      isCollapsed = !isCollapsed;
                    });
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
              height: screenHeight,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 37),
              child: SizedBox(
                height: screenHeight * 0.1,
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
                        Text("Stock",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                        IconButton(
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage:
                                  AssetImage('assets/images/search.png'),
                            ),
                            onPressed: () {
                              _openPopup(context);
                              setState(() {});
                            })
                      ],
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: new Scaffold(
                          floatingActionButton: FloatingActionButton.extended(
                            onPressed: () async {
                              if (index == 0) {
                                Navigator.pushNamed(context, '/productadd');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Rénitialiser le stock ?'),
                                      content: Text(
                                          'Voulez-vous vraiment rénitialiser le stock du fourgon ?\nTout les articles dans le fourgon seront transmis au dépot !!'),
                                      actions: [
                                        FlatButton(
                                          textColor: Color(0xFF6200EE),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ANNULER'),
                                        ),
                                        FlatButton(
                                          textColor: Color(0xFF6200EE),
                                          onPressed: () async {
                                            var snapshots =
                                                await FirebaseFirestore.instance
                                                    .collection('produit')
                                                    .where('nbunitfourgon',
                                                        isGreaterThanOrEqualTo:
                                                            1)
                                                    .get();
                                            for (var ventes in snapshots.docs) {
                                              DatabaseService().updateproduct(
                                                  ventes.id,
                                                  ventes['reference'],
                                                  ventes['marque'],
                                                  ventes['baseprice'],
                                                  ventes['nbunitstock'] +
                                                      ventes['nbunitfourgon'],
                                                  ventes['promprice'],
                                                  0,
                                                  ventes['buyprice']);
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text('ACCEPTER'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                setState(() {});
                              }
                            },
                            label: Text(buttontext),
                            icon: Icon(buttonicon),
                            backgroundColor: Colors.white,
                            foregroundColor: buttoncolor,
                            splashColor: buttoncolor,
                            hoverColor: buttoncolor,
                          ),
                          backgroundColor: backgroundColor,
                          appBar: TabBar(
                            onTap: (value) {
                              index = value;
                              if (value == 0) {
                                buttontext = ajouter;
                                buttoncolor = green;
                                buttonicon = add;
                              } else {
                                buttontext = renetialiser;
                                buttoncolor = red;
                                buttonicon = minus;
                              }
                              setState(() {});
                            },
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            tabs: [
                              Tab(
                                  text: 'Dépot',
                                  icon:
                                      Icon(Icons.store_mall_directory_rounded)),
                              Tab(
                                  text: 'Fourgon',
                                  icon: Icon(
                                    Icons.directions_bus_rounded,
                                  ))
                            ],
                          ),
                          body: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _mystreambuilder(context, order1),
                              _mystreambuilderfourgon(context, order2)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _mystreambuilder(BuildContext context, String order) {
  return Container(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("produit")
          .orderBy(order, descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return ProductItem(
                    reference: data['reference'],
                    marque: data['marque'],
                    baseprice: data['baseprice'],
                    nbunitfourgon: data['nbunitfourgon'],
                    nbunitstock: data['nbunitstock'],
                    promprice: data['promprice'],
                    prodid: data.id,
                    buyprice: data['buyprice'],
                    screenWidth: MediaQuery.of(context).size.width,
                    documentSnapshot: data,
                  );
                },
              );
      },
    ),
  );
}

Widget _mystreambuilderfourgon(BuildContext context, String order) {
  return Container(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("produit")
          .where('nbunitfourgon', isGreaterThanOrEqualTo: 1)
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return ProductItemFourg(
                    reference: data['reference'],
                    marque: data['marque'],
                    baseprice: data['baseprice'],
                    nbunitfourgon: data['nbunitfourgon'],
                    nbunitstock: data['nbunitstock'],
                    promprice: data['promprice'],
                    prodid: data.id,
                    buyprice: data['buyprice'],
                    screenWidth: MediaQuery.of(context).size.width,
                    documentSnapshot: data,
                  );
                },
              );
      },
    ),
  );
}
