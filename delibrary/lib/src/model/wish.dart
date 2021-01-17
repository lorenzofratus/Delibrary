class Wish {
  final int id;
  final String ownerUsername;
  final String bookId;

  Wish({this.id, this.ownerUsername, this.bookId});

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(
        id: json["id"], ownerUsername: json["owner"], bookId: json["bookId"]);
  }
}
