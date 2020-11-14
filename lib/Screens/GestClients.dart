import 'package:flutter/material.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/ClientItem.dart';

class Clients extends StatefulWidget {
  static String id = '/Clients';
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final _formKey = GlobalKey<FormState>();
  String nom;
  int phone;
  String email;
  String Secteur;
  String URL;
  String _filter = "nom";
  selectnom() {
    setState(() => _filter = "nom");
  }

  selectsecteur() {
    setState(() => _filter = "secteur");
  }

  @override
  Widget build(BuildContext context) {
    void showDialog() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 500),
        context: context,
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Ajouter un nouveau client"),
            ),
            body: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              alignment: Alignment.center,
              child: Card(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      new ListTile(
                        leading: const Icon(Icons.person, color: Colors.blue),
                        title: new TextFormField(
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            nom = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            labelText: "Name",
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: const Icon(Icons.phone, color: Colors.blue),
                        title: new TextFormField(
                          onChanged: (value) {
                            phone = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            labelText: "Phone",
                          ),
                        ),
                      ),
                      new ListTile(
                        leading:
                            const Icon(Icons.location_on, color: Colors.blue),
                        title: DropdownButtonFormField<String>(
                          value: Secteur,
                          style: TextStyle(color: Colors.blue),
                          onChanged: (String newValue) {
                            setState(() {
                              Secteur = newValue;
                            });
                          },
                          items: <String>[
                            'Bab El Oued',
                            'Baraki',
                            'Bir Mourad Raïs',
                            'Birtouta',
                            'Bouzareah',
                            'Chéraga',
                            'Dar El Beïda',
                            'Draria',
                            'El Harrach',
                            'Hussein Dey',
                            'Rouïba',
                            'Sidi M\'Hamed',
                            'Zéralda',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      new ListTile(
                        leading: const Icon(Icons.map, color: Colors.blue),
                        title: new TextFormField(
                          onChanged: (value) {
                            URL = value;
                          },
                          decoration: new InputDecoration(
                            labelText: 'Url "Google maps"',
                          ),
                        ),
                      ),
                      new ListTile(
                        leading: const Icon(Icons.email, color: Colors.blue),
                        title: new TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: new InputDecoration(
                            labelText: 'E-Mail',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            const start = "https";
                            if (URL.indexOf(start) != -1) {
                              final startIndex = URL.indexOf(start);
                              final endIndex = URL.length;
                              URL = URL.substring(startIndex, endIndex);
                              DatabaseService().ajouterclient(
                                  nom, email, phone, URL, Secteur);
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: const Text('Creer Client'),
                      ),
                    ],
                  ),
                ),
                elevation: 5.0,
                color: Colors.white70,
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Clients')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _myListView(context),
            _mystreambuilder(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog();
        },
        elevation: 4,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  String filter = "";
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: TextFormField(
                initialValue: filter,
                onChanged: (value) {
                  filter = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search',
                          arguments: filter);
                    },
                    tooltip: 'Rechercher',
                  ),
                  hintText: 'Rechercher',
                ),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _mystreambuilder(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  double screenhight = size.height;

  return Container(
    height: screenhight * 0.8,
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("clients").snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return ClientItem(
                    nom: data['nom'],
                    documentSnapshot: data,
                    id: data.id,
                    url: data['URL'],
                    phone: data['phone'],
                    email: data['email'],
                    secteur: data['Secteur'],
                  );
                },
              );
      },
    ),
  );
}
