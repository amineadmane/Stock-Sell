import 'package:flutter/material.dart';

class MyStatefulWidget2 extends StatefulWidget {
  MyStatefulWidget2({Key key}) : super(key: key);

  @override
  _MyStatefulWidget2State createState() => _MyStatefulWidget2State();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidget2State extends State<MyStatefulWidget2> {
  String dropdownValue = 'Client 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.location_on_rounded),
      iconSize: 15,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'Client 1',
        'Client 3',
        'Client 7',
        'Client 4',
        'Client 6',
        'Client 2'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
