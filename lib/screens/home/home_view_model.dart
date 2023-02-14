import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/base.dart';

import '../../moudel/room.dart';

class HomeViewModel extends BaseViewModel {
  List<Room> rooms = [];

  void readRooms() {
    DatatBaseUtils.readroomFromFierstore().then((value) {
      rooms = value;
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
