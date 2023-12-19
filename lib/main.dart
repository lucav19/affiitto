import 'package:flutter/cupertino.dart';
import 'back_end_class/setSede.dart';
import 'front_end_class/myApp.dart';
/*
da terminale: flutter clean
elimina pubspec.lock
da  terminale: flutte pub get
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SetSede s = SetSede();
  await s.caricaSedi();
  runApp(const MyApp());
}
