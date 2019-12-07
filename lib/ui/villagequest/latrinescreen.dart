import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:acra/ui/villagequest/forms/latrineform.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/uidata.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/ui/villagequest/details/detail_latrine.dart';
import 'package:acra/app_localization.dart';

class LatrineScreen extends StatefulWidget {
  final Village village;
  final Setting setup;
  LatrineScreen({this.village, this.setup});
  @override
  _LatrineScreenState createState() => _LatrineScreenState();
}

class _LatrineScreenState extends State<LatrineScreen> {
  Stream lookforlatrines;
  var nodatafound = "";

  @override
  void initState() {
    lookforlatrines = DataBaseService.getLatrines(widget.village, widget.setup);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nodatafound = AppLocalizations.of(context).translate('no_data_found');
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.latrinecolordark,
          title: Text("Latrines"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder<List<LatrineData>>(
            stream: lookforlatrines,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Center(child: Text("Error!"));
              } else if (asyncSnapshot.data == null) {
                return Center(child: Text("No data Founds"));
              } else if (asyncSnapshot.hasData) {
                if (asyncSnapshot.data.length == 0) {
                  return noDataFoundWidget(nodatafound);
                } else {
                  return makeBody(asyncSnapshot.data);
                }
              } else
                return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: UIData.latrinecolordark,
          onPressed: () {
            Route gotoaction = MaterialPageRoute(
                builder: (context) => LatrineForm(village: widget.village));
            Navigator.of(context).push(gotoaction);
          },
        ),
      ),
    );
  }

  Widget makeCard(LatrineData village, BuildContext context, Color colorlight) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            BoxDecoration(color: colorlight), //Color.fromRGBO(64, 75, 96, .9))
        child: makeListTile(
            village, context, UIData.latrinecolordark, Colors.black),
      ),
    );
  }

  Widget makeListTile(LatrineData village, BuildContext context,
      Color coloricondark, Color color) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 80,
        color: coloricondark,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        " ${village.nomproprio} ",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        " ${setupDate(village.date)}",
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: UIData.latrinecolordark, size: 30.0),
      onTap: () {
        Route detailvillagepage = MaterialPageRoute(
            builder: (context) => DetailLatrine(
                  latrine: village,
                ));
        Navigator.of(context).push(detailvillagepage);
      },
    );
  }

  Widget makeBody(List<LatrineData> latrines) {
    print("latrines size ${latrines.length}");
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: latrines.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(latrines[index], context, UIData.latrinecolorlight);
        },
      ),
    );
  }
}
