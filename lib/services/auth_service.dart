import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseUser _user;

  //continuously listen to userconnected
  // StreamController<FirebaseUser> _userController =
  //     StreamController<FirebaseUser>.broadcast();

  AuthService() {
    signInWithEmailAndPassword();
  }

  // Stream<FirebaseUser> get userStream => _userController.stream;

  getUser() async {
    //Future<FirebaseUser>
    try {
      _user = await getCurrentUser();

      return _user;
      // _userController.sink.add(_user);
    } catch (e) {
      print("Could not get the location error is $e");
    }
    // return null;
  }

  signInWithEmailAndPassword() async {
    const String _email = "youremailhere";
    const String _password = "yourpasswordhere";

    return (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    ))
        .user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  checkUserstate(Function myfunction) async {
    FirebaseUser user = await getCurrentUser();

    if (user != null) {
      return myfunction;
    } else {
      await signInWithEmailAndPassword();
      return myfunction;
    }
  }
}

class FireBaseService {
  // Example code of how to sign in with email and password.

}
