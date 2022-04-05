import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/api/api_service.dart';
import 'package:restaurant_app/package/const.dart';
import 'package:restaurant_app/pages/fav_page.dart';
import 'package:restaurant_app/pages/settings_page.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/ui/menu_restoran.dart';
import 'package:restaurant_app/ui/sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'restoran_list';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOption = <Widget>[
    FavPage(),
    _buildListItem(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestoProviderList>(
        create: (_) => RestoProviderList(apiService: ApiService()),
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }

  BottomNavigationBar _BottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_sharp), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      backgroundColor: warnaAksen2,
      selectedItemColor: warnaAksen,
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(fontSize: 14),
      selectedLabelStyle: TextStyle(fontSize: 16),
      selectedIconTheme: IconThemeData(size: 30),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

class _buildListItem extends StatefulWidget {
  @override
  State<_buildListItem> createState() => _buildListItemState();
}

class _buildListItemState extends State<_buildListItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestoProviderList>(
      builder: (context, prov, _) {
        if (prov.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (prov.state == ResultState.HasData) {
          var snapshot = prov.restoranData;
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  RestoranAppBar(context, isScrolled),
                ];
              },
              body: MenuResto(restoList: snapshot),
            ),
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
    );
  }
}
