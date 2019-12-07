import 'package:acra/resources/db.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/ui/villagescreen.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:acra/uidata.dart';
import 'package:acra/app_localization.dart';

class SetupScreen extends StatefulWidget {
  final String partnerId;
  SetupScreen({this.partnerId});
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static final formkey = GlobalKey<FormState>();
  Setting setting = Setting();
  TextEditingController collecteurcontroller = TextEditingController();
  TextEditingController partnercontroller = TextEditingController();
  TextEditingController imeicontroller = TextEditingController();

  void getprefs() async {
    setting = await SharePrefsData.readDeviceSetupFromPrefs();

    if (setting != null && setting.collectorId.isNotEmpty) {
      print("setup not null");
      collecteurcontroller.text = setting.collectorId;
      partnercontroller.text = setting.partnerId;
      imeicontroller.text = setting.deviceId;
    }
    if (setting == null || setting.partnerId.isEmpty) {
      print("setup null partner ${widget.partnerId}");
      partnercontroller.text = widget.partnerId;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    collecteurcontroller.dispose();
    partnercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate('setup_screen_appbar_title')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 13.0,
              ),
              Container(
                width: 100,
                height: 100,
                child: Image.asset("assets/monitoring.png"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                // child: Text("ID DEVICE => $_platformImei"),
                child: TextFormField(
                  // enabled: false,
                  onSaved: (data) {
                    setState(() {
                      imeicontroller.text = data;
                      setting.deviceId = data;
                    });
                  },
                  controller: imeicontroller,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('setup_screen_deviceid_label'),
                      hintText: AppLocalizations.of(context)
                          .translate('setup_screen_deviceid_hint')),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('setup_screen_deviceid_error');
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
                  controller: partnercontroller,
                  onSaved: (data) {
                    setState(() {
                      partnercontroller.text = data;
                      setting.partnerId = data;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('setup_screen_partnerid_label'),
                      hintText: AppLocalizations.of(context)
                          .translate('setup_screen_partnerid_hint')),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('setup_screen_partnerid_error');
                    }
                    // return "";
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('setup_screen_collectorid_label'),
                      hintText: AppLocalizations.of(context)
                          .translate('setup_screen_collectorid_hint')),
                  controller: collecteurcontroller,
                  onSaved: (data) {
                    setState(() {
                      collecteurcontroller.text = data;
                      setting.collectorId = data;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('setup_screen_collectorid_error');
                    }
                    // return "";
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('setup_screen_setup'),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _setupDevice,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setupDevice() {
    //TODO here we do what is required to setup the device
    var form = formkey.currentState;
    if (form.validate()) {
      setting = Setting(
          deviceId: imeicontroller.text,
          partnerId: partnercontroller.text,
          collectorId: collecteurcontroller.text);

      DataBaseService.getCollecteur(setting).then((data) {
        if (data != null) {
          print("configsaved ${setting.toJson().toString()}");

          SharePrefsData.saveDeviceSetupToPrefs(setting);
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('setup_dialog_config_saved_title'),
              AppLocalizations.of(context)
                  .translate('setup_dialog_config_saved_content'),
              UIData.dangercolordark,
              gotoListVillagepage);
        } else {
          showDoneDialog(
              context,
              AppLocalizations.of(context)
                  .translate('setup_dialog_config_not_saved_title'),
              AppLocalizations.of(context)
                  .translate('setup_dialog_config_not_saved_content'),
              UIData.dangercolordark,
              gotoListVillagepage);
        }
      });

      form.save();
    } else {}
  }

  void gotoListVillagepage() {
    Route gotoaction = MaterialPageRoute(builder: (context) => VillageScreen());
    Navigator.of(context).push(gotoaction);
  }
}
