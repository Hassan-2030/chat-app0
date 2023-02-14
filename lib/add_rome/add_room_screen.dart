import 'package:caht0/add_rome/add_room_navigator.dart';
import 'package:caht0/add_rome/add_room_view_model.dart';
import 'package:caht0/base.dart';
import 'package:caht0/moudel/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routName = "addroomscreen";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var tittleControuler = TextEditingController();
  var descriptionControuler = TextEditingController();
  var castegories = RoomCategory.getCategory();
  late RoomCategory selctedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selctedCategory = castegories[0];
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
              title: Text('Add room'),
            ),
            body: SingleChildScrollView(
              child: Card(
                elevation: 22,
                margin: EdgeInsets.all(30),
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 18.0),
                    child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Creat New Room",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Image.asset("assets/images/preview.png"),
                              TextFormField(
                                controller: tittleControuler,
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return 'please Enter roomn tittle';
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: 'your tittle',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DropdownButton<RoomCategory>(
                                  value: selctedCategory,
                                  items: castegories
                                      .map((cat) =>
                                          DropdownMenuItem<RoomCategory>(
                                              value: cat,
                                              child: Row(
                                                children: [
                                                  Image.asset(cat.image),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(cat.name)
                                                ],
                                              )))
                                      .toList(),
                                  onChanged: (category) {
                                    if (category == null) {
                                      return;
                                    } else {
                                      selctedCategory = category;
                                    }
                                    setState(() {});
                                  }),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: descriptionControuler,
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return 'pleae Enter YOur description';
                                  } else {
                                    return null;
                                  }
                                },
                                // obscureText: true,..
                                decoration: InputDecoration(
                                    hintText: 'Your  descrption',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: tittleControuler,
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
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: descriptionControuler,
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
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    ValidateForm();
                                  },
                                  child: Text('Create room'))
                            ]))),
              ),
            ),
          ),
        ]));
  }

  void ValidateForm() {
    if (formKey.currentState!.validate()) {
      // creat room
      viewModel.AddRoomToDB(tittleControuler.text, descriptionControuler.text,
          selctedCategory.id);
    }
  }

  @override
  void roomCreated() {
    Navigator.pop(context);
  }

  @override
  AddRoomViewModel initviewModel() {
    return AddRoomViewModel();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
