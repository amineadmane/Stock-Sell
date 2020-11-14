import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/Historydetail.dart';
import 'package:stocknsell/Screens/historyscreen.dart';

class HistoryItem extends StatefulWidget {
  final double screenWidth;
  final String date;
  final String client_id;
  final String clientnom;
  final double montant;
  final List<Produit> produits;

  final DocumentSnapshot documentSnapshot;

  HistoryItem({
    @required this.screenWidth,
    this.date,
    this.client_id,
    this.documentSnapshot,
    this.clientnom,
    this.montant,
    this.produits,
  });
  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  void initState() {
    super.initState();
  }

  String nb_article(List<Produit> _produits) {
    int nb = 0;

    for (var _produit in _produits) {
      nb += _produit.nbarticle;
    }
    return nb.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[400],
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HistoriquedetailPage(
                        screenWidth: widget.screenWidth,
                        date: widget.date,
                        client_id: widget.client_id,
                        clientnom: widget.clientnom,
                        montant: widget.montant.toDouble(),
                        produits: widget.produits,
                      )));
        },
        child: SizedBox(
            // height: 150.0,
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
                flex: 1,
                child: Image(image: AssetImage('assets/images/avatar.jpg'))),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Text(
                            widget.clientnom,
                            style: TextStyle(
                                fontFamily: 'Mom cake',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28.0),
                          ),
                          SizedBox(
                            width: widget.screenWidth * 0.4,
                            child: Divider(
                              thickness: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Articles vendues : " + nb_article(widget.produits),
                        style: TextStyle(
                            fontFamily: 'Mom cake',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.montant.toStringAsFixed(0) + " DA",
                          style: TextStyle(
                              fontFamily: 'Mom cake',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15.0),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                              fontFamily: 'Mom cake',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15.0),
                        )
                      ],
                    )
                  ],
                ))
          ]),
        )),
      ),
    );
  }
}
