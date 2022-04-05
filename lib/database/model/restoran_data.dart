class RestoranData {
  RestoranData({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant_Data> restaurants;

  factory RestoranData.fromJson(Map<String, dynamic> json) => RestoranData(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant_Data>.from(
            json["restaurants"].map((x) => Restaurant_Data.fromJson(x))),
      );
}

class Restaurant_Data {
  Restaurant_Data({
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

  factory Restaurant_Data.fromJson(Map<String, dynamic> json) =>
      Restaurant_Data(
        id: json["id"],
        namaTempat: json["name"],
        description: json["description"],
        picId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
