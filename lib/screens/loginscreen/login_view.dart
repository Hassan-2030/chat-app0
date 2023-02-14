import 'package:caht0/base.dart';
import 'package:caht0/moudel/my_user.dart';
import 'package:caht0/screens/create_account/create_account.dart';
import 'package:caht0/screens/loginscreen/login_navigator.dart';
import 'package:caht0/screens/loginscreen/login_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../provider/my_provider.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Image.asset(
          'assets/images/',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Create Account'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'pleae Enter Email';
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'your Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'pleae Enter YOur Password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Your password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'please Enter your email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'please enter valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'yourEmail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "please enter your password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      obscuringCharacter: 'x',
                      decoration: InputDecoration(
                          hintText: 'your Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ValidateForm();
                        },
                        child: Text('Login')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, CreateAccount.routName);
                        },
                        child: Text("Don't Have An Account?  "))
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  void ValidateForm() {
    viewModel.loginWithFierbaseAuth(
        emailController.text, passwordController.text);
  }

  @override
  LoginViewModel initviewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
