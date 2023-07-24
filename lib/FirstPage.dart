import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search, color: Colors.black);
  Widget _appBarTitle = Text('Search...', style: TextStyle(color: Colors.black));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 80.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 30.0),
              _searchIcon,
              SizedBox(width: 10.0),
              Text ("Hello")
          ],)
        ],
      ),
    );
  }
}
