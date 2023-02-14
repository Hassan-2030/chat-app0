class Massege {
  static String COLLECTION_NAME = "massege";

  String id;
  String content;
  int dataTime;
  String roomId;
  String senderId;
  String senderName;

  Massege(
      {this.id = "",
      required this.content,
      required this.dataTime,
      required this.roomId,
      required this.senderId,
      required this.senderName});

  Massege.fromJosn(Map<String, dynamic> json)
      : this(
          id: json["id"],
          content: json["content"],
          dataTime: json["dataTime"],
          roomId: json["roomId"],
          senderId: json["senderId"],
          senderName: json["senderName"],
        );

  Map<String, dynamic> toJon() {
    return {
      "id": id,
      "content": content,
      "dataTime": dataTime,
      "roomId": roomId,
      "senderId": senderId,
      "senderName": senderName,
    };
  }
}
