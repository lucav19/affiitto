


import 'package:affiitto/back_end_class/sede.dart';
import 'package:affiitto/back_end_class/setSede.dart';

import '../back_end_utils/loadJson.dart';
import '../back_end_utils/utils.dart';
import 'annuncio.dart';

///Laclasse che visualizzerà gli annunci in base ai filtri.è un singleton, essa contiene la sede, il vettore degli annunci da visualizzare e i filtri
///   per la visualizzazione e ordinamento. La classe usa il pattern builder per la visualizzazione
class VettoreAnnunci {

  SetSede _setSede = SetSede();

  bool _appartamento = false;

  bool _singola = false;
  bool _doppia = false;

  bool _orderByPrezzo = false;
  bool _orderByDistanza = false;

  bool _filtroPrezzo = false;
  List<double> _filtroPrezzoMinMax = [-1, -1];

  bool _filtroDistanza = false;
  List<double> _filtroDistanzaMinMax = [-1, -1];

  bool _maschio = false;
  bool _femmina = false;
  bool _misto = false;

  bool _noFumatori = false;
  bool _noAnimali = false;
  bool _noProprietario = false;

  static int _numFiltri = 0;

  static late List<Annuncio> _annunci;

  static bool _inizio = true;

  double _minPrice = -1;
  double _maxPrice = -1;
  double _minDistance = -1;
  double _maxDistance = -1;

  static late VettoreAnnunci _vettoreAnnunci = VettoreAnnunci._internal();

  ///La classe vettore annunci rappresenta la lista di annunci da visualizzare in base ai filtri settati
  factory VettoreAnnunci() => _vettoreAnnunci;

  ///La classe vettore annunci rappresenta la lista di annunci da visualizzare in base ai filtri settati.
  ///E' un singleton e applica i filtri secondo un builder pattern
  VettoreAnnunci._internal();


  ///Il metodo caricaAnnunci, li carica solo la prima volta settanto i km e i minuti
  ///solo se si sta impostando la prima sede o una differente
  Future<void> caricaAnnunci(bool settaSedi) async {

    if (_inizio) {
      _annunci = await LoadJson.loadAnnunci();
    }
    double minD = -1;
    double maxD = -1;
    double firstMin = _minDistance;
    double firstMax = _maxDistance;
    var response = [];
    if(settaSedi)
      {
        List<String> r = [];
        for(Annuncio a in _annunci) {
          r.add(a.getIndirizzo()+' '+a.getCitta());
        }
        response = await Utils.getDistances(r);
      }

    int j = 0;
    for (int i = 0; i < _annunci.length; i++) {
      Annuncio a = _annunci[i];
      double distanza = double.parse(response[j++]);
      if (settaSedi) {
        a.setDistanza(distanza);
        a.setMinBus(response[j++]);
        a.setMinWalk(response[j++]);



        if (minD == -1 || minD > distanza) {
          minD = distanza;
        }
        if (maxD == -1 || maxD < distanza) {
          maxD = distanza;
        }
      }
      if (_inizio) {
        double prezzo = a.getPrezzo();
        if (_minPrice == -1 || _minPrice > prezzo) _minPrice = prezzo;
        if (_maxPrice == -1 || _maxPrice < prezzo) _maxPrice = prezzo;
        List<String> im = await LoadJson.loadImmagini(a.getId());
        Map<String, String> prop = await LoadJson.loadProprieta(a.getId());
        a.caricaImmaginiAll(im);
        a.addAllRequisito(prop);
      }
    }

    if (settaSedi) {
      if (!_filtroDistanza) {
        _minDistance = minD;
        _maxDistance = maxD;
      } else {
        if (firstMin == -1 || firstMin > minD) _minDistance = minD;
        if (firstMax == -1 || firstMax < maxD) _maxDistance = maxD;
        if (_filtroDistanzaMinMax[0] == firstMin) {
          _filtroDistanzaMinMax[0] = _minDistance;
        }

        if (_filtroDistanzaMinMax[1] == firstMax) {
          _filtroDistanzaMinMax[1] = _maxDistance;
        }
      }
    }

    _inizio = false;
  }


  ///funzione che permette di incrementare o decrementare il numero dei filtri inseriti
  void _aggiornaNumFiltri(bool a, bool b, bool c, bool attuale) {
    if (!a && !b) {
      if (!attuale && c) {
        _numFiltri++;
      } else if (attuale && !c) {
        _numFiltri--;
      }
    }
  }

  ///funzione che permette di incrementare o decrementare il numero dei filtri inseriti
  void _aggiornaNumFiltro(bool a, bool attuale) {
    if (!attuale && a) {
      _numFiltri++;
    } else if (attuale && !a) {
      _numFiltri--;
    }
  }

 ///filtra per appartamento
  void filtraAppartamento(bool filtro) {
    _aggiornaNumFiltri(_singola, _doppia, filtro, _appartamento);
    _appartamento = filtro;
  }

  ///filtra per singola
  void filtraSingola(bool filtro) {
    _aggiornaNumFiltri(_appartamento, _doppia, filtro, _singola);
    _singola = filtro;
  }

  ///filtra per doppia
  void filtraDoppia(bool filtro) {
    _aggiornaNumFiltri(_singola, _appartamento, filtro, _doppia);
    _doppia = filtro;
  }

  ///filtra per tipologia solo maschile ammessa
  void filtraMaschio(bool filtro) {
    _aggiornaNumFiltri(_femmina, _misto, filtro, _maschio);
    _maschio = filtro;
  }

  ///filtra per tipologia solo femminile ammessa
  void filtraFemmina(bool filtro) {
    _aggiornaNumFiltri(_maschio, _misto, filtro, _femmina);
    _femmina = filtro;
  }

  ///filtra per per ambo i sessi
  void filtraMisto(bool filtro) {
    _aggiornaNumFiltri(_maschio, _femmina, filtro, _misto);
    _misto = filtro;
  }

  ///filtra per non fumatori ammessi
  void filtraFumatori(bool filtro) {
    _aggiornaNumFiltro(filtro, _noFumatori);
    _noFumatori = filtro;
  }

  ///filtra per non animali ammessi
  void filtraAnimali(bool filtro) {
    _aggiornaNumFiltro(filtro, _noAnimali);
    _noAnimali = filtro;
  }

  ///filtra per non proprietario vive in casa
  void filtraProprietario(bool filtro) {
    _aggiornaNumFiltro(filtro, _noProprietario);
    _noProprietario = filtro;
  }

  ///filtra per prezzo
  void filtraPrezzo(double min, double max) {
    if (min == _minPrice && max == _maxPrice) {
      removeFiltroPrezzo();
      return;
    }

    if (!_filtroPrezzo) {
      _numFiltri++;
      _filtroPrezzo = true;
    }
    _filtroPrezzoMinMax[0] = min;
    _filtroPrezzoMinMax[1] = max;
  }

  ///rimuovi il filtro prezzo
  void removeFiltroPrezzo() {
    _filtroPrezzoMinMax = [-1, -1];
    if (_filtroPrezzo) {
      _numFiltri--;
    }

    _filtroPrezzo = false;
  }

  ///filtra per distanza
  void filtraDistanza(double min, double max) {
    if (min == _minDistance && max == _maxDistance) {
      removeFiltroDistanza();
      return;
    }

    if (!_filtroDistanza) _numFiltri++;

    _filtroDistanza = true;
    _filtroDistanzaMinMax[0] = min;
    _filtroDistanzaMinMax[1] = max;
  }

  ///rimuovi il filtro distanza
  void removeFiltroDistanza() {
    _filtroDistanzaMinMax = [-1, -1];
    if (_filtroDistanza) {
      _numFiltri--;
    }

    _filtroDistanza = false;
  }

  ///setta ordina per prezzo, rimuove ordine per distanza
  void orderByPrice() {
    _orderByPrezzo = true;
    _orderByDistanza = false;
  }

  ///setta ordina per distanza, rimuove ordine per prezzo
  void orderByDistance() {
    _orderByDistanza = true;
    _orderByPrezzo = false;
  }

  ///rimuove tutti i tipi di ordinamento
  void removeOrderBy() {
    _orderByPrezzo = false;
    _orderByDistanza = false;
  }

 ///get sede inserita
  Sede getSede() => _setSede.getSede();

  ///get numero di filtri applicati
  int getNumFiltri() => _numFiltri;

  ///get il minimo e massimo prezzo applicato sul filtro prezzo
  List<double> getPriceList() => _filtroPrezzoMinMax;

  ///get il minimo e massimo distanza applicato sul filtro distanza
  List<double> getDistanceList() => _filtroDistanzaMinMax;

  ///get filtri tipologia alloggio
  List<bool> getTipo() => [_appartamento, _singola, _doppia];

  ///get filtri per tipo di sesso
  List<bool> getSesso() => [_femmina, _maschio, _misto];

  ///get filtri no animali, no fumatori, no proprietario convivente
  List<bool> getCaratteristiche() => [_noAnimali, _noFumatori, _noProprietario];

  ///get ordina prezzo
  bool getOrdByPrize() => _orderByPrezzo;

  ///get ordina distanza
  bool getOrderByDistance() => _orderByDistanza;

  ///get il minimo prezzo di tutti gli annunci
  double getMinPrice() => _minPrice;

  ///get il massimo prezzo di tutti gli annunci
  double getMaxPrice() => _maxPrice;

  ///get minima distanza di tutti gli annunci
  double getMinDistance() => _minDistance;

  ///get massima  distanza di tutti gli annunci
  double getMaxDistance() => _maxDistance;

 ///setta una nuova sede
  void setSede(Sede sede) {
    _setSede.setSede(sede);
  }


  ///il metodo visualizzaAnnunci visualizza tutti gli annunci filtrati, in base ai filtri settati dall' utene,
  /// ovvero agli attributi della classe
  List<Annuncio> visualizzaAnnunci() {
    List<Annuncio> annunci = [];

    for (Annuncio a in _annunci) {
      if (_filtroPrezzo) {
        if (a.getPrezzo() < _filtroPrezzoMinMax[0].floorToDouble() ||
            a.getPrezzo() > _filtroPrezzoMinMax[1].floorToDouble()) {
          continue;
        }
      }

      if (_filtroDistanza) {
        if (a.getDistanza() < _filtroDistanzaMinMax[0].floorToDouble() ||
            a.getDistanza() > _filtroDistanzaMinMax[1].floorToDouble()) {
          continue;
        }
      }

      if (_appartamento || _singola || _doppia) {
        if (!_appartamento && a.getTipo() == Tipo.APPARTAMENTO) continue;
        if (!_singola && a.getTipo() == Tipo.SINGOLA) continue;
        if (!_doppia && a.getTipo() == Tipo.DOPPIA) continue;
      }

      if (_maschio || _femmina || _misto) {
        if (!_maschio && a.getSesso() == Sesso.MASCHIO) continue;
        if (!_femmina && a.getSesso() == Sesso.FEMMINA) continue;
        if (!_misto && a.getSesso() == Sesso.MISTO) continue;
      }

      if (_noAnimali && a.getAnimaliAmmessi()) continue;

      if (_noFumatori && a.getFumatoriAmmessi()) continue;

      if (_noProprietario && a.getProprietarioConvivente()) continue;

      annunci.add(a);
    }

    if (_orderByPrezzo) {
      annunci.sort((an, b) => an.getPrezzo().compareTo(b.getPrezzo()));
    }

    if (_orderByDistanza) {
      annunci.sort((an, b) => an.getDistanza().compareTo(b.getDistanza()));
    }

    return annunci;
  }
}
