import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/database/model/restoran_data.dart';
import 'package:restaurant_app/database/model/restoran_detail.dart';

import '../model/restoran_search.dart';

class ApiService {
  Future<RestoranData> restoranList() async {
    final response =
        await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
    if (response.statusCode == 200) {
      return RestoranData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant');
    }
  }

  Future<RestoranDetail> restoranDetail(var restoId) async {
    final response = await http
        .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$restoId"));
    if (response.statusCode == 200) {
      return RestoranDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<RestoranSearch> restoranSearch(String query) async {
    final response = await http
        .get(Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query"));
    if (response.statusCode == 200) {
      return RestoranSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
