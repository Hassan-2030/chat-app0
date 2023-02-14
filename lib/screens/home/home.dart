import 'dart:async';

import 'package:caht0/base.dart';
import 'package:caht0/screens/home/home_navigator.dart';
import 'package:caht0/screens/home/home_view_model.dart';
import 'package:caht0/screens/home/room_widdget.dart';
import 'package:caht0/screens/loginscreen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../add_rome/add_room_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.readRooms();
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
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoomScreen.routName);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text("CahtApp"),
                actions: [
                  IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              body: Consumer<HomeViewModel>(
                builder: (_, homeViewModel, c) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return RoomWidget(homeViewModel.rooms[index]);
                    },
                    itemCount: homeViewModel.rooms.length,
                  );
                },
              )),
        ],
      ),
    );
  }

  @override
  HomeViewModel initviewModel() {
    return HomeViewModel();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation); //
}
