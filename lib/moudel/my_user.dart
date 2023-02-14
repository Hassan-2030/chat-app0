class MyUser {
  static const String CALLECTION_NAME = "myUser";

  String id;
  String fName;
  String userNamae;
  String email;

  MyUser(
      {required this.id,
      required this.fName,
      required this.userNamae,
      required this.email});

  MyUser.fromjson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            fName: json["fName"],
            userNamae: json["userName"],
            email: json["emil"]);

  Map<String, dynamic> toJson() {
    return {"id": id, "fName": fName, "userName": userNamae, "email": email};
  }
}
