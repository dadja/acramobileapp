import 'package:acra/models/settings.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:acra/uidata.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:acra/models/village.dart';
import 'package:acra/models/user_location.dart';
import 'package:acra/app_localization.dart';

class DangerForm extends StatefulWidget {
  final Village village;
  DangerForm({this.village});
  @override
  _DangerFormState createState() => _DangerFormState();
}

class _DangerFormState extends State<DangerForm> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  // LocationData currentLocation;
  Location location = new Location();
  Setting setup = Setting();

  String typedanger;
  String typedangerresult;
  DangerData danger = DangerData();
  // DataBaseService dataBaseService = DataBaseService();
  TextEditingController formedit = TextEditingController();
  TextEditingController nomdangercontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  UserLocation phonelocation;

  void getprefs() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
  }

  _latestnomcontroller() {
    setState(() {
      danger.nom = nomdangercontroller.text;
    });
  }

  _latestnotecontroller() {
    setState(() {
      danger.note = notecontroller.text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
    typedanger = "";
    typedangerresult = "";
    nomdangercontroller.addListener(_latestnomcontroller);
    notecontroller.addListener(_latestnotecontroller);
    // position =
  }

  @override
  void dispose() {
    formedit.dispose();
    nomdangercontroller.dispose();
    notecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _saveForm() {
    var form = formkey.currentState;

    if (form.validate()) {
      // form.save();
      // setState(() {
      if (setup != null && setup.collectorId.isNotEmpty) {
        if (phonelocation != null) {
          print(
              "currentlocation is lat => ${phonelocation.latitude} long => ${phonelocation.longitude}");
          typedangerresult = typedanger;
          danger.type = typedangerresult;
          danger.latitude = phonelocation.latitude.toString();
          danger.longitude = phonelocation.longitude.toString();
          danger.partenaire = setup.partnerId; //"salut@salut.com";
          danger.collecteur = setup.collectorId; //"dadja";
          danger.typecollecte = TypeCollecte.collectdanger;
          danger.date = DateTime.now();
          danger.region = widget.village.region;
          danger.departement = widget.village.departement;
          danger.arrondissement = widget.village.arrondissement;
          danger.commune = widget.village.commune;
          danger.village = widget.village.nom;
          danger.pays = "Senegal";

          DataBaseService.addDanger(danger);

          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_content'),
              UIData.dangercolordark,
              gotoListVillagepage);
        } else {
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_content'),
              UIData.dangercolordark,
              null);
        }
      } else {
        print("device not configured ");
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_content'),
            UIData.dangercolordark,
            gotoListVillagepage);
      }

      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    phonelocation = Provider.of<UserLocation>(context);
    print(
        "user location lat ${phonelocation.latitude} long ${phonelocation.longitude}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: UIData.dangercolordark,
        title: Text(
            AppLocalizations.of(context).translate('danger_form_appbartitle')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => danger,
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: nomdangercontroller,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {
                        danger.nom = term;
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('danger_form_nom_label_title'),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('generic_textfield_error');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(AppLocalizations.of(context)
                      .translate('danger_form_info_typedanger_title')),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context)
                          .translate('danger_form_danger_dropdown_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: typedanger,
                      // onSaved: (value) {
                      //   setState(() {
                      //     typedanger = value;

                      //   });
                      // },
                      onChanged: (value) {
                        setState(() {
                          typedanger = value;
                          danger.type = value;
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataDanger.typedangers
                              : DataDanger.typedangers_en,
                      textField: 'display',
                      valueField: 'display',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: notecontroller,
                      maxLines: 4,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {
                        danger.note = term;
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('generic_note_label'),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return AppLocalizations.of(context)
                      //         .translate('generic_textfield_error');
                      //   }
                      // },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      color: UIData.dangercolordark,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('generic_create_bouton_label'),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _saveForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void gotoListVillagepage() {
    Route gotoaction = MaterialPageRoute(builder: (context) => VillageScreen());
    Navigator.of(context).push(gotoaction);
  }
}
