import 'dart:convert';
import 'dart:io';
import 'package:guncel_son_depremler/modules/earthquake.dart';
import 'package:http/http.dart' as http;
import '../utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHelper {
  Future getEarthquakes() async {
    var response = await http.get(url + '?limit=150');
    if (response.statusCode != 504) {
      Duration _d = new Duration(seconds: 5);
      sleep(_d);
      response = await http.get(url + '?limit=150');
    }
    if (response.statusCode != 200) {
      final _prefs = await SharedPreferences.getInstance();
      final _data = _prefs.getString('data');
      if (_data != null) return _data;
      return;
    }
    return response.body;
  }
}

class EarthquakesDetail {
  Future<dynamic> getDetail() async {
    dynamic _details;
    dynamic _result;
    final _prefs = await SharedPreferences.getInstance();
    List<EarthquakesModel> _list = List<EarthquakesModel>();

    final _data = _prefs.getString('data');
    final _date = _prefs.getString('date');

    if (_data != null &&
        _date != null &&
        DateTime.now().difference(DateTime.parse(jsonDecode(_date))).inMinutes <
            3) {
      var _result = jsonDecode(_data);
      _details = _result['result'];
    } else {
      NetworkHelper _networkHelper = NetworkHelper();
      var _temp = await _networkHelper.getEarthquakes();
      _prefs.setString('data', _temp);
      _prefs.setString('date', jsonEncode(DateTime.now().toString()));

      _result = jsonDecode(_temp);
      _details = _result['result'];
    }

    _details.forEach((element) {
      try {
        EarthquakesModel _earthquakesModel = new EarthquakesModel();
        _earthquakesModel.magnitude = element['mag'].toString();
        _earthquakesModel.latitude = element['lat'];
        _earthquakesModel.longitude = element['lng'];
        _earthquakesModel.location = element['lokasyon'];
        _earthquakesModel.depth = element['depth'].toString();
        _earthquakesModel.date = element['date'];
        _list.add(_earthquakesModel);
      } catch (ex) {
        print(ex);
      }
    });
    return _list;
  }
}
