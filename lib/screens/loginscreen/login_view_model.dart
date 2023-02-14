import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/base.dart';
import 'package:caht0/moudel/my_user.dart';
import 'package:caht0/screens/loginscreen/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/components/Firebase_error.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  String message = "";

  void loginWithFierbaseAuth(String emial, String password) async {
    try {
      navigator!.showLoading();

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emial,
        password: password,
      );
      message = "SuccessFully Logged";
      //read user from database
      MyUser? myUser = await DatatBaseUtils.readUserFromFierstore(
          credential.user?.uid ?? "");
      if (myUser != null) {
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      message = "Wrong your password or Email";
    } catch (e) {
      message = "Somthing  went wrong $e";
    }
    if (message != "") {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
