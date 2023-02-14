import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/base.dart';
import 'package:caht0/moudel/my_user.dart';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'create_account_navigator.dart';

import '../../shared/components/Firebase_error.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  String message = "";
  var auth = FirebaseAuth.instance;

  void CreatAccountWithFierbaseAuth(
      String email, String password, String firstname, String userNamae) async {
    try {
      navigator!.showLoading();

      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "Account Crated";
      // add Data to database
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: firstname,
          userNamae: userNamae,
          email: email);

      DatatBaseUtils.AddUserToFierstore(myUser).then((value) {
        // go to home
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FierbaseError.weakpassword) {
        message = "The password provided is too weak.";
      } else if (e.code == FierbaseError.emailuse) {
        message = "This account already exists for that email";
      }
    } catch (e) {
      message = "Something went wrong $e";
    }
    if (message != "") {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
