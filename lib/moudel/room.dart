class Room {
  static const String CALLECTION_NAME = "myUser";

  String id;
  String tittle;
  String desc;
  String catId;

  Room(
      {this.id = "",
      required this.tittle,
      required this.desc,
      required this.catId});

  Room.fromjson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            tittle: json["tittle"],
            desc: json["desc"],
            catId: json["catId"]);

  Map<String, dynamic> toJson() {
    return {"id": id, "tittle": tittle, "desc": desc, "catId": catId};
  }
}
