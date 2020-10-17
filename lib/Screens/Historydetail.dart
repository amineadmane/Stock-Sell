import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HistoriquedetailPage extends StatefulWidget {
  @override
  _HistoriquedetailPageState createState() => _HistoriquedetailPageState();
}

class _HistoriquedetailPageState extends State<HistoriquedetailPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;

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
      body: dashboard(context),
    );
  }

  Widget dashboard(context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_backspace_rounded,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text("Détail de vente",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: AssetImage('assets/images/cart.webp'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[400],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            child: TextButton(
                              onPressed: () {},
                              child: ListTile(
                                leading: Image(
                                  image: AssetImage('assets/images/avatar.jpg'),
                                ),
                                title: Text(
                                  "yessad samy",
                                  style: TextStyle(
                                      fontFamily: 'Mom cake',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Date de vente : 20/10/2019 a 10:59",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Montant de vente : 10000 DA",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Nombre d'article vendues : 203 articles",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "produits vendues",
                    style: TextStyle(
                        fontFamily: 'Mom cake',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          color: Colors.blueGrey[400],
                          child: SizedBox(
                              // height: 150.0,
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/box.png'))),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Couches Molfixxxxxx",
                                                  style: TextStyle(
                                                      fontFamily: 'Mom cake',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 28.0),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.4,
                                                  child: Divider(
                                                    thickness: 2.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "X Articles vendues",
                                                  style: TextStyle(
                                                      fontFamily: 'Mom cake',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                                Text(
                                                  "Prix unitaire : 1000 DA",
                                                  style: TextStyle(
                                                      fontFamily: 'Mom cake',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                                Text(
                                                  "Montant : 10000 DA",
                                                  style: TextStyle(
                                                      fontFamily: 'Mom cake',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                                Text(
                                                  "Promotion : Non",
                                                  style: TextStyle(
                                                      fontFamily: 'Mom cake',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))
                                ]),
                          )),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
