import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/restoran.dart';
import '../package/const.dart';

Widget RestoranAppBar(context, isScrolled) {
  return SliverAppBar(
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

Widget DetailAppBar(context, isScrolled, dataRestoran restoran) {
  return SliverAppBar(
    iconTheme: const IconThemeData(color: warnaAksen),
    elevation: 3,
    backgroundColor: warnaSecondary,
    expandedHeight: 250,
    flexibleSpace: FlexibleSpaceBar(
      background: Hero(
        tag: restoran.id,
        child: _gambarDetailRestoran(restoran),
      ),
      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
    ),
  );
}

Image _gambarDetailRestoran(dataRestoran restoran) {
  return Image.network(
    restoran.picId,
    fit: BoxFit.fill,
  );
}
