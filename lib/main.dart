import 'package:caht0/firebase_options.dart';
import 'package:caht0/provider/my_provider.dart';
import 'package:caht0/screens/create_account/create_account.dart';
import 'package:caht0/screens/home/home.dart';
import 'package:caht0/screens/loginscreen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'add_rome/add_room_screen.dart';
import 'chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      routes: {
        CreateAccount.routName: (context) => CreateAccount(),
        LoginScreen.routeName: (e) => LoginScreen(),
        HomeScreen.routeName: (e) => HomeScreen(),
        CahtScreen.routName: (e) => CahtScreen(),
        AddRoomScreen.routName: (e) => AddRoomScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
