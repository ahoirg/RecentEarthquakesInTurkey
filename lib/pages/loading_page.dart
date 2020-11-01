import 'package:flutter/material.dart';
import 'package:guncel_son_depremler/animation/spin_kit_double_bounce.dart';
import 'package:guncel_son_depremler/pages/home_page.dart';
import 'package:guncel_son_depremler/services/services.dart';

class LoadingPage extends StatefulWidget {
  static const routeName = '/loadingScreen';
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void initState() {
    super.initState();
    getEarthquakesDetail();
  }

  void getEarthquakesDetail() async {
    var _earthquakesDetail = EarthquakesDetail();
    var _result = await _earthquakesDetail.getDetail();
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.routeName, (Route<dynamic> route) => false,
        arguments: _result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
