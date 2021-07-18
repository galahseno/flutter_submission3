class Categories {
  late String name;

  Categories({required this.name});

  Categories.fromJson(dynamic json) {
    name = json["name"];
  }
}
