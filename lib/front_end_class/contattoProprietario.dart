import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../front_end_utils/utilsFront.dart';
import 'contattaPage.dart';

class ContattaProprietario extends StatelessWidget {
  String _immagine;
  String _nome;
  bool _call;
  String _contatto;

  ///La classe ContattaProprietario che costruisce la schermata con i relativi dati
  ///del proprietario e consentirà di contattarlo i base al tipo di contatto che il proprietario
  ///ha inserito nei dati
  ContattaProprietario(this._nome, this._contatto, this._immagine, this._call) {
    if (_immagine.isEmpty) _immagine = 'assets/utente.jpg';
    List<String> nome = _nome.trim().split(' ');
    String n = '';
    for (int i = 0; i < nome.length; i++) {
      if (i == 0) {
        n += '${nome[i]}\n';
      } else if (nome[i] != '') {
        n += nome[i];
      }
    }
    _nome = n;
  }

  @override
  Widget build(BuildContext context) {
    String cont = _call ? 'Cell' : 'Mail';
    // TODO: implement build
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 70),
      color: Colors.white,
      child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: UtilsFront.color,
                ))),
        Row(children: [
          Container(
              padding: EdgeInsets.only(top: 15, left: 15),
              width: 155,
              height: 205,
              child: Image.asset(
                _immagine,
                fit: BoxFit.cover,
              )),
          Padding(padding: EdgeInsets.only(right: 15)),
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: UtilsFront.textColor(_nome, 30, Colors.black)),
        ]),
        UtilsFront.pad(80),
        Container(
          padding: EdgeInsets.only(left: 40),
          child: Column(children: [
            Align(
                alignment: Alignment.topLeft,
                child: UtilsFront.textColor(cont, 25, Colors.black)),
            UtilsFront.pad(10),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                  text: TextSpan(
                      text: _contatto,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContattaPage(_call)));
                        })),
            )
          ]),
        )
      ]),
    ));
  }
}
