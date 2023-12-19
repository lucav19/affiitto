import 'dart:convert';
import 'package:http/http.dart' as http;

import '../back_end_class/sede.dart';
import '../back_end_class/setSede.dart';


///La classe per funzioni di supporto e costanti per la parte relativa al back-end e parte del front-end
abstract class Utils {
  ///api_key per inviare le richieste a google maps
  static const String _mapsApiKey = 'AIzaSyCJASvlUkCXL9Lz-V0Ia9b2fHqjR8pXY9c';

  ///prefisso della query da inviare a google maps
  static const String _prefixMapsQuery =
      "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=";

  ///presiffo cartella dove sono contenute le immagini e i json
  static const assetPath = "assets/";

  ///funzione che restituisce il prefisso della query a google drive dove bisognerà concatenare il codice dell' immagine
  static String getDirmage() => assetPath;

  ///Questa funzione grazie a una query google maps calcola e restituisce le distanze, tempo di percorrenza
  ///con i mezzi o con l' auto e il tempo a piedi, tra la sede e gli indirizzi degli annunci, in base
  ///il giorno di domani alle 9
  static Future<List<String>> getDistances(List<String> origins) async {
    http.Client client = http.Client();
    DateTime d = DateTime.now();
    DateTime t = DateTime(d.year, d.month, d.day + 1, 9);

    String departure =
        '&departure_time=${(t.millisecondsSinceEpoch / 1000).toInt()}';

    Sede s = SetSede().getSede();
    String destination = s.getIndirizzo() + ' ' + s.getCitta();
    String km = '';
    String walk = '';
    String transit = '';
    List<String> ris = [];
    List<Future<dynamic>> request = [];
    for (String origin in origins) {
      String query =
          '${_prefixMapsQuery}${destination.replaceAll(' ', '%20')}&mode=transit'
          '$departure&origins=${origin.replaceAll(' ', '%20')}&key=${_mapsApiKey}';
      request.add(client.get(Uri.parse(query)));

      query = '$_prefixMapsQuery${destination.replaceAll(' ', '%20')}$departure'
          '&origins=${origin.replaceAll(' ', '%20')}&key=$_mapsApiKey';
      request.add(client.get(Uri.parse(query)));

      query =
          '${_prefixMapsQuery}${destination.replaceAll(' ', '%20')}&mode=walking'
          '&origins=${origin.replaceAll(' ', '%20')}&key=${_mapsApiKey}';
      request.add(client.get(Uri.parse(query)));
    }
    var j;

    try {
      var resp = await Future.wait(request);

      for (int i = 0; i < resp.length; i++) {
        if (resp[i].statusCode == 200) {
          try {
            j = json.decode(resp[i].body)['rows'][0]['elements'][0];

            km = j['distance']['text'].toString();
            transit = j['duration']['text'];
          } catch (e) {
            j = json.decode(resp[i + 1].body)['rows'][0]['elements'][0];
            km = j['distance']['text'].toString();
            transit = j['duration']['text'];
          }

          j = json.decode(resp[i + 2].body)['rows'][0]['elements'][0];
          walk = j['duration']['text'];

          ris.addAll([km.split(' ')[0], _change(transit), _change(walk)]);
          i += 2;
        } else
          print("resp diverso da 200");
      }
    } catch (e) {}
    client.close();
    return ris;
  }

  ///metodo per convertire stringhe il tempo da inglese a italiano
  static String _change(String time) {
    if(time.split(' ').length > 2) {
      time = time.replaceAll(' 0 mins', '');
    }
    return time
        .replaceAll('hours', 'ore')
        .replaceAll('hour', 'ora')
        .replaceAll('mins', 'min');
  }

  ///funzione che compara due stringhe indipendentemente se minuscole o maiuscole
  static bool compareString(String s1, String s2) =>
      s1.toUpperCase() == s2.toUpperCase();

  ///funzione che converte la stringa con la stessa stringa ma la prima lettera maiuscola
  static String firstUpperCase(String s) {
    List<String> s1 = s.split('');
    String ris = '';
    for (int i = 0; i < s1.length; i++) {
      if (i == 0)
        ris += s1[i].toUpperCase();
      else
        ris += s1[i];
    }
    return ris;
  }

  /// Metodo che converte booleano in binario
  static bool stringToBool(String i) {
    if (i.trim() == '0')
      return false;
    else
      return true;
  }

  ///  Metodo che converte binario in booleano
  static String boolToString(bool b) {
    if (b) return '1';
    return '0';
  }
}
