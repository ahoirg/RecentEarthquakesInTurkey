import 'dart:async';
import 'dart:convert';
import 'package:guncel_son_depremler/modules/earthquake.dart';
import 'package:http/http.dart' as http;
import '../utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHelper {
  Future<String?> getEarthquakes() async {
    var response = await http.get(Uri.parse(url + '?limit=150'));
    if (response.statusCode != 504) {
      response = await http.get(Uri.parse(url + '?limit=150'));
    }
    if (response.statusCode != 200) {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('data');
      if (data != null) return data;
      return null;
    }

    return response.body;
  }
}

class EarthquakesDetail {
  Future<List<EarthquakesModel>> getDetail() async {
    dynamic details;
    dynamic result;
    final prefs = await SharedPreferences.getInstance();
    List<EarthquakesModel> list = <EarthquakesModel>[];

    final data = prefs.getString('data');
    final date = prefs.getString('date');

    if (data != null &&
        date != null &&
        DateTime.now().difference(DateTime.parse(jsonDecode(date))).inMinutes <
            1) {
      result = jsonDecode(data);
      details = result['result'];
    } else {
      NetworkHelper _networkHelper = NetworkHelper();
      var temp = await _networkHelper.getEarthquakes();
      if (temp == null){
        return list;
      }
      prefs.setString('data', temp);
      prefs.setString('date', jsonEncode(DateTime.now().toString()));

      result = jsonDecode(temp);
      details = result['result'];
    }

    details.forEach((element) {
      try {
        var coordinates = element['geojson']['coordinates'];

        EarthquakesModel _earthquakesModel = new EarthquakesModel();
        _earthquakesModel.magnitude = element['mag'].toString();
        _earthquakesModel.latitude = coordinates[1];
        _earthquakesModel.longitude = coordinates[0];
        _earthquakesModel.location = element['location_tz'];
        _earthquakesModel.depth = element['depth'].toString();
        _earthquakesModel.date = element['date_time'];
        list.add(_earthquakesModel);
      } catch (ex) {
        print(ex);
      }
    });
    return list;
  }
}
