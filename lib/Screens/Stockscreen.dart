import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:stocknsell/Components/DownSelect.dart';
import 'package:stocknsell/Components/DownSelect2.dart';
import 'package:stocknsell/Screens/productdetailScreen.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class StockPage extends StatefulWidget {

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage>
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
        ],
      ),
    );
  }

  int tag = 0;
  List<String> options = [
    'Date',
    'Client',
    'Montant',
  ];
  final elements1 = [
    "Alger",
    "Harach",
    "Beo",
    "Said Hamdine",
    "Ain Naadja",
    "Kouba",
    "Garidi",
  ];

  _openPopup(context) {
    Alert(
        context: context,
        title: "Filtres",
        style: AlertStyle(
            backgroundColor: Colors.grey[200],
            titleStyle: TextStyle(
                fontFamily: 'Mom cake',
                fontWeight: FontWeight.bold,
                fontSize: 34)),
        content: SizedBox(
          width: screenWidth,
          height: screenHeight * 0.6,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Trier par :",
                    style: TextStyle(
                        fontFamily: 'Mom cake',
                        fontWeight: FontWeight.bold,
                        fontSize: 34)),
                Row(
                  children: [
                    Expanded(
                      child: ChipsChoice<int>.single(
                        value: tag,
                        onChanged: (val) => setState(() => tag = val),
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: options,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        choiceStyle: C2ChoiceStyle(
                          color: Colors.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Text("Secteur :"),
                MyStatefulWidget(),
                Text("Client : "),
                MyStatefulWidget2(),
                Text("Montant de vente"),
                Row(
                  children: [
                    SizedBox(
                      width: 110.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'MIN',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                      child: Divider(
                        thickness: 2.0,
                      ),
                    ),
                    SizedBox(
                      width: 110.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'MAX',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Text("Date de vente"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110.0,
                    ),
                    SizedBox(
                      width: 8,
                      child: Divider(
                        thickness: 2.0,
                      ),
                    ),
                    SizedBox(
                      width: 110.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Filtrer",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Réinitialiser",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          )
        ]).show();
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
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    leading: Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
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
                    title: Text("Stock",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    leading: Icon(
                      Icons.store_mall_directory_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.reverse();
                      isCollapsed = !isCollapsed;
                    });
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
                  title: Text("Clients",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
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
                ListTile(
                  title: Text("Planification",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  leading: Icon(
                    Icons.calendar_today_rounded,
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
                    title: Text("Historique",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
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
                      style: TextStyle(color: Colors.white, fontSize: 20)),
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
              height: screenHeight,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 37),
              child: SizedBox(
                height: screenHeight * 0.1,
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
                        Text("Stock",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                        IconButton(
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage:
                                  AssetImage('assets/images/search.png'),
                            ),
                            onPressed: () {
                              _openPopup(context);
                              setState(() {});
                            })
                      ],
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: new Scaffold(
                          floatingActionButton: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.pushNamed(context, '/productadd');
                            },
                            label: Text('Ajouter'),
                            icon: Icon(Icons.add_business_rounded),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            splashColor: Colors.green,
                            hoverColor: Colors.green,
                          ),
                          backgroundColor: backgroundColor,
                          appBar: TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            tabs: [
                              Tab(
                                  text: 'Dépot',
                                  icon:
                                      Icon(Icons.store_mall_directory_rounded)),
                              Tab(
                                  text: 'Fourgon',
                                  icon: Icon(
                                    Icons.directions_bus_rounded,
                                  ))
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(16),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/productdetail');
                                      },
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
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Couches Molf",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Mom cake',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        28.0),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.4,
                                                                child: Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "X Articles restants",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Mom cake',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Text(
                                                                "Prix unitaire : 1000 DA",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Mom cake',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              Text(
                                                                "Prix promotionnel : 10005 DA",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Mom cake',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                              ]),
                                        )),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "Couches Molf",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mom cake',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      28.0),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.4,
                                                              child: Divider(
                                                                thickness: 2.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Articles restants : 152",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mom cake',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            Text(
                                                              "Prix unitaire : 1000 DA",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mom cake',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            Text(
                                                              "Prix promotionnel : 10005 DA",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mom cake',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.0),
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
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
