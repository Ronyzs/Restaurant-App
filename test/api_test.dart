import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/database/model/restoran_data.dart';

void main() {
  test(
    'List restaurant json should return a list of restorant as object',
    () {
      final resto = Restaurant_Data.fromJson({
        "id": "testId",
        "name": "testNamaTempat",
        "description": "testDesc",
        "pictureId": "testPicId",
        "city": "testCity",
        "rating": 4.7,
      });
      expect(resto.id, "testId");
      expect(resto.namaTempat, "testNamaTempat");
      expect(resto.description, "testDesc");
      expect(resto.picId, "testPicId");
      expect(resto.city, "testCity");
      expect(resto.rating, 4.7);
    },
  );
}
