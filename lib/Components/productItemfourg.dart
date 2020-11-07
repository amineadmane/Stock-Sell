import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/productdetailScreen.dart';

class ProductItemFourg extends StatefulWidget {
  final String reference;
  final String marque;
  final dynamic baseprice;
  final dynamic nbunitfourgon;
  final dynamic nbunitstock;
  final dynamic promprice;
  final String prodid;
  final DocumentSnapshot documentSnapshot;
  final double screenWidth;
  ProductItemFourg(
      {@required this.reference,
      @required this.marque,
      @required this.baseprice,
      @required this.nbunitfourgon,
      @required this.nbunitstock,
      @required this.prodid,
      @required this.documentSnapshot,
      @required this.screenWidth,
      this.promprice});
  @override
  _ProductItemFourgState createState() => _ProductItemFourgState();
}

class _ProductItemFourgState extends State<ProductItemFourg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  marque: widget.marque,
                  reference: widget.reference,
                  baseprice: widget.baseprice.toString(),
                  nbunitfourgon: widget.nbunitfourgon.toString(),
                  nbunitstock: widget.nbunitstock.toString(),
                  prodid: widget.prodid,
                  promprice: widget.promprice.toString(),
                  documentSnapshot: widget.documentSnapshot,
                ),
              ));
        },
        child: Card(
          color: Colors.blueGrey[400],
          child: SizedBox(
              // height: 150.0,
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                                  widget.reference,
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
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Article restants : ' +
                                      widget.nbunitfourgon.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Mom cake',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13.0),
                                ),
                                Text(
                                  "Prix unitaire : " +
                                      widget.baseprice.toString() +
                                      " DA",
                                  style: TextStyle(
                                      fontFamily: 'Mom cake',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13.0),
                                ),
                                Text(
                                  "Prix promotionnel : " +
                                      widget.promprice.toString() +
                                      " DA",
                                  style: TextStyle(
                                      fontFamily: 'Mom cake',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ]),
          )),
        ),
      ),
    );
  }
}
