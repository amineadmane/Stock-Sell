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
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                DatabaseService()
                    .creerplanning(_options, _selected, widget.jour);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Appliquer',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> _options = [
    'Bab El Oued',
    'Baraki',
    'Bir Mourad Raïs',
    'Birtouta',
    'Bouzareah',
    'Chéraga',
    'Dar El Beïda',
    'Draria',
    'El Harrach',
    'Hussein Dey',
    'Rouïba',
    'Sidi M\'Hamed',
    'Zéralda',
  ];

  List<bool> _selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

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
          padding: EdgeInsets.symmetric(horizontal: 10), child: filterChip));
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
        chip('Bab El Oued', Color(0xFFff8a65)),
        chip('Baraki', Color(0xFF4fc3f7)),
        chip('Bir Mourad Raïs', Color(0xFF9575cd)),
        chip('Birtouta', Color(0xFF4db6ac)),
        chip('Bouzareah', Color(0xFF5cda65)),
        chip('Chéraga', Color(0xFFacbb65)),
        chip('Dar El Beïda', Color(0xFFff8a65)),
        chip('Draria', Color(0xFF4fc3f7)),
        chip('El Harrach', Color(0xFF9575cd)),
        chip('Hussein Dey', Color(0xFF4db6ac)),
        chip('Rouïba', Color(0xFF5cda65)),
        chip('Sidi M\'Hamed', Color(0xFFacbb65)),
        chip('Zéralda', Color(0xFFacbb65)),
      ],
    );
  }

  bool _isSelected = false;
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
