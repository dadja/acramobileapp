import 'package:acra/models/forms/waterdata.dart';
import 'package:acra/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:acra/ui/villagequest/forms/waterform.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/uidata.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/ui/villagequest/details/detail_water.dart';
import 'package:acra/app_localization.dart';

class WaterScreen extends StatefulWidget {
  final Village village;
  final Setting setup;
  WaterScreen({this.village, this.setup});
  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  Stream lookforwaters;

  var nodatafound = "";

  @override
  void initState() {
    // getprefs();
    lookforwaters =
        DataBaseService.getWaterPlaces(widget.village, widget.setup);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nodatafound = AppLocalizations.of(context).translate('no_data_found');
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.watercolordark,
          title: Text(AppLocalizations.of(context)
              .translate('water_screen_appbartitle')),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder<List<WaterData>>(
            stream: lookforwaters,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Center(child: Text("Error! ${asyncSnapshot.error} "));
              }
              if (asyncSnapshot.hasData) {
                if (asyncSnapshot.data.length == 0) {
                  return noDataFoundWidget(nodatafound);
                } else {
                  return makeBody(asyncSnapshot.data);
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: UIData.watercolordark,
          onPressed: () {
            Route gotoaction = MaterialPageRoute(
                builder: (context) => WaterForm(
                      village: widget.village,
                    ));
            Navigator.of(context).push(gotoaction);
          },
        ),
      ),
    );
  }

  Widget makeCard(WaterData village, BuildContext context, Color colorlight) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            BoxDecoration(color: colorlight), //Color.fromRGBO(64, 75, 96, .9))
        child:
            makeListTile(village, context, UIData.watercolordark, Colors.black),
      ),
    );
  }

  Widget makeListTile(WaterData village, BuildContext context,
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
          )),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        " ${village.nompointeau} ",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        " ${setupDate(village.date)}",
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: UIData.watercolordark, size: 30.0),
      onTap: () {
        Route detailvillagepage = MaterialPageRoute(
            builder: (context) => DetailWater(
                  water: village,
                ));
        Navigator.of(context).push(detailvillagepage);
      },
    );
  }

  Widget makeBody(List<WaterData> latrines) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: latrines.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(latrines[index], context, UIData.watercolorlight);
        },
      ),
    );
  }
}
