class RestoranFavorit {
  RestoranFavorit({
    required this.id,
    required this.namaTempat,
    required this.picId,
    required this.city,
    required this.rating,
  });

  String id;
  String namaTempat;
  String picId;
  String city;
  String rating;

  factory RestoranFavorit.fromDb(Map<String, dynamic> json) => RestoranFavorit(
        id: json["id"],
        namaTempat: json["namaTempat"],
        picId: json["picId"],
        city: json["city"],
        rating: json["rating"],
      );
}
