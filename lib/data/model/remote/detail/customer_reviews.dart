class CustomerReviews {
  late String? id;
  late String? name;
  late String? review;
  late String? date;

  CustomerReviews({this.id, this.name, this.review, this.date});

  CustomerReviews.fromJson(dynamic json) {
    name = json["name"];
    review = json["review"];
    date = json["date"];
  }

  Map<String, dynamic> toJson(String id) {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["review"] = review;
    return map;
  }
}
