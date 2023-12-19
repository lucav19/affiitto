
///La classe Sede rappresente una sede universitaria che l' utente potra scegliere
///come punto di partenza dell' app. Comprende il codice, il nome, l' indirizzo e la città.
class Sede {
  String _codice;
  String _nomeSede;
  String _indirizzo;
  String _citta;

  ///Istanzia un oggetto Sede, coome parametri chide il codice della sede, il nme, l'indirizzo
  ///e la città
  Sede(
    this._codice,
    this._nomeSede,
    this._indirizzo,
    this._citta,
  );

  ///metodo che ritona una sede a partire da una mappa
  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        json["id"],
        json["nome"],
        json["indirizzo"],
        json["citta"],
      );

  ///get nome della sede
  String getNome() => _nomeSede;

  ///get indirizzo sede, via e civico
  String getIndirizzo() => _indirizzo;

  ///get codice della sede
  String getCodice() => _codice;

  ///get città dove è ubicata la sede
  String getCitta() => _citta;
}
