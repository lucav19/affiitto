import 'package:flutter/widgets.dart';


///La classe MyFutterApp ci permette di ricavare l' icona per l' ordinamneto e l' icona della mano
class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  ///icona per l' ordinamento
  static const IconData sort_alt_up = IconData(0xf160, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  ///icona per la mano cui metteremo sopra il dollaro, utile per l' icona delle agevolazioni
  static const IconData hand_holding = IconData(0xf4bd, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
