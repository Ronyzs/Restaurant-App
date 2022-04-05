import 'package:flutter/material.dart';
import 'package:restaurant_app/database/model/restoran_detail.dart';
import 'package:restaurant_app/pages/fav_page.dart';
import 'package:restaurant_app/pages/search_page.dart';

import '../package/const.dart';

Widget RestoranAppBar(context, isScrolled) {
  return SliverAppBar(
    actions: isScrolled
        ? [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SearchPage.routeName),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ]
        : [],
    elevation: 3,
    backgroundColor: warnaAksen2,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
    expandedHeight: 200,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: _gambarMenuRestoran(),
      title: isScrolled
          ? const Text(
              'Restaurant App',
              style: TextStyle(color: Colors.black),
            )
          : const Text(
              'Recommendation Restaurant for you!',
              style: TextStyle(color: Colors.black),
            ),
      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
    ),
  );
}

Image _gambarMenuRestoran() {
  return Image.asset(
    'assets/images/street_food.png',
    fit: BoxFit.fill,
  );
}

Widget DetailAppBar(context, isScrolled, Restaurant_Detail restoran, restoId) {
  return SliverAppBar(
    iconTheme: const IconThemeData(color: warnaAksen),
    elevation: 3,
    backgroundColor: warnaSecondary,
    expandedHeight: 250,
    flexibleSpace: FlexibleSpaceBar(
      background: Hero(
        tag: restoId,
        child: _gambarDetailRestoran(restoran),
      ),
      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
    ),
  );
}

Image _gambarDetailRestoran(Restaurant_Detail restoran) {
  return Image.network(
    "https://restaurant-api.dicoding.dev/images/large/${restoran.picId}",
    fit: BoxFit.fill,
  );
}
