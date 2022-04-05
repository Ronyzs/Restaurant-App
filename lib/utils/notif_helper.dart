import 'package:flutter/material.dart';
import 'package:restaurant_app/database/api/api_service.dart';
import 'package:restaurant_app/database/model/restoran_data.dart';
import 'package:restaurant_app/pages/detail_resto_page.dart';
import 'package:timezone/timezone.dart' as timeZone;
import 'package:timezone/data/latest_all.dart' as timeZone;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class DailyNotification {
  static Future<timeZone.TZDateTime> setTime() async {
    timeZone.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    timeZone.setLocalLocation(timeZone.getLocation(timeZoneName!));

    final timeZone.TZDateTime now = timeZone.TZDateTime.now(timeZone.local);

    timeZone.TZDateTime timeSet =
        timeZone.TZDateTime(timeZone.local, now.year, now.month, now.day, 11);
    if (timeSet.isBefore(now)) {
      timeSet = timeSet.add(const Duration(days: 1));
    }

    return timeSet;
  }

  static Future<bool> switchNotification(
      BuildContext context, bool isEnabled) async {
    if (isEnabled) {
      final RestoranData resto = await ApiService().restoranList();
      resto.restaurants.shuffle();
      final Restaurant_Data randomResto = resto.restaurants[0];

      NotificationHelper.initialize(
          context: context,
          restoId: randomResto.id,
          namaTempat: randomResto.namaTempat,
          picId: randomResto.picId);

      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Check this restaurant!',
          randomResto.namaTempat,
          await setTime(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                '1', 'daily_restaurant_reminder_1',
                channelDescription:
                    'Memberikan informasi restoran setiap hari'),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);

      return Future.value(true);
    } else {
      flutterLocalNotificationsPlugin.cancelAll();
      return Future.value(false);
    }
  }
}

class NotificationHelper {
  static void initialize({
    required BuildContext context,
    required String restoId,
    required String namaTempat,
    required String picId,
  }) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        Navigator.pushNamed(context, DetailRestoPage.routeName,
            arguments: restoId);
      },
    );
  }
}
