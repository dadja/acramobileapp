import 'package:flutter/material.dart';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/village.dart';
import 'package:acra/uidata.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/models/user_location.dart';
import 'package:acra/app_localization.dart';

class BatimentPriveForm extends StatefulWidget {
  final Village village;
  BatimentPriveForm({this.village});
  static _BatimentPriveFormState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_BatimentPriveFormState>());
  @override
  _BatimentPriveFormState createState() => _BatimentPriveFormState();
}

class _BatimentPriveFormState extends State<BatimentPriveForm> {
  final formkey = GlobalKey<FormState>();
  // LocationData currentLocation;
  Location location = new Location();
  UserLocation phonelocation;
  Setting setup = Setting();

  BatimentPriveData batpriv = BatimentPriveData();

  TextEditingController nompropriocontroller = TextEditingController();
  TextEditingController numpropriocontroller = TextEditingController();
  TextEditingController nbrenfantscontroller = TextEditingController();
  TextEditingController nbradultescontroller = TextEditingController();
  TextEditingController nbrvieuxcontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  void getprefs() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
  }

  _latestnbrvieuxcontroller() {
    setState(() {
      batpriv.nbrvieux = int.tryParse(nbrvieuxcontroller.text) ?? 0;
    });
  }

  _latestnbradultescontroller() {
    setState(() {
      batpriv.nbradultes = int.tryParse(nbradultescontroller.text) ?? 0;
    });
  }

  _latestnbrenfantscontroller() {
    setState(() {
      batpriv.nbrenfants = int.tryParse(nbrenfantscontroller.text) ?? 0;
    });
  }

  _latestnumpropriocontroller() {
    setState(() {
      batpriv.numproprio = numpropriocontroller.text;
    });
  }

  _latestnompropriocontroller() {
    setState(() {
      batpriv.nomproprio = nompropriocontroller.text;
    });
  }

  _latestnotecontroller() {
    setState(() {
      batpriv.note = notecontroller.text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
    nbrvieuxcontroller.addListener(_latestnbrvieuxcontroller());
    nbrenfantscontroller.addListener(_latestnbrenfantscontroller());
    nbradultescontroller.addListener(_latestnbradultescontroller());
    numpropriocontroller.addListener(_latestnumpropriocontroller());
    nompropriocontroller.addListener(_latestnompropriocontroller());
    notecontroller.addListener(_latestnotecontroller());
  }

  @override
  void dispose() {
    nbrenfantscontroller.dispose();
    nbrenfantscontroller.dispose();
    nbradultescontroller.dispose();
    numpropriocontroller.dispose();
    nompropriocontroller.dispose();
    notecontroller.dispose();
    // formedit.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _saveForm() {
    var form = formkey.currentState;
    if (form.validate()) {
      if (setup != null && setup.collectorId.isNotEmpty) {
        form.save();

        if (phonelocation != null) {
          print(
              "currentlocation is lat => ${phonelocation.latitude} long => ${phonelocation.longitude}");

          batpriv.nbrvieux = int.tryParse(nbrvieuxcontroller.text) ?? 0;
          batpriv.nbradultes = int.tryParse(nbradultescontroller.text) ?? 0;
          batpriv.nbrenfants = int.tryParse(nbrenfantscontroller.text) ?? 0;
          batpriv.numproprio = numpropriocontroller.text;
          batpriv.nomproprio = nompropriocontroller.text;
          batpriv.note = notecontroller.text;
          batpriv.partenaire = setup.partnerId; //"salut@salut.com";
          batpriv.collecteur = setup.collectorId; //"dadja";
          batpriv.typecollecte = TypeCollecte.collectebatimentprive;
          batpriv.region = widget.village.region;
          batpriv.departement = widget.village.departement;
          batpriv.arrondissement = widget.village.arrondissement;
          batpriv.commune = widget.village.commune;
          batpriv.village = widget.village.nom;
          batpriv.latitude = phonelocation.latitude.toString();
          batpriv.longitude = phonelocation.longitude.toString();
          batpriv.pays = "Senegal";

          DataBaseService.addBatimentPrive(batpriv);

          print("batpriv ${batpriv.toJson().toString()}");

          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_content'),
              UIData.batprivcolordark,
              gotoListVillagepage);
        } else {
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_content'),
              UIData.batprivcolordark,
              null);
        }
      } else {
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_content'),
            UIData.batprivcolordark,
            gotoListVillagepage);
      }
    }
  }

  void gotoListVillagepage() {
    Route gotoaction = MaterialPageRoute(builder: (context) => VillageScreen());
    Navigator.of(context).push(gotoaction);
  }

  @override
  Widget build(BuildContext context) {
    phonelocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.batprivcolordark,
        title:
            Text(AppLocalizations.of(context).translate('batpriv_appbartitle')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => batpriv,
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: nompropriocontroller,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {},
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpriv_nomproprio_label'),
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
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: numpropriocontroller,
                      keyboardType: TextInputType.number,
                      ////textInputAction: TextInputAction.next,
                      onSaved: (term) {},
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpriv_numproprio_label'),
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
                  Center(
                    child: Text(AppLocalizations.of(context)
                        .translate('batpriv_info_nbrpersonnes_label')),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: nbrenfantscontroller,
                      keyboardType: TextInputType.number,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {},
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpriv_nbrenfants_label'),
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
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: nbradultescontroller,
                      keyboardType: TextInputType.number,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {},
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpriv_nbradultes_label'),
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
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: nbrvieuxcontroller,
                      keyboardType: TextInputType.number,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {},
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpriv_nbrvieux_label'),
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
                  // Row(
                  //   children: <Widget>[
                  //     Checkbox(
                  //       value: batpriv.robinetexistant,
                  //       onChanged: (bool value) {
                  //         setState(() {
                  //           batpriv.robinetexistant = value;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     Text("Y'a-t-il un robinet ?"),
                  //   ],
                  // ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('generic_batiment_form_robinet_present')),
                      value: batpriv.robinetexistant,
                      activeColor: UIData.batprivcolordark,
                      onChanged: (val) {
                        setState(() => batpriv.robinetexistant = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context).translate(
                          'generic_batiment_form_robinet_fonctionnel')),
                      value: batpriv.robinetfonctionnel,
                      activeColor: UIData.batprivcolordark,
                      onChanged: (val) {
                        setState(() => batpriv.robinetfonctionnel = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: notecontroller,
                      maxLines: 4,
                      //textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        // .note = term;
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
                      color: UIData.batprivcolordark,
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
}
