import 'package:flutter/material.dart';
import 'package:restaurant_app/database/restoran.dart';
import 'package:restaurant_app/ui/menu_restoran.dart';
import 'package:restaurant_app/ui/sliver_app_bar.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'restoran_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListItem(),
    );
  }
}

class _buildListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/restoran.json'),
      builder: (context, snapshot) {
        final List restoran = parseJson(snapshot.data);
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                RestoranAppBar(context, isScrolled),
              ];
            },
            body: MenuResto(restoran: restoran),
          ),
        );
      },
    );
  }
}
