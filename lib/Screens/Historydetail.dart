import 'package:flutter/material.dart';
import 'package:stocknsell/Components/historyitem.dart';
import 'package:stocknsell/Screens/historyscreen.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HistoriquedetailPage extends StatefulWidget {
  static String id = '/historydetail';
  final double screenWidth;
  final String date;
  final String client_id;
  final String clientnom;
  final double montant;
  final List<Produit> produits;

  const HistoriquedetailPage(
      {Key key,
      this.screenWidth,
      this.date,
      this.client_id,
      this.clientnom,
      this.montant,
      this.produits})
      : super(key: key);

  @override
  _HistoriquedetailPageState createState() => _HistoriquedetailPageState();
}

class _HistoriquedetailPageState extends State<HistoriquedetailPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  String nb_article(List<Produit> _produits) {
    int nb = 0;

    for (var _produit in _produits) {
      nb += _produit.nbarticle;
    }
    return nb.toString();
  }

  String prom(Produit _produit) {
    if (_produit.baseprice == _produit.prixpromo) {
      return "Non";
    } else {
      return "Oui";
    }
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
      body: dashboard(context),
    );
  }

  Widget dashboard(context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
                Text("Détail de vente",
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: AssetImage('assets/images/cart.webp'),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        height: screenHeight * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: ListTile(
                                leading: Image(
                                  image: AssetImage('assets/images/avatar.jpg'),
                                ),
                                title: Text(
                                  widget.clientnom,
                                  style: TextStyle(
                                      fontFamily: 'Mom cake',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Text(
                              "Date de vente : " + widget.date,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Montant de vente : " +
                                  widget.montant.toStringAsFixed(2) +
                                  " DA",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Nombre d'article vendus : " +
                                  nb_article(widget.produits) +
                                  " articles",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Produits vendus",
                      style: TextStyle(
                          fontFamily: 'Mom cake',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    new ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: widget.produits.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Card(
                            color: Colors.blueGrey[400],
                            child: SizedBox(
                                // height: 150.0,
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/box.png'))),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    widget.produits[index].nom,
                                                    style: TextStyle(
                                                        fontFamily: 'Mom cake',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 28.0),
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.4,
                                                    child: Divider(
                                                      thickness: 2.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Articles vendues : " +
                                                        widget.produits[index]
                                                            .nbarticle
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Mom cake',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  ),
                                                  Text(
                                                    "Prix unitaire : " +
                                                        widget.produits[index]
                                                            .prixpromo
                                                            .toString() +
                                                        " DA",
                                                    style: TextStyle(
                                                        fontFamily: 'Mom cake',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  ),
                                                  Text(
                                                    "Montant : " +
                                                        widget.produits[index]
                                                            .couttotale
                                                            .toStringAsFixed(
                                                                2) +
                                                        " DA",
                                                    style: TextStyle(
                                                        fontFamily: 'Mom cake',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  ),
                                                  Text(
                                                    "Promotion : " +
                                                        prom(widget
                                                            .produits[index]),
                                                    style: TextStyle(
                                                        fontFamily: 'Mom cake',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                  ]),
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
