import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/data/model/Remote/restaurant_response.dart';
import 'package:submission_1/data/model/remote/detail/customer_reviews.dart';
import 'package:submission_1/data/model/remote/detail/detail_restaurant_response.dart';

class RemoteDataProvider {
  final _apiService = ApiService();

  Future<RestaurantResponse> getRestaurants() async {
    return _apiService.getRestaurants();
  }

  Future<RestaurantResponse> searchRestaurants(String query) async {
    return _apiService.searchRestaurants(query);
  }

  Future<DetailResponse> getDetailRestaurant(String id) async {
    return _apiService.getDetailRestaurant(id);
  }

  Future postReview(CustomerReviews review, String id) async {
    return _apiService.postReview(review, id);
  }
}
