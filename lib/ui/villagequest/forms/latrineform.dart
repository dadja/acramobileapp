import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:acra/uidata.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/models/user_location.dart';
import 'package:acra/app_localization.dart';

class LatrineForm extends StatefulWidget {
  final Village village;
  LatrineForm({this.village});
  static _LatrineFormState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LatrineFormState>());
  @override
  _LatrineFormState createState() => _LatrineFormState();
}

class _LatrineFormState extends State<LatrineForm> {
  final formkey = GlobalKey<FormState>();
  Location location = Location();
  UserLocation phonelocation;
  String typebatiment;
  String typeecole;
  String typesante;
  String typereligieux;
  String typebatimentresult;

  String typelatrine;
  String typesuperstructure;
  String typedalle;

  bool robinetexist = false;
  bool robinetworks = false;

  LatrineData latrine = LatrineData();
  Setting setup = Setting();

  TextEditingController nompropriocontroller = TextEditingController();
  TextEditingController numpropriocontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  void getprefs() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
    typebatiment = "";
    typebatimentresult = "";
    //  typeecole="";
    //  typereligieux="";
    //  typesante="";
    typelatrine = "";
    typesuperstructure = "";
    typedalle = "";
    // position =
  }

  @override
  void dispose() {
    nompropriocontroller.dispose();
    numpropriocontroller.dispose();
    notecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _saveForm() {
    var form = formkey.currentState;
    if (form.validate()) {
      if (setup != null && setup.collectorId.isNotEmpty) {
        if (phonelocation != null) {
          print(
              "currentlocation is lat => ${phonelocation.latitude} long => ${phonelocation.longitude}");
          latrine.nomproprio = nompropriocontroller.text;
          latrine.numproprio = numpropriocontroller.text;
          latrine.note = notecontroller.text;
          latrine.partenaire = setup.partnerId; //"salut@salut.com";
          latrine.collecteur = setup.collectorId; //"dadja";
          latrine.typecollecte = TypeCollecte.collectelatrines;
          latrine.region = widget.village.region;
          latrine.departement = widget.village.departement;
          latrine.arrondissement = widget.village.arrondissement;
          latrine.commune = widget.village.commune;
          latrine.village = widget.village.nom;
          latrine.latitude = phonelocation.latitude.toString();
          latrine.longitude = phonelocation.longitude.toString();
          latrine.pays = "Senegal";
          print("latrine ${latrine.toJson().toString()}");

          DataBaseService.addLatrine(latrine);
          print("latrine ${latrine.toJson().toString()}");
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_collecte_done_content'),
              UIData.latrinecolordark,
              gotoListVillagepage);

          form.save();
        } else {
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_title'),
              AppLocalizations.of(context)
                  .translate('generic_dialog_gps_error_content'),
              UIData.latrinecolordark,
              null);
        }
      } else {
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_device_nosetup_content'),
            UIData.latrinecolordark,
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
        backgroundColor: UIData.latrinecolordark,
        title: Text(
            AppLocalizations.of(context).translate('latrine_form_appbartitle')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => latrine,
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
                      onSaved: (term) {
                        latrine.nomproprio = term;
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('latrine_form_nomproprio_label'),
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
                      //textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (term) {
                        latrine.numproprio = term;
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('latrine_form_numproprio_label'),
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
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context).translate(
                          'latrine_form_dropdown_typelatrines_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: typelatrine,
                      // onSaved: (value) {
                      //   setState(() {
                      //     typelatrine = value;
                      //   });
                      // },
                      onChanged: (value) {
                        setState(() {
                          typelatrine = value;
                          latrine.typelatrine = value;
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataLatrines.typeslatrines
                              : DataLatrines.typeslatrines_en,
                      textField: 'display',
                      valueField: 'display',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context).translate(
                          'latrine_form_dropdown_typesuperstruct_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: typesuperstructure,
                      onChanged: (value) {
                        setState(() {
                          typesuperstructure = value;
                          latrine.superstructure = value;
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataLatrines.superstructure
                              : DataLatrines.superstructure_en,
                      textField: 'display',
                      valueField: 'display',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context)
                          .translate('latrine_form_dropdown_typesdalle_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: typedalle,
                      onChanged: (value) {
                        setState(() {
                          typedalle = value;
                          latrine.dalle = value;
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataLatrines.dalles
                              : DataLatrines.dalles_en,
                      textField: 'display',
                      valueField: 'display',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text("Options"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_bonetatgeneral')),
                      value: latrine.bonetatgeneral,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.bonetatgeneral = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_doublefosse')),
                      value: latrine.doublefosse,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.doublefosse = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_siege')),
                      value: latrine.siege,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.siege = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_ventilation')),
                      value: latrine.ventilation,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.ventilation = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_porte')),
                      value: latrine.porte,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.porte = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_fermeture')),
                      value: latrine.fermeture,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.fermeture = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_toit')),
                      value: latrine.toit,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.toit = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_couvercle_defecation')),
                      value: latrine.couvercledefecation,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.couvercledefecation = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_propre')),
                      value: latrine.propre,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.propre = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_odeur')),
                      value: latrine.odeur,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.odeur = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('latrine_form_slms')),
                      value: latrine.slms,
                      activeColor: UIData.latrinecolordark,
                      onChanged: (val) {
                        setState(() => latrine.slms = val);
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
                      onSaved: (term) {
                        // l.note = term;
                        latrine.note = term;
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
                      color: UIData.latrinecolordark,
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

  Widget droptypelatrine(BuildContext context, String val) {
    return Container(
      padding: EdgeInsets.all(16),
      child: DropDownFormField(
        titleText: AppLocalizations.of(context)
            .translate('latrine_form_dropdown_typelatrines_title'),
        hintText: AppLocalizations.of(context)
            .translate('generic_dropdown_subtitle_msg'),
        value: val,
        onSaved: (value) {
          setState(() {
            val = value;
          });
        },
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        dataSource: DataLatrines.typeslatrines,
        textField: 'display',
        valueField: 'display',
      ),
    );
  }

  Widget droptypesuperstrucutre(BuildContext context, String val) {
    return Container(
      padding: EdgeInsets.all(16),
      child: DropDownFormField(
        titleText: AppLocalizations.of(context)
            .translate('latrine_form_dropdown_typesuperstruct_title'),
        hintText: AppLocalizations.of(context)
            .translate('generic_dropdown_subtitle_msg'),
        value: val,
        onSaved: (value) {
          setState(() {
            val = value;
          });
        },
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        dataSource: DataLatrines.superstructure,
        textField: 'display',
        valueField: 'display',
      ),
    );
  }

  Widget droptypedalle(BuildContext context, String val, LatrineData latri) {
    return Container(
      padding: EdgeInsets.all(16),
      child: DropDownFormField(
        titleText: AppLocalizations.of(context)
            .translate('latrine_form_dropdown_typesdalle_title'),
        hintText: AppLocalizations.of(context)
            .translate('generic_dropdown_subtitle_msg'),
        value: val,
        onChanged: (value) {
          setState(() {
            val = value;
            latri.dalle = value;
          });
        },
        dataSource: DataLatrines.dalles,
        textField: 'display',
        valueField: 'display',
      ),
    );
  }
}
