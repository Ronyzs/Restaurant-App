import 'dart:convert';

class dataRestoran {
  late String id;
  late String namaTempat;
  late String description;
  late String picId;
  late String city;
  late String rating;
  late List foods;
  late List drinks;

  dataRestoran({
    required this.id,
    required this.namaTempat,
    required this.description,
    required this.picId,
    required this.city,
    required this.rating,
  });

  //inisialisasi object json ke variable
  dataRestoran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaTempat = json['name'];
    description = json['description'];
    picId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toString();
    foods = json['menus']['foods'];
    drinks = json['menus']['drinks'];
  }
}

// parsing json ke object
List<dataRestoran> parseJson(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsedMap = jsonDecode(json);
  final List parsed = parsedMap['restaurants'];
  return parsed.map((json) => dataRestoran.fromJson(json)).toList();
}
