import 'package:flutter/material.dart';
import 'package:stocknsell/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/ClientItem.dart';

class ClientSearch extends StatefulWidget {

  final String filter;
  ClientSearch({
    @required this.filter,
  });
  @override
  _ClientSearchState createState() => _ClientSearchState();
}

class _ClientSearchState extends State<ClientSearch> {
  @override
  Widget build(BuildContext context) {
    final String filter= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$filter",style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
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
                if(data['nom'].toString().contains(filter) || data['Secteur'].toString().contains(filter) 
                || data['email'].toString().contains(filter) || filter.contains(data['phone'].toString()))
                  {
                    return ClientItem(
                      nom: data['nom'],
                      documentSnapshot: data,
                      id: data.id,
                      url: data['URL'],
                      phone: data['phone'],
                      email: data['email'],
                      secteur: data['Secteur'],
                    );}
                else
                  {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }
                
              },
            );
          },
        ),
      ),
    );
  }
}
