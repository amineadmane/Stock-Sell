import 'package:flutter/material.dart';

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
      body:
        SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child : Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    ),
    );
  }

  Widget body(context)
  {
    return AnimatedPositioned(
        duration: duration,
        left: isCollapsed ? 0 : 0.6 * screenWidth,
        right: isCollapsed ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
        scale: _scaleAnimation,
          child:Container(
            margin : EdgeInsets.only(top:100),
            child: Column(
              children: [
                Center(
                  child : Text("Secteur a visiter Aujourd'hui",style: TextStyle(fontSize: 26,color: Colors.black),),
                ),
                Wrap(
                  spacing: 6.0,
                  children: <Widget>[
                    Chip(
                      label: Text('Ain naadja',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('el herrach',style: TextStyle(color: Colors.white),)

                    ),
                    Chip(
                      label: Text('Ain naadja',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('el herrach',style: TextStyle(color: Colors.white),)

                    ),
                    Chip(
                      label: Text('Ain naadja',style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.lightGreen,
                    ),
                    Chip(
                        backgroundColor: Colors.lightGreen,
                        label: Text('el herrach',style: TextStyle(color: Colors.white),)

                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black45,
                  height: 20,
                  thickness: 2,
                ),
                Center(
                  child : Text("Client restant a visiter",style: TextStyle(fontSize: 26,color: Colors.black),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child : Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/baraka.jpg'),
                          ),
                          title: Text('Boutouili Djillali'),
                          subtitle: Text('Rouiba'),
                          trailing: IconButton(
                            icon: Icon(Icons.highlight_remove,size: 40,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.orange,
                              onPressed: () {
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
                const Divider(
                  color: Colors.black45,
                  height: 20,
                  thickness: 2,
                ),
                Center(
                    child: Card(
                      margin: EdgeInsets.only(bottom: 30),
                      elevation: 5,
                      color: Colors.white70,
                      child:Row(
                        children: [
                          Icon(
                            Icons.directions_bus_rounded,color: Colors.green,size: 200,
                          ),
                          Container(margin: EdgeInsets.only(right: 10.0),color: Colors.black45, height: 200, width: 2,),//Divider
                          Container(
                              child:Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Clients Visites : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        Text(" 31",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Clients Restants : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        Text(" 12",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Produits restants : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        Text(" 5",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                          textColor: Colors.white,
                                          color: Colors.orange,
                                          onPressed: () {
                                          },
                                          child: const Text('Details',style: TextStyle(fontSize: 22),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    )

                ),
                const Divider(
                  color: Colors.black45,
                  height: 20,
                  thickness: 2,
                ),
                Center(
                    child: Card(
                      margin: EdgeInsets.only(bottom: 30),
                      elevation: 5,
                      color: Colors.white70,
                      child:Row(
                        children: [
                          Icon(
                            Icons.monetization_on,color: Colors.green,size: 200,
                          ),
                          Container(margin: EdgeInsets.only(right: 10.0),color: Colors.black45, height: 200, width: 2,),//Divider
                          Container(
                              child:Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Articles Vendus : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        Text(" 521",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Benefices : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        Text(" 12000 DA",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("CA :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        Text(" 120000",style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                          textColor: Colors.white,
                                          color: Colors.orange,
                                          onPressed: () {
                                          },
                                          child: const Text('Details',style: TextStyle(fontSize: 22),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    )

                ),
              ],
            ),
          ),
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
                Container(
                  height: 150,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Acceuil",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading: Icon(
                    Icons.home_rounded,
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
                ListTile(
                  title: Text("Stock",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading: Icon(
                    Icons.store_mall_directory_rounded,
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
                ListTile(
                  title: Text("Clients",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading: Icon(
                    Icons.perm_contact_cal_rounded,
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
                TextButton(
                  child: ListTile(
                    title: Text("Planification",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    leading: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
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
                ListTile(
                  title: Text("Historique",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading: Icon(
                    Icons.history_rounded,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48,bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children:[
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
                      Text("Stock & Sales",
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
