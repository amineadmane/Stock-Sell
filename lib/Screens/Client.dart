import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/color_utils.dart';
import 'package:stocknsell/Screens/common_styles.dart';
import 'package:stocknsell/Services/database.dart';

class Client extends StatefulWidget {
  String nom;
  String email;
  String Secteur;
  String URL;
  int phone;
  String id;

  Client({
    @required this.nom,
    @required this.URL,
    @required this.phone,
    @required this.id,
    @required this.email,
    @required this.Secteur,
  });
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final _formKey = GlobalKey<FormState>();

  createalertedialog(BuildContext context)
  {
    return showDialog(context: context,builder: (context){
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
                        child:
                        Text("Supprimer")
                    ),
                    RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        elevation: 4,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:
                        Text("Retour")
                    ),
                  ],
                ),

              ]

          )

      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Client"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: double.infinity,
                decoration: BoxDecoration(gradient: ColorUtils.appBarGradient),
              ),
              Align(
                alignment: Alignment.topCenter,
              ),
              Positioned(
                top: 75,
                left: 10,
                right: 10,
                child: new Column(
                    children: <Widget>[
                      Center(
                        child : CircleAvatar(
                          backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          radius: 75,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.nom,
                        style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(1.0),fontWeight: FontWeight.bold)),
                      Text(widget.Secteur,style: TextStyle(fontSize: 17,color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold))
                      ],
                ),
              ),
              Positioned(
                 top: 300,
                 left: 10,
                 right: 10,
                child: Form(
                  key: _formKey,
                  child: new Column(
                      children: <Widget>[
                            new ListTile(
                                    leading: const Icon(Icons.person,color: Colors.blue),
                                    title: new TextFormField(
                                      initialValue: widget.nom,
                                      onChanged: (value){
                                        widget.nom = value;
                                      },
                                      decoration: new InputDecoration(
                                      hintText: "Name",
                                      ),
                                    ),
                                  ),
                            new ListTile(
                                    leading: const Icon(Icons.phone,color: Colors.blue),
                                    title: new TextFormField(
                                      initialValue: widget.phone.toString(),
                                      onChanged: (value){
                                        widget.phone = int.parse(value);
                                      },
                                    decoration: new InputDecoration(
                                    hintText: "Phone",
                                        ),
                                      ),
                                    ),
                            new ListTile(
                                  leading: const Icon(Icons.location_on,color: Colors.blue),
                                  title: new TextFormField(
                                    initialValue: widget.Secteur,
                                    onChanged: (value){
                                      widget.Secteur = value;
                                    },
                                    decoration: new InputDecoration(
                                    hintText: "Secteur",
                                    ),
                                  ),
                                ),
                            new ListTile(
                              leading: const Icon(Icons.shopping_cart,color: Colors.blue),
                              title: new TextField(
                                decoration: new InputDecoration(
                                hintText: "Nombre articles achetes",
                              ),
                            ),
                            ),
                        new ListTile(
                          leading: const Icon(Icons.article,color: Colors.blue),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Article le plus achete",
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red,
                              elevation: 4,
                              onPressed: () {
                                createalertedialog(context);
                              },
                              child:
                                  Text("Supprimer")
                              ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              elevation: 4,
                              onPressed: () {
                                DatabaseService().updateclient(widget.id, widget.nom, widget.email, widget.phone, widget.URL, widget.Secteur);
                                Navigator.of(context).pop();
                              },
                              child:
                                  Text("Modifier")
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.green,
                              elevation: 4,
                              onPressed: () {
                                // Perform some action
                              },
                              child:
                                  Text("Appeler")
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.yellow,
                              elevation: 4,
                              onPressed: () {
                                // Perform some action
                              },
                              child:
                                  Text("Map")
                            ),
                          ],
                        )
                      ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
