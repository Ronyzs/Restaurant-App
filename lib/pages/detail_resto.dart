import 'package:flutter/material.dart';
import 'package:restaurant_app/database/restoran.dart';

import '../ui/detail_restoran.dart';

class DetailRestoPage extends StatelessWidget {
  static const routeName = 'detail_resto';

  final dataRestoran restoran;
  DetailRestoPage({required this.restoran});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailResto(
        restoran: restoran,
      ),
    );
  }
}
