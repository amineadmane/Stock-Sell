import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stocknsell/Services/database.dart';

class ProductItem extends StatefulWidget {
  final String client_id;
  final String client_name;
  final String id;
  final String marque;
  final double unitprice;
  int nbunitfourgon;
  final int nbunitstock;
  final double prixpromotionnel;
  ProductItem({
    this.id,
    this.marque,
    this.unitprice,
    this.nbunitfourgon,
    this.nbunitstock,
    this.prixpromotionnel,
    this.client_id,
    this.client_name,
  });
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  var screenHeight;
  var screenWidth;
  double _value = 0;
  int _restant;
  double _couttotale = 0;
  double _prixunitaire;
  minusrestant() {
    setState(() => _restant = _restant - 1);
  }

  plusrestat() {
    setState(() {
      _restant = _restant + 1;
    });
  }

  createalertedialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Annulation"),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "Voulez-vous vraiment Annuler les ventes de ce produit d'aujourd'hui a ce client?"),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red,
                            elevation: 4,
                            onPressed: () {
                              String currentdate = DateFormat('dd-MM-yyy')
                                  .format(DateTime.now())
                                  .toString();
                              DatabaseService().deletevente(
                                  widget.client_id, widget.id, currentdate);
                              Navigator.of(context).pop();
                            },
                            child: Text("Annuler")),
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.green,
                            elevation: 4,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Retour")),
                      ],
                    ),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    _prixunitaire = widget.unitprice;
    _restant = widget.nbunitfourgon;
    double _prixprom = widget.prixpromotionnel;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Card(
        color: Colors.blueGrey[400],
        child: SizedBox(
            // height: 150.0,
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
                flex: 1,
                child: Image(image: AssetImage('assets/images/box.png'))),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          widget.marque,
                          style: TextStyle(
                              fontFamily: 'Mom cake',
                              fontWeight: FontWeight.bold,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Articles restants : ",
                              style: TextStyle(
                                  fontFamily: 'Mom cake',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0),
                            ),
                            Text(
                              "$_restant",
                              style: TextStyle(
                                  fontFamily: 'Mom cake',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Text(
                          "Prix unitaire : $_prixunitaire",
                          style: TextStyle(
                              fontFamily: 'Mom cake',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15.0),
                        ),
                        Text(
                          "Prix promotionnel : $_prixprom",
                          style: TextStyle(
                              fontFamily: 'Mom cake',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15.0),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Divider(
                            thickness: 2.0,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.orange,
                              ),
                              tooltip: 'ajouter',
                              onPressed: () {
                                setState(() {
                                  if (_restant > 0) {
                                    _value += 1;
                                    minusrestant();
                                    widget.nbunitfourgon = _restant;
                                    _couttotale =
                                        (_value * widget.prixpromotionnel)
                                            .toDouble();
                                  }
                                });
                              },
                            ),
                            Text(
                              _value.toStringAsFixed(0),
                              style: TextStyle(
                                  fontFamily: 'Mom cake',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 28.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.minimize, color: Colors.orange),
                              tooltip: 'diminuer',
                              onPressed: () {
                                setState(() {
                                  if (_value != 0) {
                                    _value -= 1;
                                    plusrestat();
                                    widget.nbunitfourgon = _restant;
                                    _couttotale =
                                        (_value * widget.unitprice).toDouble();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            children: [
                              Text(
                                "Cout Total :",
                                style: TextStyle(
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              Text(
                                _couttotale.toStringAsFixed(2),
                                style: TextStyle(
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.green,
                              onPressed: () {
                                if (_value != 0) {
                                  String currentdate = DateFormat('dd-MM-yyy')
                                      .format(DateTime.now())
                                      .toString();
                                  DatabaseService().savevente(
                                      widget.client_id,
                                      widget.client_name,
                                      currentdate,
                                      widget.id,
                                      widget.marque,
                                      widget.unitprice,
                                      widget.prixpromotionnel,
                                      _couttotale,
                                      _value.toInt(),
                                      widget.id,
                                      _restant);
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Operation de vente effectue avec succes'),
                                  );
                                  // Find the Scaffold in the widget tree and use
                                  // it to show a SnackBar.
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    _value = 0;
                                    _couttotale = 0;
                                  });
                                }
                              },
                              child: const Text(
                                'Valider',
                                style: TextStyle(
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red,
                              onPressed: () {
                                createalertedialog(context);
                              },
                              child: const Text(
                                'Annuler',
                                style: TextStyle(
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
