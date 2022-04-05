import 'package:flutter/material.dart';
import 'package:restaurant_app/database/model/restoran_data.dart';
import 'package:restaurant_app/pages/detail_resto_page.dart';
import '../package/const.dart';

class MenuResto extends StatefulWidget {
  final RestoranData restoList;

  MenuResto({required this.restoList});

  @override
  State<MenuResto> createState() => _MenuRestoState();
}

class _MenuRestoState extends State<MenuResto> {
  late List resto;

  String query = '';

  @override
  void initState() {
    super.initState();
    resto = widget.restoList.restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 6 / 8),
            itemCount: resto.length,
            itemBuilder: (context, index) {
              return _buildDetailItem(context, resto[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(context, Restaurant_Data restoran) {
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

  Widget _restoranInkwell(context, Restaurant_Data restoran) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailRestoPage.routeName,
          arguments: restoran.id,
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

  Row _rating(Restaurant_Data restoran, context) {
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

  Row _lokasi(Restaurant_Data restoran, context) {
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

  Text _namaResto(Restaurant_Data restoran, context) {
    return Text(
      restoran.namaTempat,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  ClipRRect _bannerGambarResto(Restaurant_Data restoran) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: restoran.id,
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/${restoran.picId}",
          height: 100,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
