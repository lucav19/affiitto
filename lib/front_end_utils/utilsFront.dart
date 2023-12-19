import 'package:flutter/material.dart';


///La classe astratta UtilsFront offre delle funzioni di supporto e costanti per la
///parte relativa al front-end
abstract class UtilsFront {
  ///prefisso testo agevolazioni
  static String agevolazioni =
      "Sapienza informa sui bandi per dare supporto agli studenti con il pagamento dell'affitto e sui bandi regionali per alloggiare in uno studentato. Clicca sul seguente ";

  ///suffisso testo agevolazioni
  static String agevolazioni2 = ' per avere maggiori informazioni.';

  ///colore grigio
  static const Color grigio = Color.fromRGBO(80, 80, 80, 1);

  ///big size per il testo
  static const double bigSize = 15;

  ///medium size per il testo
  static const double mediumSize = 14;

  ///small size per il testo
  static const double smollSize = 13;

  ///altezza barra applica, e second bar lista annunci
  static const double sizeSecondBarr = 45;

  ///padding da inserire verticalmente dentro vari filtri, usato anche nell' annuncio
  static const double padIntraFilter = 14;

  ///padding da inserire tra un filtro e l' altro, usato anche nell' annuncio
  static const double padOutFilter = 50;

  ///colore sapienza
  static const Color sapienza = Color.fromRGBO(130, 36, 51, 1);

  ///colore app
  static const Color color = Color.fromRGBO(27, 54, 92, 1);

  ///colore second barr app
  static const Color colorScaffold = Color.fromRGBO(27, 54, 92, 50);

  ///colore rotella di caricamento
  static const Color colorScaffoldCerca = Color.fromRGBO(27, 54, 92, 80);

  ///colore grigio
  static const Color grey = Color(0x2D2D2DFF);

  ///metodo che ritorna un widget di testo usando testo, font e colore passati come parametri
  static Widget textColor(String s, double fontS, Color color) => Text(
        s,
        style: TextStyle(fontSize: fontS, color: color),
      );

  ///metodo che ritorna un widget di testo con scritta in grassetto.Per i titoli intermedi
  static Widget textTitle(String s) => Text(
        s,
        style: TextStyle(
            fontSize: bigSize,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      );


  ///funzione che ritorna il widget della descrizione primaria dell' annuncio che comprende, titolo,
  ///distanza della sede, e tempo necessario per percorrere la tratta sede-alloggio a piedi e con i mezzi
  static Widget descrizionePrimaria(String titolo, String prezzo,
          String distanza, String minBus, String minWalk, String sede) =>
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: ConstrainedBox(
                    //alignment: Alignment.center,

                    constraints: const BoxConstraints(maxWidth: 240, maxHeight: 180),
                    child: textTitle(titolo))),
            Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: textTitle(
                  prezzo.indexOf('.') == prezzo.length - 2
                      ? prezzo + '0 €  '
                      : prezzo + ' €  ',
                ))
          ],
        ),
        pad(10),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${distanza} km da ${sede}',
                  style: const TextStyle(
                    color: grigio,
                    fontSize: 13,
                  ),
                ),
              )),
        ]),
        Padding(
          padding: EdgeInsets.only(top: 8),
        ),
        Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.directions_walk_sharp,
                  color: Colors.grey,
                  size: 20,
                ),
                UtilsFront.textColor(' ${minWalk==''?' ND':minWalk}', 13, grigio),
                const Text('       '),
                const Icon(
                  Icons.directions_bus,
                  color: Colors.grey,
                  size: 20,
                ),
                UtilsFront.textColor(' ${minBus==''?' ND':minBus}', 13, grigio),
              ],
            ))
      ]);

  ///metodo che ritorna un widget padding, per facilitare uso padding per il top
  static Widget pad(double pad) => Padding(padding: EdgeInsets.only(top: pad));

}
