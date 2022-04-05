import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/model/restoran_search.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/ui/search_box.dart';

import '../package/const.dart';
import 'detail_resto_page.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 64),
          _buildSearch(),
          Expanded(
            child: Consumer<RestoProviderSearch>(
              builder: (context, prov, widget) {
                if (prov.state == ResultState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (prov.state == ResultState.HasData) {
                  var snapshot = prov.restoranData;
                  return GridView.builder(
                    padding: EdgeInsets.all(0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 6 / 8),
                    itemCount: snapshot.restaurants.length,
                    itemBuilder: (context, index) {
                      return _buildSearchitem(
                          context, snapshot.restaurants[index]);
                    },
                  );
                } else if (prov.state == ResultState.NoData) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        prov.msg,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        size: 64,
                        color: Colors.grey,
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
                  return Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchitem(context, Restaurant_Search restoran) {
    return Material(
      child: Padding(
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
          child: _restoranInkwell(context, restoran),
        ),
      ),
    );
  }

  Widget _restoranInkwell(context, Restaurant_Search restoran) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailRestoPage.routeName,
            arguments: restoran.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: const BoxDecoration(
            color: warnaSecondary,
          ),
          child: Column(
            children: [
              _bannerGambarResto(restoran),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    _namaResto(restoran, context),
                    const SizedBox(height: 8),
                    _lokasi(restoran, context),
                    const SizedBox(height: 8),
                    _rating(restoran, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _rating(restoran, context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          restoran.rating.toString(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  Row _lokasi(restoran, context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          restoran.city,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  Text _namaResto(restoran, context) {
    return Text(
      restoran.namaTempat,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  ClipRRect _bannerGambarResto(restoran) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        "https://restaurant-api.dicoding.dev/images/medium/${restoran.picId}",
        height: 100,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildSearch() => SearchBox(
        hintText: 'Search',
      );
}
