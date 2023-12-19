///La classe ImmaginiJson permette di recuperare le immagini degli annunci e dei relativi proprietari
///dal database simulato dai file json
class ImmaginiJson {
  ImmaginiJson({
    required this.idAnnuncio,
    required this.idDrive,
  });

  int idAnnuncio;
  String idDrive;

  ///La classe ImmaginiJson permette di recuperare le immagini degli annunci e dei relativi proprietari
  ///dal database simulato dai file json
  factory ImmaginiJson.fromJson(Map<String, dynamic> json) => ImmaginiJson(
        idAnnuncio: int.parse(json["idAnnuncio"]),
        idDrive: json["idDrive"].toString(),
      );
}
