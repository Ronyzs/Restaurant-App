import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/package/const.dart';
import 'package:restaurant_app/provider/resto_provider.dart';

import 'detail_resto_page.dart';

class FavPage extends StatelessWidget {
  static const routeName = 'fav_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16)),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: warnaAksen2,
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Favourite',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, prov, child) {
          return GridView.builder(
            padding: EdgeInsets.all(0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 6 / 8),
            itemCount: prov.favorite.length,
            itemBuilder: (context, index) {
              if (prov.state == ResultState.Loading) {
                return CircularProgressIndicator();
              } else if (prov.state == ResultState.HasData) {
                return _buildPaddingFavList(prov.favorite[index], context);
              } else if (prov.state == ResultState.NoData) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prov.msg,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.error,
                      size: 64,
                      color: Colors.red,
                    )
                  ],
                ));
              } else if (prov.state == ResultState.Error) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prov.msg,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.error,
                      size: 64,
                      color: Colors.red,
                    )
                  ],
                ));
              } else {
                return Text('');
              }
            },
          );
        },
      ),
    );
  }

  Padding _buildPaddingFavList(resto, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(0),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            style: BorderStyle.solid,
            color: warnaAksen2,
            width: 2,
          ),
        ),
        child: _favRestoranInkwell(resto, context),
      ),
    );
  }

  InkWell _favRestoranInkwell(resto, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailRestoPage.routeName,
          arguments: resto.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: const BoxDecoration(
            color: warnaSecondary,
          ),
          child: Column(
            children: [
              _bannerGambarResto(resto),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    _namaResto(resto, context),
                    const SizedBox(height: 8),
                    _lokasi(resto, context),
                    const SizedBox(height: 8),
                    _rating(resto, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _rating(resto, context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          resto.rating.toString(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  Row _lokasi(resto, context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          resto.city,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  Text _namaResto(resto, context) {
    return Text(
      resto.namaTempat,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  ClipRRect _bannerGambarResto(resto) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: resto.id,
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/${resto.picId}",
          height: 100,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
