import 'package:flutter/material.dart';
import 'package:guncel_son_depremler/modules/earthquake.dart';
import 'package:guncel_son_depremler/pages/home_page.dart';

class DetailPage extends StatelessWidget {
  List<EarthquakesModel> _details = List<EarthquakesModel>();
  List<EarthquakesModel> _newDetails = List<EarthquakesModel>();
  final _formKey = GlobalKey<FormState>();
  static const String routeName = '/detailPage';
  @override
  Widget build(BuildContext context) {
    _details = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detaylı Arama"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Minumum Deprem büyüklüğü Giriniz. Örn: 5.1',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Lütfen Bir Sayı Giriniz.';
                    }
                    try {
                      if (_details != null && _details.any((element) => true)) {
                        _details.forEach((element) {
                          if (double.parse(element.magnitude) >
                              double.parse(value)) {
                            _newDetails.add(element);
                          }
                        });
                        Navigator.pushNamedAndRemoveUntil(context,
                            HomePage.routeName, (Route<dynamic> route) => false,
                            arguments: _newDetails);
                      }
                    } catch (ex) {
                      return 'Lütfen Bir Sayı Giriniz. Örneğin 4.8';
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
