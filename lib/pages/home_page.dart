import 'package:flutter/material.dart';
import 'package:guncel_son_depremler/pages/detail_page.dart';
import 'package:guncel_son_depremler/widgets/cards.dart';
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

  @override
  Widget build(BuildContext context) {
    _details = ModalRoute.of(context).settings.arguments;
    const Key centerKey = ValueKey('bottom-sliver-list');
    bottom = getFlatButtons(_details);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SON DEPREMLER'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.youtube_searched_for),
              onPressed: () {
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: _details);
              },
            ),
            IconButton(
              icon: Icon(Icons.update),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    LoadingPage.routeName, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              key: centerKey,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    height: 100 + 0.5,
                    child: bottom[index],
                  );
                },
                childCount: bottom.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// getFlatButtons(_details)
