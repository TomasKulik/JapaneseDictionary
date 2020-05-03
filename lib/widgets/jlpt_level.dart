import 'package:flutter/material.dart';

class JLPTLevel extends StatelessWidget {
  final String jlpt;

  JLPTLevel({this.jlpt});

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    String _jlptLevel;

    switch (int.parse(jlpt[7])) {
      case 1:
        {
          _backgroundColor = Colors.red;
          _jlptLevel = 'N1';
        }
        break;
      case 2:
        {
          _backgroundColor = Colors.orange;
          _jlptLevel = 'N2';
        }
        break;
      case 3:
        {
          _backgroundColor = Colors.yellow;
          _jlptLevel = 'N3';
        }
        break;
      case 4:
        {
          _backgroundColor = Colors.blue;
          _jlptLevel = 'N4';
        }
        break;
      case 5:
        {
          _backgroundColor = Colors.green;
          _jlptLevel = 'N5';
        }
        break;
      default:
        {
          _backgroundColor = Colors.black;
          _jlptLevel = '??';
        }
    }

    return Container(
      width: 30,
      height: 20,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(_jlptLevel),
      ),
    );
  }
}
