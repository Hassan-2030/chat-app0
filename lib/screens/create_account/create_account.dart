import 'dart:typed_data';

import 'package:caht0/base.dart';
import 'package:caht0/moudel/my_user.dart';

import 'package:caht0/screens/create_account/create_account_navigator.dart';
import 'package:caht0/screens/home/home.dart';
import 'package:caht0/screens/loginscreen/login_view.dart';
import 'package:flutter/material.dart';

import '../../provider/my_provider.dart';
import 'create_account_viewmoudel.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  static const String routName = 'createaccoutn';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState
    extends BaseView<CreateAccount, CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var fNameController = TextEditingController();

  var userNameController = TextEditingController();

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
      child: Stack(
        children: [
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
                      controller: fNameController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'pleae Enter FirstNaeme';
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'yourFirstName',
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
                      controller: userNameController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return 'pleae Enter Your User Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'UserName',
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
                        child: Text('Create Account')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text("I Have An Account  "))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.CreatAccountWithFierbaseAuth(
          emailController.text,
          passwordController.text,
          fNameController.text,
          userNameController.text);
    }
  }

  @override
  CreateAccountViewModel initviewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
