import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';

import '../ui/detail_restoran.dart';

class DetailRestoPage extends StatelessWidget {
  static const routeName = 'detail_resto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestoProviderDetail>(
        builder: (context, prov, DetailRestoPage) {
          if (prov.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (prov.state == ResultState.HasData) {
            var snapshot = prov.restoranData;
            return DetailResto(restoDetail: snapshot, restoId: prov.restoId);
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
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
