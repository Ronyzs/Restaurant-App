import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/model/restoran_detail.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/ui/sliver_app_bar.dart';

import '../package/const.dart';

class DetailResto extends StatefulWidget {
  final RestoranDetail restoDetail;

  var restoId;

  DetailResto({required this.restoDetail, required this.restoId});

  @override
  State<DetailResto> createState() => _DetailRestoState();
}

class _DetailRestoState extends State<DetailResto> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          DetailAppBar(context, isScrolled, widget.restoDetail.restaurant,
              widget.restoId),
        ];
      },
      body: Container(
        decoration: const BoxDecoration(color: warnaPrimary),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _namaRestoran(widget.restoDetail.restaurant, context),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _lokasiRestoran(widget.restoDetail.restaurant, context),
                    SizedBox(height: 4),
                    _ratingRestoran(widget.restoDetail.restaurant, context),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deskripsi",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CircleAvatar(
                      foregroundColor: warnaAksen,
                      backgroundColor: warnaAksen2,
                      radius: 18,
                      child: _FavoriteBtn(widget.restoDetail),
                    )
                  ],
                ),
                SizedBox(height: 8),
                _deskripsi(widget.restoDetail.restaurant, context),
                SizedBox(height: 8),
                Text(
                  "Makanan",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _foodList(widget.restoDetail.restaurant),
                SizedBox(height: 8),
                Text(
                  "Minuman",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _drinkList(widget.restoDetail.restaurant),
                _pesanBtn(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _FavoriteBtn(RestoranDetail resto) {
    return Consumer(
      builder: (context, FavoriteProvider prov, widget) {
        return FutureBuilder<bool>(
          future: prov.isFav(resto.restaurant),
          builder: (context, snapshot) {
            var isFav = snapshot.data ?? false;
            return isFav
                ? IconButton(
                    onPressed: () {
                      prov.removeFav(resto.restaurant);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mengapus Favorite!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite, size: 18),
                  )
                : IconButton(
                    onPressed: () {
                      prov.addFav(resto.restaurant);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Menambahkan Favorite!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_border, size: 18),
                  );
          },
        );
      },
    );
  }

  Row _ratingRestoran(Restaurant_Detail restoran, BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          restoran.rating.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Text _namaRestoran(Restaurant_Detail restoran, context) {
    return Text(
      restoran.namaTempat,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Text _deskripsi(Restaurant_Detail restoran, context) {
    return Text(
      restoran.description,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Row _lokasiRestoran(Restaurant_Detail restoran, context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          restoran.city,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _foodList(Restaurant_Detail restoran) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restoran.menus.foods.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Card(
                elevation: 3,
                color: warnaAksen2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(restoran.menus.foods[index].name),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _drinkList(Restaurant_Detail restoran) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restoran.menus.drinks.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Card(
                elevation: 3,
                color: warnaAksen2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(restoran.menus.drinks[index].name),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ElevatedButton _pesanBtn(context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Uh oh'),
              content: Text('Fitur ini masih dalam tahap pengembangan'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Kembali'))
              ],
            ),
          );
        },
        child: Text('Pesan Sesuatu!'));
  }
}
