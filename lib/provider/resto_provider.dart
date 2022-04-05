import 'package:flutter/foundation.dart';
import 'package:restaurant_app/database/api/api_service.dart';
import 'package:restaurant_app/database/favorite_database_helper.dart';
import 'package:restaurant_app/database/model/restoran_data.dart';
import 'package:restaurant_app/database/model/restoran_detail.dart';
import 'package:restaurant_app/database/model/restoran_favorit.dart';
import 'package:restaurant_app/database/model/restoran_search.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestoProviderList extends ChangeNotifier {
  final ApiService apiService;

  RestoProviderList({required this.apiService}) {
    _fetchAllRestoran();
  }

  late RestoranData _restoranData;
  late ResultState _state;
  String _msg = '';

  RestoranData get restoranData => _restoranData;

  ResultState get state => _state;

  String get msg => _msg;

  Future<dynamic> _fetchAllRestoran() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resto = await apiService.restoranList();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _msg = 'Data tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restoranData = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _msg = 'Tidak ada internet';
    }
  }
}

class RestoProviderDetail extends ChangeNotifier {
  final ApiService apiService;
  final restoId;

  RestoProviderDetail({required this.apiService, required this.restoId}) {
    _fetchAllRestoran(restoId);
  }

  late RestoranDetail _restoranData;
  late ResultState _state;
  String _msg = '';

  RestoranDetail get restoranData => _restoranData;

  ResultState get state => _state;

  String get msg => _msg;

  Future<dynamic> _fetchAllRestoran(String _restoId) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resto = await apiService.restoranDetail(_restoId);
      if (resto.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _msg = 'Restoran tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restoranData = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _msg = 'Tidak ada internet -> $e';
    }
  }
}

class RestoProviderSearch extends ChangeNotifier {
  final ApiService apiService;

  RestoProviderSearch({required this.apiService}) {
    _fetchAllRestoran();
  }

  late RestoranSearch _restoranData;
  late ResultState _state;
  String _msg = '';
  String query = ' ';

  RestoranSearch get restoranData => _restoranData;

  ResultState get state => _state;

  String get msg => _msg;

  Future<dynamic> _fetchAllRestoran() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final search = await apiService.restoranSearch(query);
      if (search.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _msg = 'Restoran tidak ada!';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restoranData = search;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _msg = 'Tidak ada internet!';
    }
  }

  void changeQuery(String query) {
    this.query = query;
    _fetchAllRestoran();
  }
}

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getFav();
  }

  late ResultState _state;
  String _msg = '';
  List<RestoranFavorit> _favorite = [];

  ResultState get state => _state;
  String get msg => _msg;
  List<RestoranFavorit> get favorite => _favorite;

  void _getFav() async {
    _favorite = await databaseHelper.getFav();
    if (_favorite.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _msg = 'Empty Data';
    }
    notifyListeners();
  }

  void addFav(Restaurant_Detail resto) async {
    try {
      await databaseHelper.insertFav(resto);
      _getFav();
    } catch (e) {
      _state = ResultState.Error;
      _msg = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFav(Restaurant_Detail resto) async {
    final markedFav = await databaseHelper.getFavById(resto.id);
    return markedFav.isNotEmpty;
  }

  void removeFav(Restaurant_Detail resto) async {
    try {
      await databaseHelper.removeFav(resto.id);
      _getFav();
    } catch (e) {
      _state = ResultState.Error;
      _msg = 'Error: $e';
      notifyListeners();
    }
  }
}
