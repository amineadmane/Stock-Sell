import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/Client.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientItem extends StatefulWidget {
  final String nom;
  final String secteur;
  final String email;
  final String url;
  final String id;
  final int phone;
  final DocumentSnapshot documentSnapshot;
  ClientItem({
    @required this.nom,
    @required this.documentSnapshot,
    @required this.id,
    @required this.url,
    @required this.phone,
    @required this.email,
    @required this.secteur,
  });

  @override
  _ClientItemState createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              title: Text(
                widget.nom,
                style: TextStyle(fontSize: 22, fontFamily: 'Mom cake'),
              ),
              subtitle: Text(widget.secteur,
                  style: TextStyle(fontSize: 18, fontFamily: 'Mom cake')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      onPressed: () {
                        _launchUrl(widget.url);
                      },
                      child: const Text('Map'),
                    ),
                    const SizedBox(width: 8),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.lightGreen,
                      onPressed: () async {
                        int somnb_product = 0;
                        double Chiffredaffaire = 0;
                        await DatabaseService()
                            .getnbarticlesachetesclient(widget.id)
                            .then((QuerySnapshot querySnapshot) => {
                                  querySnapshot.docs.forEach((doc) {
                                    somnb_product =
                                        somnb_product + doc['nb_product'];
                                    Chiffredaffaire =
                                        Chiffredaffaire + doc['couttotale'];
                                  })
                                });
                        print(somnb_product);
                        print(Chiffredaffaire);
                        //Navigator.pushNamed(context, '/client',arguments:
                        //Client(nom: widget.nom, URL: widget.url, phone: widget.phone, id: widget.id , email: widget.email, Secteur: widget.secteur));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Client(
                                nom: widget.nom,
                                URL: widget.url,
                                phone: widget.phone,
                                id: widget.id,
                                email: widget.email,
                                Secteur: widget.secteur,
                                somnb_product: somnb_product,
                                Chiffredaffaire: Chiffredaffaire,
                              ),
                            ));
                      },
                      child: const Text('Details'),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
        elevation: 3,
        color: Colors.white70,
      ),
    );
  }
}

void _launchUrl(String Url) async {
  if (await canLaunch(Url)) {
    await launch(Url);
  } else {
    throw 'Could not open Url';
  }
}
