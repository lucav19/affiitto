import 'dart:convert';
import 'package:affiitto/back_end_utils/proprietaJson.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../back_end_class/annuncio.dart';
import '../back_end_class/sede.dart';
import 'immaginiJson.dart';


///La classe astratta LoadJson posside dei metodi statici che consentono
///il caricamento dei dati dal database simulate da dei file json
abstract class LoadJson {

  ///carica annunci dal json
  static Future<List<Annuncio>> loadAnnunci() async {

    String jsondata = await rootBundle.rootBundle
        .loadString('assets/listJsonAnnunci.json');
    final list = json.decode(jsondata) as List<dynamic>;
    List<Annuncio> l = [];
    for (var m in list) {
      l.add(Annuncio.fromJson(m));
    }
    return l;
  }

  ///carica sedi dal json
  static Future<List<Sede>> loadSedi() async {
    String jsondata =
        await rootBundle.rootBundle.loadString('assets/listJsonSedi.json');
    final list = json.decode(jsondata) as List<dynamic>;
    List<Sede> l = [];
    for (var m in list) {
      l.add(Sede.fromJson(m));
    }
    return l;
  }

  ///carica immagini dal json
  static Future<List<String>> loadImmagini(int id) async {
    String jsondata = await rootBundle.rootBundle
        .loadString('assets/listJsonImmagini.json');
    final list = json.decode(jsondata) as List<dynamic>;
    List<String> l = [];
    for (var im in list) {
      ImmaginiJson a = ImmaginiJson.fromJson(im);
      if (a.idAnnuncio == id) {
        l.add(a.idDrive);
      }
    }
    return l;
  }

  ///carica proprietà annuncio dal json
  static Future<Map<String,String>> loadProprieta(int id) async {
    String jsondata = await rootBundle.rootBundle
        .loadString('assets/listJsonProprietaAnnuncio.json');

    final list = json.decode(jsondata) as List<dynamic>;
    Map<String,String> m = {};
    for(var im in list){
      ProprietaJson p = ProprietaJson.fromJson(im);
      if(p.idAnnuncio == id){
        m[p.chiave] = p.valore;
      }
    }
    return m;
  }
}
