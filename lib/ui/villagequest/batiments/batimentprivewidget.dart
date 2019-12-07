import 'package:flutter/material.dart';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/ui/villagequest/details/detail_batpriv.dart';
import 'package:acra/app_localization.dart';

Widget buildbatimentprive(Stream futuresync) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: StreamBuilder<List<BatimentPriveData>>(
      stream: futuresync,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(child: Text("Error!"));
        } else if (asyncSnapshot.data == null) {
          return Center(
              child: Text(
                  AppLocalizations.of(context).translate('no_data_found')));
        } else if (asyncSnapshot.hasData) {
          if (asyncSnapshot.data.length == 0) {
            return noDataFoundWidget(
                AppLocalizations.of(context).translate('no_data_found'));
          } else {
            return makeBody(asyncSnapshot.data);
          }
        } else
          return CircularProgressIndicator();
      },
    ),
  );
}

Widget makeCard(
    BatimentPriveData village, BuildContext context, Color colorlight) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration:
          BoxDecoration(color: colorlight), //Color.fromRGBO(64, 75, 96, .9))
      child:
          makeListTile(village, context, UIData.batprivcolordark, Colors.black),
    ),
  );
}

Widget makeListTile(BatimentPriveData village, BuildContext context,
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
      " ${village.nomproprio} ",
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      " ${setupDate(village.date)}",
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: UIData.batprivcolordark, size: 30.0),
    onTap: () {
      Route detailvillagepage = MaterialPageRoute(
          builder: (context) => DetailBatimentPrive(
                batpriv: village,
              ));
      Navigator.of(context).push(detailvillagepage);
    },
  );
}

Widget makeBody(List<BatimentPriveData> latrines) {
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: latrines.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(latrines[index], context, UIData.batprivcolorlight);
      },
    ),
  );
}
