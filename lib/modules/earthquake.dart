import '../services/services.dart';
import 'dart:convert';

class EarthquakesModel {
  String magnitude;
  double latitude;
  double longitude;
  String location;
  String depth;
  String date;

  EarthquakesModel({
    this.magnitude,
    this.latitude,
    this.longitude,
    this.location,
    this.depth,
    this.date,
  });
}
