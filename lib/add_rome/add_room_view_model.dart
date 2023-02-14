import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/add_rome/add_room_navigator.dart';
import 'package:caht0/base.dart';
import 'package:caht0/moudel/room.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void AddRoomToDB(String tittle, String desc, String catId) {
    Room room = Room(tittle: tittle, desc: desc, catId: catId);
    DatatBaseUtils.AddRoomToFierStore(room).then((value) {}).catchError(() {
      navigator!.roomCreated();
    });
  }
}
