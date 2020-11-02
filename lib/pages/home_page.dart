import 'package:flutter/material.dart';
import 'package:guncel_son_depremler/widgets/flatbuttons.dart';
import '../modules/earthquake.dart';
import 'loading_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> top = [];
  List<Widget> bottom;
  List<EarthquakesModel> _details = List<EarthquakesModel>();
  List<EarthquakesModel> _innerDetails;
  double minMagnitude = 1.0;

  void filterResult(value) {
    List<EarthquakesModel> _temp = List<EarthquakesModel>();
    _details.forEach((element) {
      if (double.parse(element.magnitude) >= value) {
        _temp.add(element);
      }
    });

    setState(() {
      _innerDetails = _temp;
      minMagnitude = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _details = ModalRoute.of(context).settings.arguments;
    bottom = getFlatButtons(_innerDetails ?? _details);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SON DEPREMLER',
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            //IconButton(
            //  icon: Icon(Icons.circle_notifications),
            //  color: Colors.blue,
            //  onPressed: () {},
            //),
            IconButton(
              icon: Icon(Icons.update),
              color: Colors.blue,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    LoadingPage.routeName, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: ListView(
                children: bottom,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Slider(
                    min: 1.0,
                    max: 8.0,
                    value: minMagnitude,
                    divisions: 7,
                    label: minMagnitude.toString(),
                    onChanged: (double newValue) {
                      filterResult(newValue);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// getFlatButtons(_details)
