import 'package:flutter/material.dart';
import 'package:restaurant_app/database/restoran.dart';
import 'package:restaurant_app/pages/detail_resto.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/package/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        DetailRestoPage.routeName: (context) => DetailRestoPage(
              restoran:
                  ModalRoute.of(context)?.settings.arguments as dataRestoran,
            )
      },
    );
  }
}
