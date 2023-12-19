

///La classe ProprietaJson raffigura le proprietà aggiuntive che l'utente che ha inserito l' annuncio
///può mettere
class ProprietaJson {
  ProprietaJson({
    required this.idAnnuncio,
    required this.chiave,
    required this.valore,
  });

  int idAnnuncio;
  String chiave;
  String valore;

  ///La classe ProprietaJson raffigura le proprietà aggiuntive che l'utente che ha inserito l' annuncio
  ///può mettere
  factory ProprietaJson.fromJson(Map<String, dynamic> json) => ProprietaJson(
    idAnnuncio: json["idAnnuncio"],
    chiave: json["chiave"],
    valore: json["valore"],
  );

}
