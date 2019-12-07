import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:acra/ui/villagequest/forms/dangerform.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/villagequest/details/detail_danger.dart';
import 'package:acra/app_localization.dart';

class DangerScreen extends StatefulWidget {
  final Village village;
  final Setting setup;

  DangerScreen({this.village, this.setup});
  @override
  _DangerScreenState createState() => _DangerScreenState();
}

class _DangerScreenState extends State<DangerScreen> {
  Stream lookfordanger;
  var nodatafound = "";
  void initStreams() async {
    lookfordanger = DataBaseService.getDangers(widget.village, widget.setup);
  }

  @override
  void initState() {
    // initStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nodatafound = AppLocalizations.of(context).translate('no_data_found');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.dangercolordark,
        title: Text("Dangers (WSP)"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<List<DangerData>>(
          // stream: lookfordanger,
          stream: DataBaseService.getDangers(widget.village, widget.setup),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(child: Text("Error!"));
            }
            if (asyncSnapshot.hasData) {
              if (asyncSnapshot.data.length == 0) {
                return Center(child: noDataFoundWidget(nodatafound));
              } else {
                return makeBody(asyncSnapshot.data);
              }
              // return makeBody(asyncSnapshot.data);
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
        backgroundColor: UIData.dangercolordark,
        onPressed: () {
          // print("Region is ${widget.village.region}");
          Route gotoaction = MaterialPageRoute(
              builder: (context) => DangerForm(village: widget.village));
          Navigator.of(context).push(gotoaction);
        },
      ),
    );
  }

  Widget makeCard(DangerData village, BuildContext context, Color colorlight) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            BoxDecoration(color: colorlight), //Color.fromRGBO(64, 75, 96, .9))
        child: makeListTile(
            village, context, UIData.dangercolordark, Colors.black),
      ),
    );
  }

  Widget makeListTile(DangerData village, BuildContext context,
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
        " ${village.nom} ",
        style: TextStyle(
            color: UIData.dangercolordark, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        " ${setupDate(village.date)}",
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: UIData.dangercolordark, size: 30.0),
      onTap: () {
        Route detailvillagepage = MaterialPageRoute(
            builder: (context) => DetailDanger(
                  realdanger: village,
                ));
        Navigator.of(context).push(detailvillagepage);
      },
    );
  }

  Widget makeBody(List<DangerData> dangers) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dangers.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(dangers[index], context, UIData.dangercolorlight);
        },
      ),
    );
  }
}
