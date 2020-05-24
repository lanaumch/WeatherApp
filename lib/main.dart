import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  static const String _title = 'Weather App';

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
  Geolocator geolocator = Geolocator();
  static Position userLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    userLocation == null
        ? CircularProgressIndicator()
        : Text("Location:" +
          userLocation.latitude.toString() +
          " " +
          userLocation.longitude.toString(),
      style: optionStyle,
    ),
    ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('row $index'),
          subtitle: Text('Sunny'),
          trailing: Text('22°'),
        );
      }
    ),
  ];

  void _onItemTapped(int index) {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
        print("VALUE: "+userLocation.latitude.toString() );
      });
      _widgetOptions[0]= userLocation == null
          ? CircularProgressIndicator()
          : Text("Location:" +
          userLocation.latitude.toString() +
          " " +
          userLocation.longitude.toString(),
        style: optionStyle,
      );
    });
    setState(() {
      _selectedIndex = index;
      print('INDEX');
    });
  }
  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather app'),
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