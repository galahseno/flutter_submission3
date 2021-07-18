import 'restaurants.dart';

class RestaurantResponse {
  late List<Restaurants> restaurants;

  RestaurantResponse({required this.restaurants});

  RestaurantResponse.fromJson(Map<String, dynamic> json) {
    restaurants = [];
    if (json["restaurants"] != null) {
      json["restaurants"].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }
}
