import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:stocknsell/Components/DownSelect.dart';
import 'package:stocknsell/Components/DownSelect2.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:stocknsell/Components/historyitem.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HistoriquePage extends StatefulWidget {
  static String id = "/history";
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Vente vente;
  List<Vente> list = List();
  List<Produit> produits = List();
  Produit produit = Produit();

  @override
  void initState() {
    getVente();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    super.initState();
  }

  void getVente() async {
    bool trouve = false;
    await for (var snapshots
        in FirebaseFirestore.instance.collection('vente').snapshots()) {
      for (var ventes in snapshots.docs) {
        if ((ventes['client_id'] != null) && (ventes['date'] != null)) {
          if (list.isNotEmpty) {
            for (var sells in list) {
              if ((sells.clientid == ventes['client_id']) &&
                  (sells.date == ventes['date'])) {
                trouve = true;
                produit = Produit();
                produit.baseprice = ventes['baseprice'];
                produit.couttotale = ventes['couttotale'].round();
                produit.nbarticle = ventes['nb_product'].round();
                produit.prixpromo = ventes['prixpromo'].round();
                produit.nom = ventes['marque'];
                sells.produits.add(produit);
                sells.montant += produit.couttotale.round();
              }
            }
            if (!trouve) {
              vente = Vente(
                clientid: ventes['client_id'],
                clientnom: ventes['client_name'],
                date: ventes['date'],
                data: ventes,
                montant: ventes['couttotale'].round(),
              );
              produit = Produit();
              produit.baseprice = ventes['baseprice'].round();
              produit.couttotale = ventes['couttotale'].round();
              produit.nbarticle = ventes['nb_product'].round();
              produit.prixpromo = ventes['prixpromo'].round();
              produit.nom = ventes['marque'];
              vente.produits = List<Produit>();
              vente.produits.add(produit);
              list.add(vente);
            }
            trouve = false;
          } else {
            vente = Vente(
              clientid: ventes['client_id'],
              clientnom: ventes['client_name'],
              date: ventes['date'],
              data: ventes,
              montant: ventes['couttotale'].round(),
            );
            vente.produits = List<Produit>();
            produit = Produit();
            produit.baseprice = ventes['baseprice'].round();
            produit.couttotale = ventes['couttotale'].round();
            produit.nbarticle = ventes['nb_product'].round();
            produit.prixpromo = ventes['prixpromo'].round();
            produit.nom = ventes['marque'];
            vente.produits.add(produit);
            list.add(vente);
          }
        }
      }
    }
    setState(() {});
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Filtrer'),
        icon: Icon(Icons.filter_alt_rounded),
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal[300],
        splashColor: Colors.teal[300],
        hoverColor: Colors.teal[300],
        onPressed: () {
          _openPopup(context);
        },
      ),
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
  final String date = 'date';
  final String client = 'client';
  final String montant = 'montant';
  String order = 'date';

  int tag = 0;
  List<String> options = [
    'Date',
    'Client',
    'Montant',
  ];
  String e9lab(String me9louba) {
    String a = me9louba[6];
    String b = me9louba[7];
    String c = me9louba[8];
    String d = me9louba[9];
    String e = '-';
    String f = me9louba[3];
    String g = me9louba[4];
    String h = '-';
    String i = me9louba[0];
    String j = me9louba[1];
    return a + b + c + d + e + f + g + h + i + j;
  }

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
                            order = date;
                          }
                          break;
                        case 1:
                          {
                            order = client;
                          }
                          break;
                        case 2:
                          {
                            order = montant;
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
              order = client;
              setState(() {
                list.sort((a, b) => a.clientnom.compareTo(b.clientnom));
              });
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
              setState(() {
                switch (order) {
                  case 'date':
                    {
                      list.sort((a, b) => DateTime.parse(e9lab(b.date))
                          .compareTo(DateTime.parse(e9lab(a.date))));
                    }
                    break;
                  case 'montant':
                    {
                      list.sort((a, b) => b.montant.compareTo(a.montant));
                    }
                    break;
                  case 'client':
                    {
                      list.sort((a, b) => a.clientnom.compareTo(b.clientnom));
                    }
                    break;
                }
              });
              print(e9lab('07-08-2019'));
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
                      child: Text("Dynamique textttttt",
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
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    leading: Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
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
                    title: Text("Stock",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    leading: Icon(
                      Icons.store_mall_directory_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/stock');
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text("Clients",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  leading: Icon(
                    Icons.perm_contact_cal_rounded,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text("Planification",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  leading: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                  ),
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
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    leading: Icon(
                      Icons.history_rounded,
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
                ListTile(
                  title: Text("Parametres",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  leading: Icon(
                    Icons.settings_applications_rounded,
                    color: Colors.white,
                  ),
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 37),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                        Text("Historique",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                        IconButton(
                            color: Colors.white,
                            icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.refresh_rounded,
                                color: Colors.teal[300],
                              ),
                            ),
                            onPressed: () {
                              setState(() {});
                            })
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.87,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(
                            client_id: list[index].clientid,
                            date: list[index].date,
                            clientnom: list[index].clientnom,
                            screenWidth: MediaQuery.of(context).size.width,
                            documentSnapshot: list[index].data,
                            montant: list[index].montant,
                            produits: list[index].produits,
                          );
                        },
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

class Vente {
  DocumentSnapshot data;
  String clientid;
  String clientnom;
  String date;
  int montant;
  List<Produit> produits;
  Vente(
      {@required this.clientid,
      this.date,
      this.data,
      this.clientnom,
      this.produits,
      this.montant});
}

class Produit {
  String nom;
  int baseprice;
  int prixpromo;
  int couttotale;
  int nbarticle;
  Produit(
      {this.baseprice,
      this.nbarticle,
      this.nom,
      this.couttotale,
      this.prixpromo});
}
