import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lafyuu/routes/app_router.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Geolocator.isLocationServiceEnabled();
  var permisssion = await Geolocator.checkPermission();

  if (permisssion == LocationPermission.denied) {
    permisssion = await Geolocator.requestPermission();
    if (permisssion == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layfuu E-commerce',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash.path,
      onGenerateRoute: generateAppRoute,
    );
  }
}
