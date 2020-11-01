import 'package:flutter/material.dart';
import '../modules/earthquake.dart';
import 'package:maps_launcher/maps_launcher.dart';

List<Widget> getFlatButtons(List<EarthquakesModel> _details) {
  if (_details == null) {
    return [];
  }

  List<Widget> _buttons = new List<Widget>();
  _details.forEach((element) {
    _buttons.add(getFlatButton(element));
  });
  return _buttons;
}

Widget getFlatButton(EarthquakesModel model) {
  var _location = model.location;
  return Card(
    child: Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: Container(
                child: Center(
                  child: Text(
                    model.magnitude,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        model.location,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(model.date),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.location_pin,
                size: 30,
              ),
              onPressed: () {
                MapsLauncher.launchCoordinates(model.latitude, model.longitude);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
