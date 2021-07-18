import 'restaurant.dart';

class DetailResponse {
  late Restaurant restaurant;

  DetailResponse({required this.restaurant});

  DetailResponse.fromJson(dynamic json) {
    restaurant = json["restaurant"] = Restaurant.fromJson(json["restaurant"]);
  }
}
