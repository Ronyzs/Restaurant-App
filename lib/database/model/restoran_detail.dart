class RestoranDetail {
  RestoranDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant_Detail restaurant;

  factory RestoranDetail.fromJson(Map<String, dynamic> json) => RestoranDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant_Detail.fromJson(json["restaurant"]),
      );
}

class Restaurant_Detail {
  Restaurant_Detail({
    required this.id,
    required this.namaTempat,
    required this.description,
    required this.city,
    required this.address,
    required this.picId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  String id;
  String namaTempat;
  String description;
  String city;
  String address;
  String picId;
  double rating;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  factory Restaurant_Detail.fromJson(Map<String, dynamic> json) =>
      Restaurant_Detail(
        id: json["id"],
        namaTempat: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        picId: json["pictureId"],
        rating: json["rating"].toDouble(),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );
}
