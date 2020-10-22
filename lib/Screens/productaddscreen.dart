import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class ProductaddPage extends StatefulWidget {
  @override
  _ProductaddPageState createState() => _ProductaddPageState();
}

class _ProductaddPageState extends State<ProductaddPage>
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

  dashboard(context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      Text("Ajouter un produit",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: AssetImage('assets/images/Boxx.png'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16,
                      right: 16,
                      left: 16,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        bottom: 8.0,
                        right: 16,
                      ),
                      height: screenHeight * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[400],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Réference',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Marque',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Prix d\'achat',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Prix de vente',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Promotion :",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              ToggleSwitch(
                                minWidth: 90.0,
                                cornerRadius: 20.0,
                                activeBgColor: Colors.cyan,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                labels: ['YES', 'NO'],
                                icons: [
                                  FontAwesomeIcons.check,
                                  FontAwesomeIcons.times
                                ],
                                activeBgColors: [Colors.green, Colors.pink],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    focusColor: Colors.white,
                                    labelText: 'Prix Promotionnel',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    focusColor: Colors.white,
                                    labelText: 'Taux',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              labelText: 'Nombre',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: null,
                          child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15)),
                              ),
                              alignment: Alignment.center,
                              width: screenWidth * 0.41,
                              height: 45,
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ))),
                      TextButton(
                          onPressed: null,
                          child: Container(
                              height: 45,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15)),
                              ),
                              alignment: Alignment.center,
                              width: screenWidth * 0.41,
                              child: Text(
                                "Ajouter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mom cake',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ))),
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
