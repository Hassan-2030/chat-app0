class RoomCategory {
  static String sportId = "Sport";
  static String musicId = "Music";
  static String movesId = "Moves";

  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.FromId(this.id) {
    name = "music";
    image = "assets/images/$id.png";
  }

  static List<RoomCategory> getCategory() {
    return [
      RoomCategory.FromId(sportId),
      RoomCategory.FromId(musicId),
      RoomCategory.FromId(movesId)
    ];
  }
}
