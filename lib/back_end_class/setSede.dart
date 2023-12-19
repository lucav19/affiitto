

import 'package:affiitto/back_end_class/sede.dart';

import '../back_end_utils/loadJson.dart';

///La class SetSede raffigura la sede settata dall' utente
class SetSede {
  ///lista contenete tutte le sedi
  static List<Sede> _sedi = [];

  late Sede _sede;


  static final SetSede _setSede = SetSede._internal();

  ///La class SetSede raffigura la sede settata dall' utente, è un singleton
  factory SetSede() => _setSede;

  ///Istanzia un oggetto SetSede, è un singleton.
  SetSede._internal();

  ///metodo che setta una sede differente
  void setSede(Sede s) {
    _sede = s;
  }

  ///get sede settata
  Sede getSede() => _sede;

  ///Metodo che permette di caricare le sedi dal database
  Future<void> caricaSedi() async => _sedi = await LoadJson.loadSedi();

  ///Metodo che permette di visualizzare le sedi del database, il cui prefisso
  ///è la stringa passata in input, se vuota ritorna tutte le sedi
  List<Sede> visualizzaSedi(String s) {
    s = s.trim().toLowerCase();
    if (s == "") return _sedi;

    List<Sede> nome = [];

    for (Sede sede in _sedi) {
      if (sede.getNome().toLowerCase().startsWith(s)) {
        nome.add(sede);
      }
    }
    nome.sort((a, b) => a.getNome().compareTo(b.getNome()));
    return nome;
  }
}
