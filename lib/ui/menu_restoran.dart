import 'package:flutter/material.dart';
import 'package:restaurant_app/database/restoran.dart';
import 'package:restaurant_app/pages/detail_resto.dart';
import 'package:restaurant_app/ui/search_box.dart';
import '../package/const.dart';

class MenuResto extends StatefulWidget {
  List restoran;

  MenuResto({required this.restoran});

  @override
  State<MenuResto> createState() => _MenuRestoState();
}

class _MenuRestoState extends State<MenuResto> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4 / 5),
            itemCount: widget.restoran.length,
            itemBuilder: (context, index) {
              return _buildDetailItem(context, widget.restoran[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(context, dataRestoran restoran) {
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

  Widget _restoranInkwell(context, dataRestoran restoran) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetailRestoPage.routeName,
          arguments: restoran),
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

  Row _rating(dataRestoran restoran, context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          restoran.rating,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  Row _lokasi(dataRestoran restoran, context) {
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

  Text _namaResto(dataRestoran restoran, context) {
    return Text(
      restoran.namaTempat,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  ClipRRect _bannerGambarResto(dataRestoran restoran) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: restoran.id,
        child: Image.network(
          restoran.picId,
          height: 100,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildSearch() => SearchBox(
        hintText: 'Search',
      );
}
