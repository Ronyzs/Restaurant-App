class RestoranSearch {
  RestoranSearch({
    required this.error,
    required this.restaurants,
  });

  bool error;
  List<Restaurant_Search> restaurants;

  factory RestoranSearch.fromJson(Map<String, dynamic> json) => RestoranSearch(
        error: json["error"],
        restaurants: List<Restaurant_Search>.from(
            json["restaurants"].map((x) => Restaurant_Search.fromJson(x))),
      );
}

class Restaurant_Search {
  Restaurant_Search({
    required this.id,
    required this.namaTempat,
    required this.description,
    required this.picId,
    required this.city,
    required this.rating,
  });

  String id;
  String namaTempat;
  String description;
  String picId;
  String city;
  double rating;

  factory Restaurant_Search.fromJson(Map<String, dynamic> json) =>
      Restaurant_Search(
        id: json["id"],
        namaTempat: json["name"],
        description: json["description"],
        picId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
