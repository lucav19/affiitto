import 'package:flutter/material.dart';

import '../back_end_class/vettoreAnnunci.dart';
import '../front_end_utils/utilsFront.dart';

/*
La classe OrdinaPage costruisce la schermata in cui l' utente potra selezionare al massimo
un tipo di ordinamento. E' dotata di un pulsante applica che se premuto applicherà il tipo
di ordinamento o il suo annullamento
 */
class OrdinaPage extends StatefulWidget {

  ///metodo che costruisce la schermata in cui l' utente potra selezionare al massimo
  ///un tipo di ordinamento. E' dotata di un pulsante applica che se premuto applicherà il tipo
  ///di ordinamento o il suo annullamento
  @override
  State<OrdinaPage> createState() => _OrdinaPage();
}

class _OrdinaPage extends State<OrdinaPage> {
  late Object _selectRadio = 0;

  VettoreAnnunci _vettore = VettoreAnnunci();
  late bool _firstPrice;
  late bool _firstDistance;

  final Widget _w = Container(
    width: 0.2,
    height: 0.2,
    decoration: const BoxDecoration(
        color: UtilsFront.color,
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );

  late bool _ordinaPrezzo;
  late bool _ordinaDistanza;

  Widget _w1 = Text('');
  Widget _w2 = Text('');

  _OrdinaPage() {
    _ordinaPrezzo = _vettore.getOrdByPrize();
    _firstPrice = _ordinaPrezzo;
    _ordinaDistanza = _vettore.getOrderByDistance();
    _firstDistance = _ordinaDistanza;

    if (_ordinaPrezzo) _w1 = _w;
    if (_ordinaDistanza) _w2 = _w;
  }

  void _rimuoviOrdina() {
    if (_firstPrice)
      _vettore.orderByPrice();
    else if (_firstDistance)
      _vettore.orderByDistance();
    else
      _vettore.removeOrderBy();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _rimuoviOrdina();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  _rimuoviOrdina();
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: UtilsFront.color,
            title: Text('Ordina'),
          ),
          body: Stack(children: [
            Padding(
                padding: EdgeInsets.only(top: 90, left: 25, right: 40),
                child: Column(children: [
                  Container(
                      color: Colors.transparent,
                      width: 280,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UtilsFront.color, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: _w1,
                              ),
                              UtilsFront.textColor('   Ordina per prezzo   €',
                                  UtilsFront.mediumSize, Colors.black)
                            ])),
                        onPressed: () {
                          _select(true);
                        },
                      )),
                  UtilsFront.pad(UtilsFront.padOutFilter),
                  Container(
                      width: 280,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Row(children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UtilsFront.color, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: _w2,
                              )),
                          UtilsFront.textColor('   Ordina per distanza   km',
                              UtilsFront.mediumSize, Colors.black)
                        ]),
                        onPressed: () {
                          _select(false);
                        },
                      ))
                ])),
            Align(
                alignment: FractionalOffset.bottomLeft,
                child: Container(
                    height: UtilsFront.sizeSecondBarr,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: UtilsFront.textColor(
                          'Applica', UtilsFront.bigSize, Colors.white),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size.infinite),
                          backgroundColor:
                              MaterialStateProperty.all(UtilsFront.color)),
                    )))
          ])),
    );
  }

  void _select(bool prezzo) {
    setState(() {
      if (prezzo) {
        if (_ordinaPrezzo) {
          _ordinaPrezzo = false;
          _w1 = Text('');
          if (!_ordinaDistanza) _vettore.removeOrderBy();
        } else {
          _ordinaPrezzo = true;
          _ordinaDistanza = false;
          _vettore.orderByPrice();
          _w1 = _w;
          _w2 = Text('');
        }
      } else {
        if (_ordinaDistanza) {
          _ordinaDistanza = false;
          _w2 = Text('');
          if (!_ordinaPrezzo) _vettore.removeOrderBy();
        } else {
          _ordinaDistanza = true;
          _ordinaPrezzo = false;
          _vettore.orderByDistance();
          _w2 = _w;
          _w1 = Text('');
        }
      }
    });
  }
}
