import 'dart:convert';

import '../back_end_utils/utils.dart';



///La classe Annuncio rappresenta un annuncio da visualizzare, possiede caratteristiche primarie,
///secondarie, immagini e dati dell' utente che lo ha pubblicato
class Annuncio {
  int _id;
  String _nomeProprietario;
  String _immagineProprietario;
  String _titolo;
  String _immaginePrincipale;
  double _prezzo;
  String _indirizzo;
  String _citta;
  String _contratto;
  String _disponibilita;
  Sesso _sesso;
  String _cellulare;
  bool _cellularevisibile;
  String _mail;
  bool _mailvisibile;
  Tipo _tipo;
  int _numerobagni;
  int _numerolocali;
  String _descrizione;
  bool _proprietarioconvivente;
  bool _animaliammessi;
  bool _fumatoriammessi;

  String _minWalk = '';
  String _minBus = '';
  double _distanza = 0;


  List<String> _immagini = [];
  Map<String, String> _altriRequisiti = {};

  ///istanzia un oggetto di tipo Annuncio, chiede come parametri tutte le caratteristiche principali
  ///dell' annuncio
  Annuncio(
    this._id,
    this._nomeProprietario,
    this._immagineProprietario,
    this._titolo,
    this._immaginePrincipale,
    this._prezzo,
    this._indirizzo,
    this._citta,
    this._contratto,
    this._disponibilita,
    this._sesso,
    this._cellulare,
    this._cellularevisibile,
    this._mail,
    this._mailvisibile,
    this._tipo,
    this._numerobagni,
    this._numerolocali,
    this._descrizione,
    this._proprietarioconvivente,
    this._animaliammessi,
    this._fumatoriammessi,
  ) {
    _immaginePrincipale = Utils.assetPath.trim() + _immaginePrincipale;
    _immagini.add(_immaginePrincipale + '.png');
  }
/// Metodo che crea un annuncio, con tutte le sue caratterisctiche,
/// a partire da Una Mappa
  factory Annuncio.fromJson(Map<String, dynamic> json) {
    return Annuncio(
      json["id"],
      json['nome'],
      json['immagine'],
      json["titolo"],
      json["immaginePrincipale"],
      double.parse(json["prezzo"]),
      json["indirizzo"],
      json["citta"],
      json['contratto'],
      json["disponibilita"],
      Utils.compareString(json['sesso'], 'FEMMINA')
          ? Sesso.FEMMINA
          : Utils.compareString(json['sesso'], 'MASCHIO')
              ? Sesso.MASCHIO
              : Sesso.MISTO,
      json["cellulare"],
      Utils.stringToBool(json["cellularevisibile"]),
      json["mail"],
      Utils.stringToBool(json["mailvisibile"]),
      Utils.compareString(json['tipo'], 'APPARTAMENTO')
          ? Tipo.APPARTAMENTO
          : Utils.compareString(json['tipo'], 'SINGOLA')
          ? Tipo.SINGOLA
          : Tipo.DOPPIA,
      json["numerobagni"],
      json["numerolocali"],
      json["descrizione"],
      Utils.stringToBool(json["proprietarioconvivente"]),
      Utils.stringToBool(json["animaliammessi"]),
      Utils.stringToBool(json["fumatoriammessi"]),
    );
  }

  /// get id annuncio
  int getId() => _id;

  /// get nome utente che ha inserito l' annuncio
  String getNome() => _nomeProprietario;

  /// get immagine proprietario
  String getImmagine() => _immagineProprietario;

  ///get titolo annuncio
  String getTitolo() => _titolo;

  ///get immagine principale annuncio
  String getImmagineprincipale() => _immaginePrincipale;

  ///get prezzo annuncio
  double getPrezzo() => _prezzo;

  ///get indirizzo annuncio, via e civico
  String getIndirizzo() => _indirizzo;

  ///get città dove è inserito per il quale si riferisce l' annuncio
  String getCitta() => _citta;

  ///get tipologia del contratto dell' annuncio
  String getContratto() => _contratto;

  ///get disponibilità dell' annuncio, da quando si può iniziare ad affittarlo
  String getDisponibilita() => _disponibilita;

  ///get il sesso per il quale si cerca un affittuario
  Sesso getSesso() => _sesso;

  ///get numero cellulare proprietario
  String getCellulare() {
    if (_cellularevisibile) return _cellulare;
    return '';
  }

  ///get minuti necessari per percorrere tratta sede-casa a piedi
  String getMinWalk() => _minWalk;

  ///get minuti necessari per percorrere tratta sede-casa con i mezzi
  String getMinBus() => _minBus;

  ///get mail del proprietario
  String getMail() {
    if (_mailvisibile) return _mail;
    return '';
  }

  ///get tipo di alloggio offerto se appartamento, stanza singola o doppia
  Tipo getTipo() => _tipo;

  ///get numero bagni
  int getNumeroBagni() => _numerobagni;

  ///get numero locali
  int getNumeroLocali() => _numerolocali;

  ///get descrizione annuncio
  String getDescrizione() {
    List<String> s1 = _descrizione.split('');
    String ris = '';
    for (int i = 0; i < s1.length; i++) {
      if (i == 0)
        ris += s1[i].toUpperCase();
      else
        ris += s1[i];
    }
    return ris;
  }

  ///get booleano che indica se i fumatori sono ammessi
  bool getFumatoriAmmessi() => _fumatoriammessi;

  ///get booleano che indica se gli animali sono ammessi
  bool getAnimaliAmmessi() => _animaliammessi;

  ///get booleano che indica se il proprietario vive in casa
  bool getProprietarioConvivente() => _proprietarioconvivente;

  ///get distanza tra la sede e l' ubicazione dell' alloggio proposto nell' annuncio
  double getDistanza() => _distanza;

  ///get immagini dell' annuncio, inclusa quella princiape in testa
  List<String> getImmagini() => _immagini;

  ///get mappa di altri requisiti dell' annuncio della forma chiave calore
  Map<String, String> getAltriRequisiti() => _altriRequisiti;

  ///set distanza tra la sede e l' annuncio
  void setDistanza(double d) => _distanza = d;

  ///set minuti impiegati per percorrere la tratta sede-allogio a piedi
  void setMinWalk(String minWalk) => _minWalk = minWalk;

  ///set minuti impiegati per percorrere la tratta sede-allogio con i mezzi
  void setMinBus(String minBus) => _minBus = minBus;

  ///aggiunge un requisito chiave valore ai requisiti aggiuntivi dell' annuncio
  void addRequisito(String chiave, String valore) {
    _altriRequisiti[chiave] = valore;
  }

  ///carica un' immagine secondarie dell' annunio
  void _caricaImmagini(String path) {
    path = Utils.assetPath.trim() + path.trim() + '.png';
    _immagini.add(path);
  }

  ///carica più immagini secondarie dell' annuncio
  void caricaImmaginiAll(List<String> im) {
    for (String s in im) _caricaImmagini(s);
  }

  ///carica più requisiti secindari dell' annuncio della forma chiave valore
  void addAllRequisito(Map<String, String> m) {
    _altriRequisiti.addAll(m);
  }
}

///Enum che raffigura il sesso ammesso per l' annuncio
enum Sesso { MASCHIO, FEMMINA, MISTO }


///Enume che raffigura affitto riferito all' annuncio
enum Tipo { APPARTAMENTO, SINGOLA, DOPPIA }
