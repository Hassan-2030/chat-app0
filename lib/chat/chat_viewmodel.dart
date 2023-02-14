import 'package:caht0/DatabaseUtils/database_utils.dart';
import 'package:caht0/base.dart';
import 'package:caht0/moudel/massge.dart';
import 'package:caht0/moudel/my_user.dart';
import 'package:caht0/moudel/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<CahtNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMassege(String content) {
    Massege massege = Massege(
        content: content,
        roomId: room.id,
        dataTime: DateTime.now().millisecondsSinceEpoch,
        senderId: myUser.id,
        senderName: myUser.userNamae);
    DatatBaseUtils.AddMassegeToFierstor(massege).then((value) {
      navigator!.uploadMassegeToFierstor();
    });
  }

  Stream<QuerySnapshot<Massege>> getMassege() {
    return DatatBaseUtils.reedMassegeFromFierstor(room.id);
  }
}

abstract class CahtNavigator extends BaseNavigator {
  void uploadMassegeToFierstor();
}
