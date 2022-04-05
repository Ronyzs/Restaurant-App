import 'package:flutter/material.dart';
import 'package:restaurant_app/package/const.dart';
import 'package:restaurant_app/utils/notif_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  static const routeName = 'setting_page';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static const String notifSwitch = 'switchIsOn';

  bool _notifValue = false;

  void saveSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(notifSwitch, _notifValue);
  }

  void onChanged(bool setNotif) async {
    setState(() {
      _notifValue = setNotif;
      saveSwitch();
    });
  }

  void loadValueOfSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifValue = prefs.getBool(notifSwitch) ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadValueOfSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: warnaAksen2,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Notification',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              activeColor: warnaAksen,
              activeTrackColor: warnaAksen2,
              value: _notifValue,
              onChanged: (bool a) {
                setState(() {
                  onChanged(a);
                  DailyNotification.switchNotification(context, _notifValue);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
