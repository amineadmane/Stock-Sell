import 'package:flutter/material.dart';
import 'package:stocknsell/Services/database.dart';

class FilteringChips extends StatefulWidget {
  final String jour;
  FilteringChips({
    @required this.jour,
  });
  @override
  _FilteringChipsState createState() => _FilteringChipsState();
}

class _FilteringChipsState extends State<FilteringChips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: [
          _buildChips(),
          Center(
            child : RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                DatabaseService().creerplanning(_options, _selected,widget.jour);
                Navigator.of(context).pop();
              },
              child: const Text('Appliquer',style: TextStyle(fontSize: 18),),
            ),
          )
        ],
      ),
    );
  }


  List<String> _options = ['Ain Naadja', 'Bab el Oued', 'Belcourt','Dar el beida','Rouiba','Reghaia','Benaknoun','El Biar'
  ,'Kouba','Hussein Dey','Ruissea','Bir Mourad Rais','Birkhadem','Oued Semmar','Bab Ezzaour','Birkhadem','Said Hamdin','Hydra','Sidi Yahia'];

  List<bool> _selected = [false, false, false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];


  Widget _buildChips() {
    List<Widget> chips = new List();
    for (int i = 0; i < _options.length; i++) {

      FilterChip filterChip = FilterChip(
        selected: _selected[i],
        label: Text(_options[i], style: TextStyle(color: Colors.white)),
        avatar: CircleAvatar(
          child: Text(_options[i][0].toUpperCase()),
        ),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Color(0xFF9575cd),
        selectedColor: Colors.green,
        onSelected: (bool selected) {
          setState(() {
            _selected[i] = selected;
          });
        },
      );
      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: filterChip
      ));
    }
    return Wrap(
      children: chips,
    );

  }


  wrapWidget() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        chip('Ain naadja', Color(0xFFff8a65)),
        chip('BirMouradRais', Color(0xFF4fc3f7)),
        chip('Bir Khadem', Color(0xFF9575cd)),
        chip('Kouba', Color(0xFF4db6ac)),
        chip('HusseinDey', Color(0xFF5cda65)),
        chip('El herrach', Color(0xFFacbb65)),
        chip('Bab el oued', Color(0xFFff8a65)),
        chip('Bainem', Color(0xFF4fc3f7)),
        chip('Ain Benyan', Color(0xFF9575cd)),
        chip('Rouiba', Color(0xFF4db6ac)),
        chip('Reghaiya', Color(0xFF5cda65)),
        chip('Dar El Beida', Color(0xFFacbb65)),
      ],
    );
  }
  bool _isSelected = false ;
  Widget chip(String label, Color color) {

    return InputChip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
      selected: _isSelected,
      selectedColor: Colors.green,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }
}


