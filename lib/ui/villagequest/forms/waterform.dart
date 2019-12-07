import 'package:acra/resources/db.dart';
import 'package:acra/ui/uitest/multiselectchip.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:acra/uidata.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/models/user_location.dart';
import 'package:acra/app_localization.dart';

class WaterForm extends StatefulWidget {
  final Village village;
  WaterForm({this.village});
  @override
  _WaterFormState createState() => _WaterFormState();
}

class _WaterFormState extends State<WaterForm> {
  final formkey = GlobalKey<FormState>();
  WaterData water;
  Setting setup = Setting();
  bool datavaluetest = false;
  Location location = Location();
  UserLocation phonelocation;
  List<String> selectedForageUsageList = List();
  List<String> selectedPuitUsageList = List();

  TextEditingController nompointeaucontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  TextEditingController puitdebithorairepompecontroller =
      TextEditingController();
  TextEditingController puitdureejournalierepompagecontroller =
      TextEditingController();
  TextEditingController puitvolumemensuelpreferecontroller =
      TextEditingController();
  TextEditingController puitnbrjourpompagecontroller = TextEditingController();
  TextEditingController puitniveaustatiquecontroller = TextEditingController();
  TextEditingController puitpotentielhydrauliquecontroller =
      TextEditingController();
  TextEditingController puitconductivitelectriquecontroller =
      TextEditingController();
  TextEditingController puittemperaturecontroller = TextEditingController();

  TextEditingController foragedebithorairepompecontroller =
      TextEditingController();
  TextEditingController foragedureejournalierepompagecontroller =
      TextEditingController();
  TextEditingController foragevolumemensuelpreferecontroller =
      TextEditingController();
  TextEditingController foragenbrjourpompagecontroller =
      TextEditingController();
  TextEditingController forageniveaustatiquecontroller =
      TextEditingController();
  TextEditingController foragepotentielhydrauliquecontroller =
      TextEditingController();
  TextEditingController forageconductivitelectriquecontroller =
      TextEditingController();
  TextEditingController foragetemperaturecontroller = TextEditingController();

  TextEditingController sourcenotecontroller = TextEditingController();
  TextEditingController autretypepointeaucontroller = TextEditingController();

  _nompointeaulistener() {
    setState(() {
      water.nompointeau = nompointeaucontroller.text;
    });
  }

  _notelistener() {
    setState(() {
      water.note = notecontroller.text;
    });
  }

  _sourcenotelistener() {
    setState(() {
      water.sourcenote = sourcenotecontroller.text;
    });
  }

  _autretypepointeaulistener() {
    setState(() {
      water.autretypepointeau = autretypepointeaucontroller.text;
    });
  }

  _puitdebithorairepompagelistener() {
    setState(() {
      water.puitdebithorairepompe = puitdebithorairepompecontroller.text;
    });
  }

  _puitdureejournalierepompagelistener() {
    setState(() {
      water.puitdureejournalierepompage =
          puitdureejournalierepompagecontroller.text;
    });
  }

  _puitvolumemensuelpreferelistener() {
    setState(() {
      water.puitvolumemensuelpreleve = puitvolumemensuelpreferecontroller.text;
    });
  }

  _puitnbrjourpompagelistener() {
    setState(() {
      water.puitnombrejourpompage = puitnbrjourpompagecontroller.text;
    });
  }

  _puitniveaustatiquelistener() {
    setState(() {
      water.puitniveaustatiquepuit = puitniveaustatiquecontroller.text;
    });
  }

  _puitpotentielhydrauliquelistener() {
    setState(() {
      water.puitpotentielhydraulique = puitpotentielhydrauliquecontroller.text;
    });
  }

  _puittemperaturelistener() {
    setState(() {
      water.puittemperature = puittemperaturecontroller.text;
    });
  }

  _puitconductiviteelectriquelistener() {
    setState(() {
      water.puitconductiviteelectrique =
          puitconductivitelectriquecontroller.text;
    });
  }

  _foragedebithorairepompagelistener() {
    setState(() {
      water.foragedebithorairepompe = foragedebithorairepompecontroller.text;
    });
  }

  _foragedureejournalierepompagelistener() {
    setState(() {
      water.foragedureejournalierepompage =
          foragedureejournalierepompagecontroller.text;
    });
  }

  _foragevolumemensuelprelevelistener() {
    setState(() {
      water.foragevolumemensuelpreleve =
          foragevolumemensuelpreferecontroller.text;
    });
  }

  _foragenombrejourpompagelistener() {
    setState(() {
      water.foragenombrejourpompage = foragenbrjourpompagecontroller.text;
    });
  }

  _forageniveaustatiquelistener() {
    setState(() {
      water.forageniveaustatiqueforage = forageniveaustatiquecontroller.text;
    });
  }

  _foragepotentielhydrauliquelistener() {
    setState(() {
      water.foragepotentielhydraulique =
          foragepotentielhydrauliquecontroller.text;
    });
  }

  _forageconductiviteelectriquelistener() {
    setState(() {
      water.forageconductiviteelectrique =
          forageconductivitelectriquecontroller.text;
    });
  }

  _foragetemperaturelistener() {
    setState(() {
      water.foragetemperature = foragetemperaturecontroller.text;
    });
  }

  void getprefs() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
  }

  @override
  void dispose() {
    nompointeaucontroller.dispose();
    notecontroller.dispose();

    puitdebithorairepompecontroller.dispose();
    puitdureejournalierepompagecontroller.dispose();
    puitvolumemensuelpreferecontroller.dispose();
    puitnbrjourpompagecontroller.dispose();
    puitniveaustatiquecontroller.dispose();
    puitpotentielhydrauliquecontroller.dispose();
    puitconductivitelectriquecontroller.dispose();
    puittemperaturecontroller.dispose();

    foragedebithorairepompecontroller.dispose();
    foragedureejournalierepompagecontroller.dispose();
    foragevolumemensuelpreferecontroller.dispose();
    foragenbrjourpompagecontroller.dispose();
    forageniveaustatiquecontroller.dispose();
    foragepotentielhydrauliquecontroller.dispose();
    forageconductivitelectriquecontroller.dispose();
    foragetemperaturecontroller.dispose();

    sourcenotecontroller.dispose();
    autretypepointeaucontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getprefs();
    water = WaterData();
    water.bonetatgeneral = false;
    water.cloture = false;
    water.couverclepuit = false;
    water.drainage = false;
    water.foragecloture = false;
    water.forageteteprotege = false;
    water.amenage = false;

    nompointeaucontroller.addListener(_nompointeaulistener);
    notecontroller.addListener(_notelistener);

    puitdebithorairepompecontroller
        .addListener(_puitdebithorairepompagelistener);
    puitdureejournalierepompagecontroller
        .addListener(_puitdebithorairepompagelistener);
    puitvolumemensuelpreferecontroller
        .addListener(_puitvolumemensuelpreferelistener);
    puitnbrjourpompagecontroller.addListener(_puitnbrjourpompagelistener);
    puitniveaustatiquecontroller.addListener(_puitniveaustatiquelistener);
    puitpotentielhydrauliquecontroller
        .addListener(_puitpotentielhydrauliquelistener);
    puitconductivitelectriquecontroller
        .addListener(_puitconductiviteelectriquelistener);
    puittemperaturecontroller.addListener(_puittemperaturelistener);

    foragedebithorairepompecontroller
        .addListener(_foragedebithorairepompagelistener);
    foragedureejournalierepompagecontroller
        .addListener(_foragedureejournalierepompagelistener);
    foragevolumemensuelpreferecontroller
        .addListener(_foragevolumemensuelprelevelistener);
    foragenbrjourpompagecontroller
        .addListener(_foragenombrejourpompagelistener);
    forageniveaustatiquecontroller.addListener(_forageniveaustatiquelistener);
    foragepotentielhydrauliquecontroller
        .addListener(_foragepotentielhydrauliquelistener);
    forageconductivitelectriquecontroller
        .addListener(_forageconductiviteelectriquelistener);
    foragetemperaturecontroller.addListener(_foragetemperaturelistener);

    sourcenotecontroller.addListener(_sourcenotelistener);
    autretypepointeaucontroller.addListener(_autretypepointeaulistener);
  }

  _saveForm() {
    var form = formkey.currentState;
    if (form.validate()) {
      form.save();

      switch (water.typepointeau.toLowerCase()) {
        case "puit":
          {
            if (selectedPuitUsageList.length != 0) {
              //conve4ted selected to string ...
              selectedPuitUsageList.forEach((item) {
                if (water.puitusage.isEmpty)
                  water.puitusage += item;
                else
                  water.puitusage += "/" + item;
              });
              //the save it all and send it ....
              gosave();
            } else {
              showDoneDialog(
                  context,
                  AppLocalizations.of(context)
                      .translate('water_form_dialog_puit_error_title'),
                  AppLocalizations.of(context)
                      .translate('water_form_dialog_puit_error_content'),
                  UIData.watercolordark,
                  null);
            }
          }
          break;
        case "forage":
          {
            if (selectedForageUsageList.length != 0) {
              //conve4ted selected to string ...
              selectedForageUsageList.forEach((item) {
                if (water.forageusage.isEmpty)
                  water.forageusage += item;
                else
                  water.forageusage += "/" + item;
              });
              //then save it and send it all...
              gosave();
            } else {
              showDoneDialog(
                  context,
                  AppLocalizations.of(context)
                      .translate('water_form_dialog_forage_error_title'),
                  AppLocalizations.of(context)
                      .translate('water_form_dialog_forage_error_content'),
                  UIData.watercolordark,
                  null);
            }
          }
          break;
        default:
          {
            gosave();
          }
          break;
      }
      // if (water.typepointeau.toLowerCase() == "Puit".toLowerCase()) {
      //   //reset forage seleection to none
      //   selectedForageUsageList.clear();
      //   selectedForageUsageList = List();

      //   if (selectedPuitUsageList.length != 0) {
      //     gosave();
      //   } else {
      //     showDoneDialog(
      //         context,
      //         "Usage Eau Puit",
      //         "vous devez absolument choisir au moins un usage de l'eau !",
      //         UIData.watercolordark,
      //         null);
      //   }
      // }

      // if (water.typepointeau.toLowerCase() == "Forage".toLowerCase()) {
      //   //reset puit seleection to none
      //   selectedPuitUsageList.clear();
      //   selectedPuitUsageList = List();

      //   if (selectedPuitUsageList.length != 0) {
      //     gosave();
      //   } else {
      //     showDoneDialog(
      //         context,
      //         "Usage Eau Forage",
      //         "vous devez absolument choisir au moins un usage de l'eau !",
      //         UIData.watercolordark,
      //         null);
      //   }
      // }
    }
  }

  void gosave() {
    if (setup != null && setup.collectorId.isNotEmpty) {
      if (phonelocation != null) {
        print(
            "currentlocation is lat => ${phonelocation.latitude} long => ${phonelocation.longitude}");
        water.partenaire = setup.partnerId; //"salut@salut.com";
        water.collecteur = setup.collectorId; //"dadja";
        water.typecollecte = TypeCollecte.collectepointeau;
        water.region = widget.village.region;
        water.departement = widget.village.departement;
        water.arrondissement = widget.village.arrondissement;
        water.commune = widget.village.commune;
        water.village = widget.village.nom;
        water.latitude = phonelocation.latitude.toString();
        water.longitude = phonelocation.longitude.toString();
        water.pays = "Senegal";
        DataBaseService.addPointeau(water);

        print("water ${water.toJson().toString()}");
        print(
            "water note => ${water.note} usage details forageusage => ${water.forageusage.toString()} puitusage=> ${water.puitusage.toString()}");
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_collecte_done_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_collecte_done_content'),
            UIData.watercolordark,
            gotoListVillagepage);
      } else {
        showDoneDialog(
            context,
            AppLocalizations.of(context)
                .translate('generic_dialog_gps_error_title'),
            AppLocalizations.of(context)
                .translate('generic_dialog_gps_error_content'),
            UIData.watercolordark,
            null);
      }
    } else {
      showDoneDialog(
          context,
          AppLocalizations.of(context)
              .translate('generic_dialog_device_nosetup_title'),
          AppLocalizations.of(context)
              .translate('generic_dialog_device_nosetup_content'),
          UIData.watercolordark,
          gotoListVillagepage);
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
        backgroundColor: UIData.watercolordark,
        title: Text(AppLocalizations.of(context)
            .translate('water_form_screen_appbartitle')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => water,
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
                      controller: nompointeaucontroller,
                      onSaved: (term) {
                        water.nompointeau = term;
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('water_form_nompointeau_label'),
                        hintText:
                            AppLocalizations.of(context).translate('hint'),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('generic_form_nom_error');
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
                      titleText: AppLocalizations.of(context)
                          .translate('water_form_typeeau_dropdown_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: water.typepointeau,
                      onSaved: (value) {
                        setState(() {
                          water.typepointeau = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          water.typepointeau = value;
                        });
                      },
                      dataSource:
                          (AppLocalizations.of(context).translate('lang') ==
                                  Lang.fr)
                              ? DataPointEau.typespointeau
                              : DataPointEau.typespointeau_en,
                      textField: 'display',
                      valueField: 'display',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('water_form_bonetatgeneral')),
                      value: water.bonetatgeneral,
                      activeColor: UIData.watercolordark,
                      onChanged: (val) {
                        setState(() => water.bonetatgeneral = val);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(context)
                          .translate('water_form_cloture')),
                      value: water.cloture,
                      activeColor: UIData.watercolordark,
                      onChanged: (val) {
                        setState(() => water.cloture = val);
                      }),
                  rightWidget(water.typepointeau),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      maxLines: 4,
                      //textInputAction: TextInputAction.next,
                      controller: notecontroller,
                      onSaved: (term) {
                        water.note = term;
                      },
                      decoration: new InputDecoration(
                        labelText: "Note",
                        hintText: "Entrer une note",
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
                      color: UIData.watercolordark,
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

  Widget detailpompemanuelle() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(AppLocalizations.of(context)
            .translate('water_form_info_pompemanuelle')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: DropDownFormField(
            titleText: AppLocalizations.of(context)
                .translate('water_form_typepompemanuelle_dropdown_title'),
            hintText: AppLocalizations.of(context)
                .translate('generic_dropdown_subtitle_msg'),
            value: water.modelepompe,
            onSaved: (value) {
              setState(() {
                water.modelepompe = value;
              });
            },
            onChanged: (value) {
              setState(() {
                water.modelepompe = value;
              });
            },
            dataSource:
                (AppLocalizations.of(context).translate('lang') == Lang.fr)
                    ? DataPointEau.marquepompes
                    : DataPointEau.marquepompes_en,
            textField: 'display',
            valueField: 'display',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        CheckboxListTile(
            title: Text(
                AppLocalizations.of(context).translate('water_form_drainage')),
            value: water.drainage,
            activeColor: UIData.watercolordark,
            onChanged: (val) {
              setState(() => water.drainage = val);
            }),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget detailpuit() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(AppLocalizations.of(context).translate('water_form_info_puit')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: DropDownFormField(
            titleText: AppLocalizations.of(context)
                .translate('water_form_typepuit_dropdown_title'),
            hintText: AppLocalizations.of(context)
                .translate('generic_dropdown_subtitle_msg'),
            value: water.typepuit,
            onSaved: (value) {
              setState(() {
                water.typepuit = value;
              });
            },
            onChanged: (value) {
              setState(() {
                water.typepuit = value;
              });
            },
            dataSource:
                (AppLocalizations.of(context).translate('lang') == Lang.fr)
                    ? DataPointEau.typepuit
                    : DataPointEau.typepuit_en,
            textField: 'display',
            valueField: 'display',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        // this.puitusage,//Multi select widget from typeusage
        MultiSelectChip(
          (AppLocalizations.of(context).translate('lang') == Lang.fr)
              ? DataPointEau.typeusageeaustring
              : DataPointEau.typeusageeaustring_en,
          UIData.watercolordark,
          UIData.watercolorlight,
          onSelectionChanged: (selectedList) {
            selectedPuitUsageList = selectedList;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        CheckboxListTile(
            title: Text(
                AppLocalizations.of(context).translate('water_form_couvercle')),
            value: water.couverclepuit,
            activeColor: UIData.watercolordark,
            onChanged: (val) {
              setState(() => water.couverclepuit = val);
            }),
        SizedBox(
          height: 10.0,
        ),
        // this.puitdateexploitation, DatePicker
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            onSaved: (term) {},
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitdateexploitation_label'),
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
        // this.puitdebithorairepompe,//TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            controller: puitdebithorairepompecontroller,
            keyboardType: TextInputType.number,
            onSaved: (term) {
              water.puitdebithorairepompe = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitdebithorairepompe_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puitdureejournalierepompage,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitdureejournalierepompagecontroller,
            onSaved: (term) {
              water.puitdureejournalierepompage = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitdureejournaliere_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puitvolumemensuelpreleve,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitvolumemensuelpreferecontroller,
            onSaved: (term) {
              water.puitvolumemensuelpreleve = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitvolumemensuelprel_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puitnombrejourpompage,TextField
        Container(
          padding: EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitnbrjourpompagecontroller,
            onSaved: (term) {
              water.puitnombrejourpompage = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitnbrjourpompage_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puitniveaustatiquepuit,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitniveaustatiquecontroller,
            onSaved: (term) {
              water.puitniveaustatiquepuit = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitniveaustat_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puitpotentielhydraulique,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitpotentielhydrauliquecontroller,
            onSaved: (term) {
              water.puitpotentielhydraulique = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitpotentielhydrau_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.puittemperature,TextField
        Container(
          padding: EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: puitconductivitelectriquecontroller,
            onSaved: (term) {
              water.puitconductiviteelectrique = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitconductelec_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
          padding: EdgeInsets.all(16.0),
          child: TextFormField(
            controller: puittemperaturecontroller,
            keyboardType: TextInputType.number,
            onSaved: (term) {
              water.puittemperature = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_puitemp_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget detailforage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(AppLocalizations.of(context).translate('water_form_info_forage')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: DropDownFormField(
            titleText: AppLocalizations.of(context)
                .translate('water_form_sourcealimforage_dropdown_title'),
            hintText: AppLocalizations.of(context)
                .translate('generic_dropdown_subtitle_msg'),
            value: water.foragesourcealimentation,
            onSaved: (value) {
              setState(() {
                water.foragesourcealimentation = value;
              });
            },
            onChanged: (value) {
              setState(() {
                water.foragesourcealimentation = value;
              });
            },
            dataSource:
                (AppLocalizations.of(context).translate('lang') == Lang.fr)
                    ? DataPointEau.sourcealimentation
                    : DataPointEau.sourcealimentation_en,
            textField: 'display',
            valueField: 'display',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        MultiSelectChip(
          (AppLocalizations.of(context).translate('lang') == Lang.fr)
              ? DataPointEau.typeusageeaustring
              : DataPointEau.typeusageeaustring_en,
          UIData.watercolordark,
          UIData.watercolorlight,
          onSelectionChanged: (selectedList) {
            selectedForageUsageList = selectedList;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        CheckboxListTile(
            title: Text(AppLocalizations.of(context)
                .translate('water_form_teteforageprotege')),
            value: water.forageteteprotege,
            activeColor: UIData.watercolordark,
            onChanged: (val) {
              setState(() => water.forageteteprotege = val);
            }),
        SizedBox(
          height: 10.0,
        ),
        // this.foragedateexploitation,DatePicker
        SizedBox(
          height: 10.0,
        ),
        // this.forageusage,Multi select from type usage
        SizedBox(
          height: 10.0,
        ),
        // this.foragedebithorairepompe, TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: foragedebithorairepompecontroller,
            onSaved: (term) {
              water.foragedebithorairepompe = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragedebithorairepompe_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.foragedureejournalierepompage,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: foragedureejournalierepompagecontroller,
            onSaved: (term) {
              water.foragedureejournalierepompage = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragedureejournaliere_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.foragevolumemensuelpreleve,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: foragevolumemensuelpreferecontroller,
            onSaved: (term) {
              water.foragevolumemensuelpreleve = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragecvolumemensuelprel_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.foragenombrejourpompage, TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: foragenbrjourpompagecontroller,
            onSaved: (term) {
              water.foragenombrejourpompage = term;
            },
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragenbrjourpompage_label'),
              hintText: AppLocalizations.of(context)
                  .translate('generic_textfield_enter_number_label'),
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
        // this.forageniveaustatiqueforage,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            onSaved: (term) {
              water.forageniveaustatiqueforage = term;
            },
            controller: forageniveaustatiquecontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_forageniveaustat_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.foragepotentielhydraulique,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            onSaved: (term) {
              water.foragepotentielhydraulique = term;
            },
            controller: foragepotentielhydrauliquecontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragepotentielhydrau_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
        // this.foragetemperature,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (term) {
              water.foragetemperature = term;
            },
            controller: foragetemperaturecontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_foragetemp_label'),
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
        // this.forageconductiviteelectrique,TextField
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (term) {
              water.forageconductiviteelectrique = term;
            },
            controller: forageconductivitelectriquecontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_forageconductelec_label'),
              // hintText: "Decrivez nous le  point d'eau",
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
      ],
    );
  }

  Widget detailAutreTypePointEau() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(AppLocalizations.of(context)
            .translate('water_form_info_autretype')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            //textInputAction: TextInputAction.next,
            onSaved: (term) {
              water.autretypepointeau = term;
            },
            controller: autretypepointeaucontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_autretypepointeau_label'),
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
      ],
    );
  }

  Widget detailsource() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(AppLocalizations.of(context).translate('water_form_info_source')),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            // textInputAction: TextInputAction.next,
            maxLines: 6,
            onSaved: (term) {
              water.sourcenote = term;
            },
            controller: sourcenotecontroller,
            decoration: new InputDecoration(
              labelText: AppLocalizations.of(context)
                  .translate('water_form_notesource_label'),
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
        CheckboxListTile(
            title: Text(
                AppLocalizations.of(context).translate('water_form_amenage')),
            value: water.amenage,
            activeColor: UIData.watercolordark,
            onChanged: (val) {
              setState(() => water.amenage = val);
            }),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  void resetPuitControllers() {
    puitdebithorairepompecontroller.text = "";
    puitdureejournalierepompagecontroller.text = "";
    puitvolumemensuelpreferecontroller.text = "";
    puitnbrjourpompagecontroller.text = "";
    puitniveaustatiquecontroller.text = "";
    puitpotentielhydrauliquecontroller.text = "";
    puitconductivitelectriquecontroller.text = "";
    puittemperaturecontroller.text = "";
  }

  void resetForageControllers() {
    foragedebithorairepompecontroller.text = "";
    foragedureejournalierepompagecontroller.text = "";
    foragevolumemensuelpreferecontroller.text = "";
    foragenbrjourpompagecontroller.text = "";
    forageniveaustatiquecontroller.text = "";
    foragepotentielhydrauliquecontroller.text = "";
    forageconductivitelectriquecontroller.text = "";
    foragetemperaturecontroller.text = "";
  }

  void resetAutreSourceControllers() {
    sourcenotecontroller.text = "";
  }

  void resetAutreTypePointEauControllers() {
    autretypepointeaucontroller.text = "";
  }

  Widget rightWidget(String element) {
    switch (element) {
      case "Pompe manuelle":
        resetAutreSourceControllers();
        resetAutreTypePointEauControllers();
        water.resetautrepointeaudata();
        water.resetforagedata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailpompemanuelle();

      case "Manual pump":
        resetAutreSourceControllers();
        resetAutreTypePointEauControllers();
        water.resetautrepointeaudata();
        water.resetforagedata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailpompemanuelle();

      case "Puit":
        //reset controllers too
        resetForageControllers();
        resetAutreSourceControllers();
        resetAutreTypePointEauControllers();
        //reset forage seleection to none
        selectedForageUsageList.clear();
        selectedForageUsageList = List();
        water.resetautrepointeaudata();
        water.resetforagedata();
        water.resetpompemanuelledata();
        water.resetsourcedata();
        return detailpuit();

      case "Well":
        //reset controllers too
        resetForageControllers();
        resetAutreSourceControllers();
        resetAutreTypePointEauControllers();
        //reset forage seleection to none
        selectedForageUsageList.clear();
        selectedForageUsageList = List();
        water.resetautrepointeaudata();
        water.resetforagedata();
        water.resetpompemanuelledata();
        water.resetsourcedata();
        return detailpuit();

      case "Forage":
        //reset forage seleection to none
        resetPuitControllers();
        resetAutreTypePointEauControllers();
        resetAutreSourceControllers();
        selectedPuitUsageList.clear();
        selectedPuitUsageList = List();
        water.resetautrepointeaudata();
        water.resetpompemanuelledata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailforage();

      case "Borehole":
        //reset forage seleection to none
        resetPuitControllers();
        resetAutreTypePointEauControllers();
        resetAutreSourceControllers();
        selectedPuitUsageList.clear();
        selectedPuitUsageList = List();
        water.resetautrepointeaudata();
        water.resetpompemanuelledata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailforage();

      case "Source":
        resetAutreTypePointEauControllers();
        water.resetautrepointeaudata();
        water.resetforagedata();
        water.resetpuitdata();
        water.resetpompemanuelledata();
        return detailsource();

      case "Autre type de point d'eau":
        resetAutreSourceControllers();
        water.resetpompemanuelledata();
        water.resetforagedata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailAutreTypePointEau();

      case "Other type of water point":
        resetAutreSourceControllers();
        water.resetpompemanuelledata();
        water.resetforagedata();
        water.resetpuitdata();
        water.resetsourcedata();
        return detailAutreTypePointEau();

      default:
        return Container();
    }
  }
}
