import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/moudel/my_user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    myUser =
        await DatatBaseUtils.readUserFromFierstore(firebaseUser?.uid ?? "");
  }
}
