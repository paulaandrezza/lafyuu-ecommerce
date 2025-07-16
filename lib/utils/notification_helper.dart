import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showOrderNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'order_channel',
    'Order Updates',
    channelDescription: 'This channel shows order status updates.',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    ticker: 'ticker',
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Your order was placed successfully!',
    'Thanks for shopping with Lafyuu. Your order is being processed.',
    platformDetails,
  );
}
