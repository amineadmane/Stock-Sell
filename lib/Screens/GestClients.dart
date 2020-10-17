import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : _myListView(context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

            },
            elevation: 4,
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,

          ),
        );
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            trailing:
               RaisedButton(
                 textColor: Colors.white,
                 color: Colors.lightGreen,
                 onPressed: () {
                   _launchUrl("https://www.google.com/maps/place/Ha%C3%AF+el+Badr/@36.7273376,3.075889,13.32z/data=!4m5!3m4!1s0x128e52b40a012c89:0xd4ed8efc554349b1!8m2!3d36.7254274!4d3.1023073?hl=fr-FR");
                 },
                 child: const Text('Details'),
               ),
               onTap: () {

               },
            title: Text('Admane Mohammed Amine'),
            subtitle: Row(
            children: <Widget>[
                Text('Birkhadem'),
            ],
            ),

          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child : ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/facebook.png'),
            ),
            trailing:
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              onPressed: () {
                // Perform some action
              },
              child: const Text('Details'),
            ),
            title: Text('Yessad Samy'),
            subtitle: Text('Dar El Beida'),
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            trailing:
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              onPressed: () {
                // Perform some action
              },
              child: const Text('Details'),
            ),
            title: Text('Hamza Ma9esthach'),
            subtitle: Text('Rouiba'),
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child : ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/facebook.png'),
            ),
            trailing:
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              onPressed: () {
                // Perform some action
              },
              child: const Text('Details'),
            ),
            title: Text('Boutouili Djillali'),
            subtitle: Text('Dar El Beida'),
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            trailing:
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              onPressed: () {
                // Perform some action
              },
              child: const Text('Details'),
            ),
            title: Text('Lotfi Dimis'),
            subtitle: Text('Rouiba'),
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child : ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/facebook.png'),
            ),
            trailing:
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              onPressed: () {
                // Perform some action
              },
              child: const Text('Details'),
            ),
            title: Text('haidour asma '),
            subtitle: Text('Dar El Beida'),
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
              leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/facebook.png'),
              ),
                title: Text('Mouzaoui Mohammed'),
                subtitle: Text('Benaknoun'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
    ],
  );
}

void _launchUrl(String Url ) async{
  if(await canLaunch(Url)){
    await launch(Url);
  }
  else{
    throw 'Could not open Url';
  }
}