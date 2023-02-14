import 'package:cloud_firestore/cloud_firestore.dart';

import '../moudel/massge.dart';
import '../moudel/my_user.dart';
import '../moudel/room.dart';

class DatatBaseUtils {
  static CollectionReference<MyUser> getUserCallection() {
    return FirebaseFirestore.instance
        .collection(MyUser.CALLECTION_NAME)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromjson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Room> getRoomsCallection() {
    return FirebaseFirestore.instance
        .collection(Room.CALLECTION_NAME)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromjson(snapshot.data()!),
          toFirestore: (room, options) => room.toJson(),
        );
  }

  static CollectionReference<Massege> getMessageCallection(String roomId) {
    return getRoomsCallection()
        .doc(roomId)
        .collection(Massege.COLLECTION_NAME)
        .withConverter<Massege>(
          fromFirestore: (snapshot, options) =>
              Massege.fromJosn(snapshot.data()!),
          toFirestore: (value, options) => value.toJon(),
        );
  }

  static Future<void> AddMassegeToFierstor(Massege massege) {
    var docRef = getMessageCallection(massege.roomId).doc();
    massege.roomId = docRef.id;
    return docRef.set(massege);
  }

  static Stream<QuerySnapshot<Massege>> reedMassegeFromFierstor(String roomId) {
    return getMessageCallection(roomId).orderBy("DataTime").snapshots();
  }

  static Future<void> AddRoomToFierStore(Room room) {
    var callection = getRoomsCallection();
    var docRef = callection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> readroomFromFierstore() async {
    QuerySnapshot<Room> snapRoom = await getRoomsCallection().get();
    return snapRoom.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> AddUserToFierstore(MyUser myUser) {
    return getUserCallection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFierstore(String id) async {
    DocumentSnapshot<MyUser> user = await getUserCallection().doc(id).get();

    var myUser = user.data();
    return myUser;
  }
}
