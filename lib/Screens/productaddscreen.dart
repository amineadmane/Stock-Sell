import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stocknsell/Screens/Stockscreen.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:toggle_switch/toggle_switch.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class ProductaddPage extends StatefulWidget {
  static String id = "/productadd";
  @override
  _ProductaddPageState createState() => _ProductaddPageState();
}

class _ProductaddPageState extends State<ProductaddPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  bool enable = false;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  dynamic reference;
  dynamic marque;
  dynamic baseprice;
  dynamic nbunitfourgon;
  dynamic nbunitstock;
  dynamic promotionratio = 0;
  dynamic promprix;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void alertPos() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opération fffectuée !"),
            content: Text("Produit ajouté au stock avec succés"),
            actions: [
              FlatButton(
                  child: Text("Retour"),
                  onPressed: () {
                    Navigator.pushNamed(context, StockPage.id);
                  }),
            ],
          );
        });
  }

  void alertNgtv() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur !!"),
            content: Text("Veuillez vérifier les informations fournies"),
            actions: [
              FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: dashboard(context),
    );
  }

  dashboard(context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_backspace_rounded,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text("Ajouter un produit",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage: AssetImage('assets/images/Boxx.png'),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  right: 16,
                  left: 16,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    bottom: 8.0,
                    right: 16,
                  ),
                  height: screenHeight * 0.75,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          reference = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Réference',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          marque = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Marque',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          baseprice = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Prix de vente',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Promotion :",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          ToggleSwitch(
                            initialLabelIndex: !enable ? 1 : 0,
                            minWidth: 90.0,
                            cornerRadius: 20.0,
                            activeBgColor: Colors.cyan,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['YES', 'NO'],
                            icons: [
                              FontAwesomeIcons.check,
                              FontAwesomeIcons.times
                            ],
                            activeBgColors: [Colors.green, Colors.pink],
                            onToggle: (index) {
                              enable = !enable;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        enabled: enable,
                        onChanged: (value) {
                          promprix = value;
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Prix Promotionnel',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          nbunitstock = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Nombre des articles',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15)),
                          ),
                          alignment: Alignment.center,
                          width: screenWidth * 0.41,
                          height: 45,
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Mom cake',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ))),
                  TextButton(
                      child: Container(
                          height: 45,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15)),
                          ),
                          alignment: Alignment.center,
                          width: screenWidth * 0.41,
                          child: Text(
                            "Ajouter",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Mom cake',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                      onPressed: () {
                        if ((reference != null &&
                                marque != null &&
                                baseprice != null &&
                                nbunitstock != null) &&
                            (!enable)) {
                          DatabaseService().addproductstock(
                              reference,
                              marque,
                              int.parse(baseprice),
                              int.parse(nbunitstock),
                              int.parse(baseprice));
                          alertPos();
                        } else if ((reference != null &&
                                marque != null &&
                                baseprice != null &&
                                nbunitstock != null) &&
                            (promprix != null) &&
                            (enable)) {
                          if ((promprix != 0) &&
                              (promotionratio != "") &&
                              (int.parse(promprix) < int.parse(baseprice))) {
                            promprix = int.tryParse(promprix);
                            baseprice = int.tryParse(baseprice);
                            DatabaseService().addproductstock(
                              reference,
                              marque,
                              baseprice,
                              int.tryParse(nbunitstock),
                              promprix,
                            );
                            alertPos();
                          } else {
                            alertNgtv();
                          }
                        } else {
                          alertNgtv();
                        }
                      }),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
