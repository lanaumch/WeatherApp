import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  static const String _title = 'WeatherApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WeatherStatefulWidget(),
    );
  }
}

class WeatherStatefulWidget extends StatefulWidget {
  WeatherStatefulWidget({Key key}) : super(key: key);

  @override
  _WeatherStatefulWidgetState createState() => _WeatherStatefulWidgetState();
}

class _WeatherStatefulWidgetState extends State<WeatherStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Today',
      style: optionStyle,
    ),
    Text(
      'Forecast',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather application'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            title: Text('Today')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_cloudy),
            title: Text('Forecast'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
