import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stocknsell/Screens/Stockscreen.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:toggle_switch/toggle_switch.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class ProductDetailPage extends StatefulWidget {
  final String reference;
  final String marque;
  final dynamic baseprice;
  final dynamic nbunitfourgon;
  final dynamic nbunitstock;
  final dynamic promprice;
  final String prodid;
  final DocumentSnapshot documentSnapshot;
  ProductDetailPage(
      {@required this.reference,
      @required this.marque,
      @required this.baseprice,
      @required this.nbunitfourgon,
      @required this.nbunitstock,
      @required this.documentSnapshot,
      @required this.prodid,
      @required this.promprice});
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  var reference;
  var marque;
  var baseprice;
  var nbunitfourgon;
  var nbunitstock;
  var promprice;
  bool enable = false;
  @override
  void initState() {
    super.initState();
    if (widget.baseprice == widget.promprice) {
      enable = false;
    } else {
      enable = true;
    }
    reference = widget.reference;
    marque = widget.marque;
    baseprice = widget.baseprice;
    nbunitfourgon = widget.nbunitfourgon;
    nbunitstock = widget.nbunitstock;
    promprice = widget.promprice;
  }

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;

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
            title: Text("Opération éffectuée !"),
            content: Text("Produit ajouté au stock avec succées"),
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
            content: Text("Veuillez vérifier les information fournies"),
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
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
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
                      Text("Détail du produit",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      IconButton(
                        splashColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Supprimer l\'artice ?'),
                                content: Text(
                                    'Voulez vous vraiment suprrimer larticle'),
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
                                    onPressed: () {
                                      DatabaseService()
                                          .deleteproduct(widget.prodid);
                                      Navigator.pushNamed(
                                          context, StockPage.id);
                                    },
                                    child: Text('ACCEPTER'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundImage:
                              AssetImage('assets/images/delete.ico'),
                        ),
                      )
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
                            initialValue: reference,
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
                            initialValue: marque,
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
                            initialValue: baseprice,
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
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
                            initialValue: promprice,
                            enabled: enable,
                            onChanged: (value) {
                              promprice = value;
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
                            initialValue: nbunitstock,
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
                              labelText: 'Nombre des articles dans le stock',
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
                            initialValue: nbunitfourgon,
                            style: TextStyle(color: Colors.white),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              nbunitfourgon = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Nombre des articles dans le fourgon',
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
                          onPressed: () {
                            if ((reference != "") &&
                                (marque != "") &&
                                (baseprice != "") &&
                                (nbunitstock != "") &&
                                (!enable) &&
                                (nbunitfourgon != "") &&
                                (int.tryParse(nbunitstock) >=
                                    (int.tryParse(nbunitfourgon) -
                                        int.parse(widget.nbunitfourgon)))) {
                              if (widget.nbunitfourgon != nbunitfourgon) {
                                var diff = int.tryParse(nbunitfourgon) -
                                    int.parse(widget.nbunitfourgon);
                                nbunitstock = (int.tryParse(nbunitstock) - diff)
                                    .toString();
                              }
                              print(nbunitfourgon);
                              DatabaseService().updateproduct(
                                widget.prodid,
                                reference,
                                marque,
                                int.parse(baseprice),
                                int.parse(nbunitstock),
                                int.parse(baseprice),
                                int.parse(nbunitfourgon),
                              );
                              alertPos();
                            } else if ((reference != "") &&
                                (marque != "") &&
                                (baseprice != "") &&
                                (nbunitstock != "") &&
                                (promprice != "") &&
                                (promprice != "") &&
                                (nbunitfourgon != "") &&
                                (enable) &&
                                (nbunitfourgon != "") &&
                                (int.tryParse(promprice) <=
                                    int.tryParse(baseprice)) &&
                                (int.tryParse(nbunitstock) >=
                                    (int.tryParse(nbunitfourgon) -
                                        int.parse(widget.nbunitfourgon)))) {
                              if (widget.nbunitfourgon != nbunitfourgon) {
                                var diff = int.tryParse(nbunitfourgon) -
                                    int.parse(widget.nbunitfourgon);

                                nbunitstock = (int.tryParse(nbunitstock) - diff)
                                    .toString();
                              }

                              DatabaseService().updateproduct(
                                widget.prodid,
                                reference,
                                marque,
                                int.tryParse(baseprice),
                                int.tryParse(nbunitstock),
                                int.tryParse(promprice),
                                int.tryParse(nbunitfourgon),
                              );
                              alertPos();
                            } else {
                              alertNgtv();
                            }
                          },
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
                                "Modifier",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ))),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}