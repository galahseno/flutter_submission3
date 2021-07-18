class FavoriteRestaurants {
  late String id;
  late String name;
  late String pictureId;
  late String city;
  late String rating;

  FavoriteRestaurants(
      {required this.id,
      required this.name,
      required this.pictureId,
      required this.city,
      required this.rating});

  FavoriteRestaurants.fromMap(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    pictureId = json['pictureId'] as String;
    city = json['city'] as String;
    rating = json['rating'] as String;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }
}
