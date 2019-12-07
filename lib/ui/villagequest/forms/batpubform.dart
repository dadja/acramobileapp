import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:acra/uidata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/models/user_location.dart';
import 'package:acra/app_localization.dart';

//TODO to test and finish setup.....

class BatimentPublicForm extends StatefulWidget {
  final Village village;
  BatimentPublicForm({this.village});
  static _BatimentPublicFormState of(BuildContext context) => context
      .ancestorStateOfType(const TypeMatcher<_BatimentPublicFormState>());
  @override
  _BatimentPublicFormState createState() => _BatimentPublicFormState();
}

class _BatimentPublicFormState extends State<BatimentPublicForm> {
  final formkey = GlobalKey<FormState>();
  Location location = Location();
  Setting setup = Setting();
  UserLocation phonelocation;
  String typebatiment;
  String typeecole;
  String typesante;
  String typereligieux;

  BatimentPublicData batpub = BatimentPublicData();

  TextEditingController nomcontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  _nombatimentlistener() {
    setState(() {
      batpub.nombatiment = nomcontroller.text;
    });
  }

  _notelistener() {
    setState(() {
      batpub.note = notecontroller.text;
    });
  }

  void getprefs() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
  }

  @override
  void initState() {
    // getLocation();
    // TODO: implement initState
    super.initState();
    getprefs();
    typebatiment = "";

    typeecole = "";
    typesante = "";
    typereligieux = "";
    nomcontroller.addListener(_nombatimentlistener);
    notecontroller.addListener(_notelistener);
    // position =
  }

  @override
  void dispose() {
    nomcontroller.dispose();
    notecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _saveForm() {
    var form = formkey.currentState;
    if (form.validate()) {
      getprefs();
      if (setup != null && setup.collectorId.isNotEmpty) {
        if (phonelocation != null) {
          print(
              "currentlocation is lat => ${phonelocation.latitude} long => ${phonelocation.longitude}");
          batpub.partenaire = setup.partnerId;
          batpub.collecteur = setup.collectorId;
          batpub.typecollecte = TypeCollecte.collectebatimentpublic;
          batpub.region = widget.village.region;
          batpub.departement = widget.village.departement;
          batpub.arrondissement = widget.village.arrondissement;
          batpub.commune = widget.village.commune;
          batpub.village = widget.village.nom;
          batpub.latitude = phonelocation.latitude.toString();
          batpub.longitude = phonelocation.longitude.toString();
          batpub.nombatiment = nomcontroller.text;
          batpub.note = notecontroller.text;
          batpub.pays = "Senegal";

          DataBaseService.addBatimenpublic(batpub);

          print("batpub ${batpub.toJson().toString()}");
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_content'),
              UIData.batpubcolordark,
              gotoListVillagepage);
          form.save();
        } else {
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_content'),
              UIData.batpubcolordark,
              null);
        }
      } else {
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_content'),
            UIData.batpubcolordark,
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
        backgroundColor: UIData.batpubcolordark,
        title:
            Text(AppLocalizations.of(context).translate('batpub_appbartitle')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => batpub,
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {
                        batpub.nombatiment = term;
                      },
                      controller: nomcontroller,
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('batpub_form_nombatiment_label'),
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
                      .translate('batpub_form_dropdown_typebatiment_title')),

                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      // required: true,
                      titleText: AppLocalizations.of(context)
                          .translate('batpub_form_info_typebatiment'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: typebatiment,
                      onChanged: (value) {
                        setState(() {
                          typebatiment = value;
                          batpub.typebatiment = value;
                          //as we no have options lets setup a default option for these ...
                          if (value == "Divers")
                            batpub.soustypebatiment = "Divers";
                          if (value == "Various")
                            batpub.soustypebatiment = "Various";
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataBatimentPublic.typebatiments
                              : DataBatimentPublic.typebatiments_en,
                      textField: 'display',
                      valueField: 'display',
                      errorText: "Choisissez un type batiment svp!",
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  (batpub.typebatiment == "Ecole" ||
                          batpub.typebatiment == "School")
                      ? Container(
                          padding: EdgeInsets.all(16),
                          child: DropDownFormField(
                            titleText: AppLocalizations.of(context)
                                .translate('batpub_form_dropdown_school'),
                            hintText: AppLocalizations.of(context)
                                .translate('generic_dropdown_subtitle_msg'),
                            value: typeecole,
                            onChanged: (value) {
                              setState(() {
                                typeecole = value;
                                batpub.soustypebatiment = value;
                              });
                            },
                            dataSource: (AppLocalizations.of(context)
                                        .translate('lang') ==
                                    Lang.fr)
                                ? DataBatimentPublic.batecoles
                                : DataBatimentPublic.batecoles_en,
                            textField: 'display',
                            valueField: 'display',
                            errorText: AppLocalizations.of(context).translate(
                                'batpub_form_dropdown_generic_errormsg'),
                          ),
                        )
                      : Container(),
                  //  SizedBox(
                  //   height: 10.0,
                  // ),
                  (batpub.typebatiment == "Structure réligieuse" ||
                          batpub.typebatiment == "Religious structure")
                      ? Container(
                          padding: EdgeInsets.all(16),
                          child: DropDownFormField(
                            titleText: AppLocalizations.of(context)
                                .translate('batpub_form_dropdown_religious'),
                            hintText: AppLocalizations.of(context)
                                .translate('generic_dropdown_subtitle_msg'),
                            value: typereligieux,
                            onChanged: (value) {
                              setState(() {
                                typereligieux = value;
                                batpub.soustypebatiment = value;
                                // val = value;
                                // rval = value;
                              });
                            },
                            dataSource: (AppLocalizations.of(context)
                                        .translate('lang') ==
                                    Lang.fr)
                                ? DataBatimentPublic.batreligieux
                                : DataBatimentPublic.batreligieux_en,
                            textField: 'display',
                            valueField: 'display',
                            errorText: AppLocalizations.of(context).translate(
                                'batpub_form_dropdown_generic_errormsg'),
                          ),
                        )
                      : Container(),
                  //  SizedBox(
                  //   height: 10.0,
                  // ),
                  (batpub.typebatiment == "Structure sanitaire" ||
                          batpub.typebatiment == "Health structure")
                      ? Container(
                          padding: EdgeInsets.all(16),
                          child: DropDownFormField(
                            titleText: AppLocalizations.of(context)
                                .translate('batpub_form_dropdown_health'),
                            hintText: AppLocalizations.of(context)
                                .translate('generic_dropdown_subtitle_msg'),
                            value: typesante,
                            onChanged: (value) {
                              setState(() {
                                typesante = value;
                                batpub.soustypebatiment = value;
                              });
                            },
                            dataSource: (AppLocalizations.of(context)
                                        .translate('lang') ==
                                    Lang.fr)
                                ? DataBatimentPublic.batsante
                                : DataBatimentPublic.batsante_en,
                            textField: 'display',
                            valueField: 'display',
                            errorText: AppLocalizations.of(context).translate(
                                'batpub_form_dropdown_generic_errormsg'),
                          ),
                        )
                      // dropbatsante(context, batpub.soustypebatiment) //typesante
                      : Container(),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('generic_batiment_form_robinet_present')),
                      value: batpub.robinetexistant,
                      activeColor: UIData.batpubcolordark,
                      onChanged: (val) {
                        setState(() => batpub.robinetexistant = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),

                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context).translate(
                          'generic_batiment_form_robinet_fonctionnel')),
                      value: batpub.robinetfonctionnel,
                      activeColor: UIData.batpubcolordark,
                      onChanged: (val) {
                        setState(() => batpub.robinetfonctionnel = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      maxLines: 4,
                      //textInputAction: TextInputAction.next,
                      onSaved: (term) {
                        // .note = term;
                        batpub.note = term;
                      },
                      controller: notecontroller,
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
                      color: UIData.batpubcolordark,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('generic_create_bouton_label'),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _saveForm,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
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
