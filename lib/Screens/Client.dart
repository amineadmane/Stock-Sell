import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/color_utils.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class Client extends StatefulWidget {
  static String idd = '/client';
  String nom;
  String email;
  String Secteur;
  String URL;
  int phone;
  String id;
  int somnb_product;
  double Chiffredaffaire;
  Client({
    this.nom,
    this.URL,
    this.phone,
    this.id,
    this.email,
    this.Secteur,
    this.somnb_product,
    this.Chiffredaffaire,
  });
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final _formKey = GlobalKey<FormState>();

  createalertedialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Suppression"),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Voulez-vous vraiment supprimer ce client?"),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red,
                            elevation: 4,
                            onPressed: () {
                              DatabaseService().deleteclient(widget.id);
                              Navigator.of(context).pop();
                            },
                            child: Text("Supprimer")),
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

  createalertedialogmodif(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Modification"),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Voulez-vous sauvegarder vos changements?"),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red,
                            elevation: 4,
                            onPressed: () {
                              DatabaseService().updateclient(
                                  widget.id,
                                  widget.nom,
                                  widget.email,
                                  widget.phone,
                                  widget.URL,
                                  widget.Secteur);
                              Navigator.of(context).pop();
                            },
                            child: Text("Retour")),
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.green,
                            elevation: 4,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Comfirmer")),
                      ],
                    ),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final int _domnbproduct = widget.somnb_product;
    final double _chiffreaffaire = widget.Chiffredaffaire;

    String covertinttoday(int day) {
      String jour = "";
      if (day == 1) jour = "Lundi";
      if (day == 2) jour = "Mardi";
      if (day == 3) jour = "Mercredi";
      if (day == 4) jour = "Jeudi";
      if (day == 5) jour = "Vendredi";
      if (day == 6) jour = "Samedi";
      if (day == 7) jour = "dimanche";
      return jour;
    }

    final today = DateTime.now().weekday;
    List<dynamic> secteurs = new List<String>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Details Client"),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("planification")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data.docs[index];
                              secteurs = data[covertinttoday(today)];
                              return Container(
                                height: 0,
                                width: 0,
                              );
                            },
                          );
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(gradient: ColorUtils.appBarGradient),
                ),
                Align(
                  alignment: Alignment.topCenter,
                ),
                Positioned(
                  top: 35,
                  left: 10,
                  right: 10,
                  child: new Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/avatar.jpg'),
                          radius: 60,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(widget.nom,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(1.0),
                              fontWeight: FontWeight.bold)),
                      Text(widget.Secteur,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Positioned(
                  top: 220,
                  left: 10,
                  right: 10,
                  child: Form(
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: const Icon(Icons.person, color: Colors.blue),
                          title: new TextFormField(
                            initialValue: widget.nom,
                            onChanged: (value) {
                              widget.nom = value;
                            },
                            decoration: new InputDecoration(
                              hintText: "Name",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.phone, color: Colors.blue),
                          title: new TextFormField(
                            initialValue: widget.phone.toString(),
                            onChanged: (value) {
                              widget.phone = int.parse(value);
                            },
                            decoration: new InputDecoration(
                              hintText: "Phone",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading:
                              const Icon(Icons.location_on, color: Colors.blue),
                          title: DropdownButtonFormField<String>(
                            value: "Bab ezzouar",
                            style: TextStyle(color: Colors.blue),
                            onChanged: (String newValue) {
                              setState(() {
                                widget.Secteur = newValue;
                              });
                            },
                            items: <String>[
                              'Alger Centre',
                              'Bab el oued',
                              'Bab ezzouar',
                              'Ain naadja',
                              'Dar El Beida',
                              'El Herrach'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.shopping_cart,
                              color: Colors.blue),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText:
                                  "Nombre articles achetes : $_domnbproduct",
                            ),
                            readOnly: true,
                          ),
                        ),
                        new ListTile(
                          leading:
                              const Icon(Icons.article, color: Colors.blue),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText:
                                  "Argent depense par client : $_chiffreaffaire",
                            ),
                            readOnly: true,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: ButtonBar(
                            children: <Widget>[
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  elevation: 4,
                                  onPressed: () {
                                    createalertedialog(context);
                                  },
                                  child: Text("Supprimer")),
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.orange,
                                  elevation: 4,
                                  onPressed: () {
                                    createalertedialogmodif(context);
                                  },
                                  child: Text("Modifier")),
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  elevation: 4,
                                  onPressed: () {
                                    UrlLauncher.launch(
                                        'tel:+213${widget.phone.toString()}');
                                  },
                                  child: Text("Appeler")),
                              RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.yellow,
                                  elevation: 4,
                                  onPressed: () {
                                    _launchUrl(widget.URL);
                                  },
                                  child: Text("Map")),
                            ],
                          ),
                        ),
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.deepPurple,
                            elevation: 4,
                            onPressed: () {
                              Navigator.pushNamed(context, '/vente',
                                  arguments: clientdetails(
                                    widget.id,
                                    widget.nom,
                                  ));
                            },
                            child: Text("Facturer une vente")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class clientdetails {
  final String id;
  final String name;

  clientdetails(this.id, this.name);
}

void _launchUrl(String Url) async {
  if (await canLaunch(Url)) {
    await launch(Url);
  } else {
    throw 'Could not open Url';
  }
}
