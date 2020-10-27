import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stocknsell/Screens/FIlteringChips.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Services/database.dart';

class Planning extends StatefulWidget {
  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planning Hebdomadaire')),
      body: _dayspage(context),
    );
  }
}

Widget _dayspage(BuildContext context) {
  List<String> Dimanche = DatabaseService().getdimanchesect();
  void showDialogup(context,String jour) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 800),
      context: context,
      pageBuilder: (_, __, ___,) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Secteur a Visiter"),
          ),
          body :
               FilteringChips(jour: jour),
          );

      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }



  return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),

          child : Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("DI"),
                    ),
                    title: Text('Dimanche',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    ListView.builder
                    (
                        shrinkWrap: true,
                      itemCount: Dimanche.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                      return Chip(
                        label: Text(Dimanche[index],style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.lightGreen,
                      );
                     }
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: (){
                          showDialogup(context,"dimanche");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("LU"),
                    ),
                    title: Text('Lundi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Benaknoun',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('EL Biar',style: TextStyle(color: Colors.white),)

                    ),
                    Chip(
                      label: Text('Benaknoun',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('EL Biar',style: TextStyle(color: Colors.white),)

                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('Dely Brahim',style: TextStyle(color: Colors.white),)

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Lundi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("MA"),
                    ),
                    title: Text('Mardi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Rouiba',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(width: 14,),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('Reghaya',style: TextStyle(color: Colors.white),)

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Mardi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("ME"),
                    ),
                    title: Text('Mercredi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Bab EL oued',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(width: 14,),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('Ain Benian',style: TextStyle(color: Colors.white),)

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Mercredi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("JE"),
                    ),
                    title: Text('Jeudi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Alger Centre',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(width: 14,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Jeudi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("VE"),
                    ),
                    title: Text('Vendredi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Alger Plage',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(width: 14,),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('Cafe Chergui',style: TextStyle(color: Colors.white),)

                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Vendredi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top : 15),
                  child : ListTile(
                    leading: CircleAvatar(
                      child: Text("SA"),
                    ),
                    title: Text('Samedi',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  ),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Staouali',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(width: 14,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right : 15),
                      child : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.orangeAccent,
                        onPressed: () {
                          showDialogup(context,"Samedi");
                        },
                        child: const Text('Programme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    )
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




