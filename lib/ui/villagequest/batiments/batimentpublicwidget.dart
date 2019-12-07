import 'package:flutter/material.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/ui/villagequest/details/detail_batpub.dart';
import 'package:acra/app_localization.dart';

Widget buildbatimentpublic(Stream futuresync) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: StreamBuilder<List<BatimentPublicData>>(
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
          // return makeBody(asyncSnapshot.data);
        } else
          return CircularProgressIndicator();
      },
    ),
    // child: StreamBuilder<List<BatimentPublicData>>(
    //   stream: futuresync.asStream(),
    //   builder: (context,asyncSnapshot){

    //       if (asyncSnapshot.hasError) {
    //         return  Center(child: Text("Error!"));
    //       } else if (asyncSnapshot.data == null) {
    //         return  Center(child: Text("No data Founds"));
    //       }else if(asyncSnapshot.hasData){
    //          return Center(child: Text("data Founds! nbr elements captured are ${asyncSnapshot.data.length} "));
    //       }
    //       else return CircularProgressIndicator();

    //   },
    // ),
  );
}

Widget makeCard(
    BatimentPublicData village, BuildContext context, Color colorlight) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration:
          BoxDecoration(color: colorlight), //Color.fromRGBO(64, 75, 96, .9))
      child:
          makeListTile(village, context, UIData.batpubcolordark, Colors.black),
    ),
  );
}

Widget makeListTile(BatimentPublicData village, BuildContext context,
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
      " ${village.nombatiment} ",
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      " ${setupDate(village.date)}",
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: UIData.batpubcolordark, size: 30.0),
    onTap: () {
      Route detailvillagepage = MaterialPageRoute(
          builder: (context) => DetailBatimentPublic(
                batpub: village,
              ));
      Navigator.of(context).push(detailvillagepage);
    },
  );
}

Widget makeBody(List<BatimentPublicData> latrines) {
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: latrines.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(latrines[index], context, UIData.batpubcolorlight);
      },
    ),
  );
}
