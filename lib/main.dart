import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/favorite_database_helper.dart';
import 'package:restaurant_app/pages/detail_resto_page.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/package/const.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/resto_provider.dart';

import 'database/api/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          textTheme: textTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: warnaAksen,
            ),
          ),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          SearchPage.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestoProviderSearch(apiService: ApiService()),
              child: SearchPage()),
          DetailRestoPage.routeName: (context) => ChangeNotifierProvider(
                create: (_) => RestoProviderDetail(
                    apiService: ApiService(),
                    restoId: ModalRoute.of(context)?.settings.arguments),
                child: DetailRestoPage(),
              ),
        },
      ),
    );
  }
}
