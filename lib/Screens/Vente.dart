import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/ProductItem.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class VenteScreen extends StatefulWidget {
  static String id = '/vente';
  @override
  _VenteScreenState createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {
  final Color backgroundColor = Color(0xFF4A4A58);
  double screenWidth, screenHeight;
  pw.Document doc;

  Future<void> printticket(String client_id, String client_name) async {
    doc = pw.Document();
    Vente vente = Vente();
    vente.produits = List();
    var date = DateFormat.yMd().add_jm().format(DateTime.now()).toString();
    vente.montant = 0;
    await DatabaseService()
        .todaystransaction(client_id)
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((prod) {
                Produit produit = Produit();
                produit.reference = prod['marque'];
                produit.prixpromo = prod['prixpromo'];
                produit.couttotale = prod['couttotale'];
                produit.nbarticle = prod['nb_product'];
                vente.produits.add(produit);
                vente.montant += produit.couttotale;
              })
            });
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Zaki Delivery',
                          style: pw.TextStyle(fontSize: 8)),
                      pw.Text('Tel : 0552962244',
                          style: pw.TextStyle(fontSize: 8))
                    ]),
                pw.Align(
                    child: pw.Text('Bon de vente',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 13.5))),
                pw.Text('Pour : $client_name',
                    style: pw.TextStyle(fontSize: 10)),
                pw.Text('Le ' + date + '\n', style: pw.TextStyle(fontSize: 9)),
                pw.Text('Designation article X Qte       P.U          P.T',
                    style: pw.TextStyle(fontSize: 7)),
                pw.Text('---------------------------------'),
                pw.ListView.builder(
                    itemBuilder: (context, index) {
                      return pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Expanded(
                              flex: 3,
                              child: pw.Text(
                                  vente.produits[index].reference.toString() +
                                      ' X ' +
                                      vente.produits[index].nbarticle
                                          .toString(),
                                  style: pw.TextStyle(fontSize: 7)),
                            ),
                            pw.Expanded(
                                child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                          vente.produits[index].prixpromo
                                              .toStringAsFixed(2),
                                          style: pw.TextStyle(fontSize: 7)),
                                      pw.Text(
                                          vente.produits[index].couttotale
                                              .toStringAsFixed(2),
                                          style: pw.TextStyle(fontSize: 7))
                                    ]),
                                flex: 2),
                          ]);
                    },
                    itemCount: vente.produits.length),
                pw.Text('---------------------------------'),
                pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                        'Total : ' + vente.montant.toStringAsFixed(2),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 11)))
              ]);
          // Center
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    final clientdetails details = ModalRoute.of(context).settings.arguments;
    final String client_id = details.id;
    final String client_name = details.name;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 100),
            child: Text(
              "Vente",
            )),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.8,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("produit")
                  .where('nbunitfourgon', isGreaterThan: 0)
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
                            id: data.id,
                            marque: data['reference'],
                            unitprice: data['baseprice'].toDouble(),
                            nbunitfourgon: data['nbunitfourgon'],
                            prixpromotionnel: data['promprice'].toDouble(),
                            client_id: client_id,
                            client_name: client_name,
                          );
                        },
                      );
              },
            ),
          ),
          Container(
            height: 50,
            width: 200,
            child: Center(
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                onPressed: () async {
                  printticket(client_id, client_name);
                  // Navigator.pushNamed(context, PrinterPage.id);
                },
                child: Text(
                  'Extraire Facture',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mom cake'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class productdetails {
  String product_id;
  String product_name;
  int nb_product;
  double baseprice;
  double prixpromotionnel;
  productdetails({
    @required this.product_id,
    @required this.product_name,
    @required this.baseprice,
    @required this.nb_product,
    @required this.prixpromotionnel,
  });
}

class Vente {
  double montant;
  List<Produit> produits;
  Vente({this.produits, this.montant});
}

class Produit {
  String reference;
  double prixpromo;
  double couttotale;
  int nbarticle;
  Produit({this.nbarticle, this.reference, this.couttotale, this.prixpromo});
}
