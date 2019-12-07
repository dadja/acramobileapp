import 'package:flutter/material.dart';
import 'package:acra/uidata.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/ui/setupscreen.dart';
import 'package:acra/app_localization.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // emailcontroller.text = "beta@partenaire.com";
    // passcontroller.text = "beta1234";
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate('login_appbar_title')),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: loginBody(context),
      ),
    );
  }

  loginBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            loginHeader(),
            (isLoading == false)
                ? loginFields(context)
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text("Loading..."),
                            CircularProgressIndicator()
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Image.asset("assets/monitoring.png"),
            height: 200,
            width: 200,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            AppLocalizations.of(context).translate('login_prime_msg'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            AppLocalizations.of(context).translate('login_std_msg'),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                controller: emailcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                      .translate('login_email_hint_text'),
                  labelText: AppLocalizations.of(context)
                      .translate('login_email_label_text'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                controller: passcontroller,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                      .translate('login_password_label_text'),
                  labelText: AppLocalizations.of(context)
                      .translate('login_password_label_text'),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('login_signin_message'),
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  DataBaseService.loginFuture(
                          emailcontroller.text, passcontroller.text)
                      .then((partner) {
                    setState(() {
                      isLoading = false;
                    });
                    if (partner != null) {
                      if (partner.data['actif'] == true) {
                        Route enrolroute = MaterialPageRoute(
                            builder: (context) => SetupScreen(
                                  partnerId: partner.documentID.toString(),
                                )); //Enrolme
                        Navigator.of(context).pushReplacement(enrolroute);
                      } else {
                        showDoneDialog(
                            context,
                            AppLocalizations.of(context)
                                .translate('dialog_login_incorrect_title'),
                            AppLocalizations.of(context)
                                .translate('dialog_login_disable_content'),
                            Theme.of(context).primaryColor,
                            null);
                      }
                    } else {
                      // showDialog(
                      //     child: AlertDialog(
                      //   title: Text("Login Incorrect"),
                      //   content: Text("Incorrect credentials"),
                      // ));

                      showDoneDialog(
                          context,
                          AppLocalizations.of(context)
                              .translate('dialog_login_incorrect_title'),
                          AppLocalizations.of(context)
                              .translate('dialog_login_incorrect_content'),
                          Theme.of(context).primaryColor,
                          null);
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            // Text(
            //   "SIGN UP FOR AN ACCOUNT",
            //   style: TextStyle(color: Colors.grey),
            // ),
          ],
        ),
      );
}
