import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/sliver_app_bar.dart';

import '../database/restoran.dart';
import '../package/const.dart';

class DetailResto extends StatelessWidget {
  dataRestoran restoran;

  DetailResto({required this.restoran});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          DetailAppBar(context, isScrolled, restoran),
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
                _namaRestoran(restoran, context),
                SizedBox(height: 8),
                _lokasiRestoran(restoran, context),
                SizedBox(height: 8),
                Text(
                  "Deskripsi",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                _deskripsi(restoran, context),
                SizedBox(height: 8),
                Text(
                  "Makanan",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _foodList(restoran),
                SizedBox(height: 8),
                Text(
                  "Minuman",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _drinkList(restoran),
                _pesanBtn(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _namaRestoran(dataRestoran restoran, context) {
    return Text(
      restoran.namaTempat,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Text _deskripsi(dataRestoran restoran, context) {
    return Text(
      restoran.description,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Row _lokasiRestoran(dataRestoran restoran, context) {
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

  Widget _foodList(dataRestoran restoran) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restoran.foods.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Card(
                elevation: 3,
                color: warnaAksen2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(restoran.foods[index]['name']),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _drinkList(dataRestoran restoran) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restoran.foods.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Card(
                elevation: 3,
                color: warnaAksen2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(restoran.drinks[index]['name']),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
