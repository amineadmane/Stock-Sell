import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocknsell/Screens/ClientItem.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
          Container(
            margin: EdgeInsets.only(top: 90),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("clients").snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    print(data['nom']);
                    print(data.id);
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
          )
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text("Dynamique textttttt",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Fredoka One')),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                    child: ListTile(
                      title: Text("Acceuil",
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                      leading: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.reverse();
                        isCollapsed = !isCollapsed;
                      });
                    }),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Stock",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.store_mall_directory_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/stock');
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Clients",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.perm_contact_cal_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Clients');
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Planification",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/planning');
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  child: ListTile(
                    title: Text("Historique",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.history_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text("Parametres",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading: Icon(
                    Icons.settings_applications_rounded,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                            } else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("Acceuil",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}