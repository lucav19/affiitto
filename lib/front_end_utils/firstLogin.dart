
///La classe FirstLogin è astratta e possiede due booleani che raffigurano se
///l' utente ha già effettuato il login, e se l' utente e arrivato dalla pagina delle sedi dove
///che indicherà il dover ricalcolare le distanze
abstract class FirstLogin{

  ///booleano che indica se si è al primo login, così da riprendere i dati settati
  ///in precedenza nel caso contrario
  static bool firstLogin = true;

  ///booleano che indica se bisogna ricalcolare le distanze
  static bool daSede = true;
}