import 'package:acra/export/exportdata.dart';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/models/village.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:acra/resources/db.dart';
import 'package:acra/uidata.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:acra/app_localization.dart';

// Center of the Google Map
const initialPosition = LatLng(14.6937, -17.44406);
// Hue used by the Google Map Markers to match the theme

class MapScreen extends StatefulWidget {
  const MapScreen({@required this.setup});

  final Setting setup;
  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  Stream<QuerySnapshot> _iceCreamStores;
  final Completer<GoogleMapController> _mapController = Completer();

  ExportData exportData = ExportData();
  List<DangerData> dangers = List();
  List<LatrineData> latrines = List();
  List<BatimentPriveData> batprivs = List();
  List<BatimentPublicData> batpubs = List();
  List<WaterData> waters = List();

  @override
  void initState() {
    super.initState();
    _iceCreamStores = DataBaseService.streamgetmyallCollecte(widget.setup);
  }

  void startextraction() async {
    dangers.clear();
    waters.clear();
    batprivs.clear();
    batpubs.clear();
    latrines.clear();
    //feed the lists first
    // var querysnapshotstream = _iceCreamStores.single;

    var querysnapshot = await DataBaseService.getallCollecte(widget.setup);

    print("NONO Querysnap length ${querysnapshot.documents.length}");
    querysnapshot.documents.forEach((doc) {
      switch (doc.data['typecollecte']) {
        case TypeCollecte.collectdanger:
          dangers.add(DangerData.fromFireStore(doc));
          break;
        case TypeCollecte.collectelatrines:
          latrines.add(LatrineData.fromFireStore(doc));
          break;
        case TypeCollecte.collectepointeau:
          waters.add(WaterData.fromFireStore(doc));
          break;
        case TypeCollecte.collectebatimentprive:
          batprivs.add(BatimentPriveData.fromFireStore(doc));
          break;
        case TypeCollecte.collectebatimentpublic:
          batpubs.add(BatimentPublicData.fromFireStore(doc));
          break;
      }
    });

    //start export...
    if (batprivs.length != 0) {
      await exportData.exportbatimentprives(context, batprivs);
    } else {
      print("NONO BATPRIV");
    }
    if (batpubs.length != 0) {
      await exportData.exportbatimentpublics(context, batpubs);
    } else {
      print("NONO BATPUB");
    }
    if (latrines.length != 0) {
      await exportData.exportlatrines(context, latrines);
    } else {
      print("NONO LATRINES");
    }
    if (waters.length != 0) {
      await exportData.exportpointeau(context, waters);
    } else {
      print("NONO WATER");
    }
    if (dangers.length != 0) {
      await exportData.exportdangers(context, dangers);
    } else {
      print("NONO DANGER");
    }

    final String dir = (await getExternalStorageDirectory()).path;

    print("extraction done check the folder at $dir");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('map_appbar_title')),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.import_export,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO start the export
              startextraction();
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _iceCreamStores,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
                    '${AppLocalizations.of(context).translate('generic_error_title')} ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                AppLocalizations.of(context).translate('generic_loading_msg'),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: StoreMap(
                    documents: snapshot.data.documents,
                    initialPosition: (snapshot.data.documents.length != 0)
                        ? LatLng(
                            double.parse(
                                snapshot.data.documents[0].data['latitude']),
                            double.parse(
                                snapshot.data.documents[0].data['longitude']))
                        : initialPosition,
                    mapController: _mapController,
                  ),
                ),
                Container(
                  // decoration: Decoration(),
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  height: 50.0,
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('generic_mycollect_msg'),
                  ),
                ),
                Expanded(
                  child: StoreCarousel(
                    mapController: _mapController,
                    documents: snapshot.data.documents,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StoreCarousel extends StatelessWidget {
  const StoreCarousel({
    Key key,
    @required this.documents,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    // return Align(
    //   alignment: Alignment.topLeft,
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 10),
    //     child: SizedBox(
    //       height: 90,
    //       child:
    return StoreCarouselList(
      documents: documents,
      mapController: mapController,
    );
    //     ),
    //   ),
    // );
  }
}

class StoreCarouselList extends StatelessWidget {
  const StoreCarouselList({
    Key key,
    @required this.documents,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: StoreListTile(
              document: documents[index],
              mapController: mapController,
            ),
          ),
        );
      },
    );
  }
}

class StoreListTile extends StatefulWidget {
  const StoreListTile({
    Key key,
    @required this.document,
    @required this.mapController,
  }) : super(key: key);
  final DocumentSnapshot document;
  final Completer<GoogleMapController> mapController;

  @override
  State<StatefulWidget> createState() {
    return _StoreListTileState();
  }
}

class _StoreListTileState extends State<StoreListTile> {
  String _placePhotoUrl = '';
  double _zoomFactor = 20.0; //16;
  @override
  void initState() {
    super.initState();
    _placePhotoUrl = CollecteActions.rightpicture(widget.document);
    // _retrievePlacesDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var title = CollecteActions.righttitle(widget.document);
    var subtitle = CollecteActions.rightsubtitle(widget.document);
    var color = CollecteActions.rightcolor(widget.document);
    return ListTile(
      title: Text(
        "$title",
        style: TextStyle(color: color),
      ),
      subtitle: Text(
          "${AppLocalizations.of(context).translate('generic_nom')} :  $subtitle"),
      leading: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(color: color),
        child: _placePhotoUrl.isNotEmpty
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    _placePhotoUrl,
                    color: color,
                  ),
                ),
              )
            : Container(),
      ),
      onTap: () async {
        final controller = await widget.mapController.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                double.parse(widget.document['latitude']),
                double.parse(widget.document['longitude']),
              ),
              zoom: _zoomFactor,
            ),
          ),
        );
      },
    );
  }
}

class StoreMap extends StatelessWidget {
  const StoreMap({
    Key key,
    @required this.documents,
    @required this.initialPosition,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
      markers: documents
          .map((document) => Marker(
                markerId: MarkerId(document.documentID),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    CollecteActions.righthue(document)),
                position: LatLng(
                  double.parse(document['latitude']),
                  double.parse(document['longitude']),
                ),
                infoWindow: InfoWindow(
                  onTap: () {
                    CollecteActions.rightpagetogoto(
                        document, context); //Enrolme
                  },
                  title: CollecteActions.righttitle(document),
                  snippet: CollecteActions.rightsubtitle(document),
                ),
              ))
          .toSet(),
      onMapCreated: (mapController) {
        this.mapController.complete(mapController);
      },
    );
  }
}
