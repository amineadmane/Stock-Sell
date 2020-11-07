import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Screens/ProductItem.dart';
import 'package:stocknsell/Services/database.dart';

class VenteScreen extends StatefulWidget {
  @override
  _VenteScreenState createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {
  final Color backgroundColor = Color(0xFF4A4A58);
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    final clientdetails details= ModalRoute.of(context).settings.arguments;
    final String client_id = details.id;
    final String client_name = details.name;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 100),
            child: Text("Vente",)),
      ),
      backgroundColor: backgroundColor,
      body:
          Column(
            children: [
              Container(
                height: screenHeight*0.8,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("produit").snapshots(),
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
                          id : data.id,
                          marque : data['marque'],
                          unitprice: data['baseprice'],
                          nbunitfourgon: data['nbunitfourgon'],
                          prixpromotionnel: data['promprice'],
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
                    onPressed: () {
                      DatabaseService().todaystransaction(client_id).then((QuerySnapshot querySnapshot) => {
                        querySnapshot.docs.forEach((doc) {
                        //fonction pour la facture client.
                        })
                      });
                    },
                    child:  Text('Extraire Facture',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Mom cake'),),
                  ),
                ),
              ),
            ],
          ),
      );
  }
}
class productdetails{
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
