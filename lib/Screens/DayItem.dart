import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayItem extends StatefulWidget {
  final List<dynamic> Secteurs;

  DayItem({
    @required this.Secteurs,
  });
  @override
  _DayItemState createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  @override
  Widget build(BuildContext context) {
    List<String> array = new List<String>();

    for (final element in widget.Secteurs[0])
      {
        array.add(element.toString());
      }
    return Container(
      height: 60,
      child: ListView.builder
        (
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:array.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: EdgeInsets.all(2),
              child: Chip(
                label: Text(array[index],style: TextStyle(color: Colors.white,fontSize: 18),),
                backgroundColor: Colors.lightGreen,
              ),
            );
          }
      ),
    );
  }
}
