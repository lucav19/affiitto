import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import '../back_end_class/annuncio.dart';
import '../back_end_class/setSede.dart';
import '../back_end_utils/utils.dart';
import '../front_end_utils/utilsFront.dart';
import 'contattoProprietario.dart';
import 'fotoPage.dart';

class AnnuncioPage extends StatefulWidget {
  final Annuncio annuncio;

  ///La classe AnnncioPage costruisce la schermata che raffigura l' annuncio, con tutte
  ///le sue caratteristiche. Consente di visualizzare l' annuncio sulla mappa,
  ///e di andare alla schermata per contattare il proprietario
  AnnuncioPage({required this.annuncio});

  ///metodo per avere un schermata con stato
  @override
  State<AnnuncioPage> createState() => _AnnuncioPage(annuncio);
}

class _AnnuncioPage extends State<AnnuncioPage> {

  final Annuncio _a;
  int activeIndex = 0;
  SetSede _setSede = SetSede();

  _AnnuncioPage(this._a);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_a.getTitolo()),
          backgroundColor: UtilsFront.color,
        ),
        body: ListView(
          children: [
            _listImage(),
            UtilsFront.descrizionePrimaria(_a.getTitolo(),
                _a.getPrezzo().toString(), _a.getDistanza().toString(),
                _a.getMinBus(),
                _a.getMinWalk(),
                _setSede.getSede().getNome()),
            UtilsFront.pad(UtilsFront.padOutFilter),
            UtilsFront.textTitle('  Descrizione:'),
            UtilsFront.pad(UtilsFront.padIntraFilter),
            Padding(
                padding: EdgeInsets.only(right: 15, left: 15),
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.maxFinite),
                    child: Text(_a.getDescrizione(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: UtilsFront.mediumSize,
                          color: Colors.black,
                        )))),
            UtilsFront.pad(UtilsFront.padOutFilter),
            UtilsFront.textTitle('  Caratteristiche:'),
            UtilsFront.pad(UtilsFront.padIntraFilter),
            _containerPpoprieta(
                [
                  'indirizzo',
                  'contratto',
                  'disponibilità',
                  'tipo',
                  'sesso',
                  'locali',
                  'bagni',
                  'fumatori',
                  'animali',
                  'proprietario'
                ],
                _a.getAltriRequisiti().keys,
                [
                  Utils.firstUpperCase(_a.getIndirizzo()) +
                      ' ' +
                      Utils.firstUpperCase(_a.getCitta()),
                  _a.getContratto(),
                  _a.getDisponibilita(),
                  _a.getTipo() == Tipo.APPARTAMENTO
                      ? 'appartamento'
                      : _a.getTipo() == Tipo.SINGOLA
                          ? 'stanza singola'
                          : 'stanza doppia',
                  _a.getSesso() == Sesso.MASCHIO
                      ? 'solo maschile'
                      : _a.getSesso() == Sesso.FEMMINA
                          ? 'solo femminile'
                          : 'indifferente',
                  _a.getNumeroLocali().toString(),
                  _a.getNumeroBagni().toString(),
                  _a.getFumatoriAmmessi() ? 'ammessi' : 'non ammessi',
                  _a.getAnimaliAmmessi() ? 'ammessi' : 'non ammessi',
                  _a.getProprietarioConvivente()
                      ? 'vive in casa'
                      : 'non vive in casa'
                ],
                _a.getAltriRequisiti().values,

            ),
            UtilsFront.pad(UtilsFront.padIntraFilter),
            Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Row(children: [
                  const Icon(Icons.add_location_rounded),
                  ElevatedButton(
                      onPressed: () async {
                        final url =
                            'https://www.google.com/maps/search/${Uri.encodeFull(_a.getIndirizzo() + ' ' + _a.getCitta())}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Column(children: const [
                        Text('vedi su mappa',
                            style: TextStyle(
                                fontSize: UtilsFront.mediumSize,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold))
                      ]))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 22.5),
                child: Row(children: [
                  UtilsFront.textTitle('Contatta il proprietario   '),
                  _contatti()
                ])),
            const Text('\n\n\n\n\n'),
          ],
        ),
      );

  final Icon _cel = Icon(Icons.call, color: Colors.green, size: 30);
  final Icon _mail = Icon(Icons.mail_outline, color: Colors.red, size: 30);

  Widget _contatti() {
    String nome = _a.getNome();
    String cell = _a.getCellulare();
    String email = _a.getMail();
    String immagine = _a.getImmagine();
    IconButton cel = IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContattaProprietario(nome, cell, immagine, true)),
          );
        },
        icon: _cel);

    IconButton mail = IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContattaProprietario(nome, email, immagine, false)),
          );
        },
        icon: _mail);

    if (_a.getCellulare().length != 0 && _a.getMail().length != 0) {
      return Row(
        children: [cel, Text('   '), mail],
      );
    }
    if (_a.getCellulare().length != 0) {
      return cel;
    }
    return mail;
  }

  Widget _containerPpoprieta(
      List<String> keys,
      Iterable<String> addKey,
      List<String> value,
      Iterable<String> addValue,

      ) {
    keys.addAll(addKey);
    value.addAll(addValue);
    List<Widget> w = [];
    String s = '';

    for (int i = 0; i < keys.length; i++) {
      double pad = UtilsFront.padIntraFilter - 4;
      if (i == keys.length - 1) pad = 0;
      w.add(Column(children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxHeight: double.maxFinite),
            child: Stack(children: [
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: double.maxFinite, maxWidth: 100),
                child: UtilsFront.textColor(
                    keys[i], UtilsFront.smollSize, Colors.black),
              ),
              Divider(color: Colors.transparent),
              Padding(
                padding: EdgeInsets.only(left: 115),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: double.maxFinite, maxWidth: 210),
                    child: UtilsFront.textColor(
                        value[i], UtilsFront.smollSize, Colors.black)),
              ),
            ])),
        UtilsFront.pad(pad)
      ]));
    }
    return Padding(
        padding: EdgeInsets.only(left: 17),
        child: Align(
            alignment: FractionalOffset.topLeft, child: Column(children: w)));
  }

  Widget _listImage() => Container(
      height: 280,
      child: CarouselSlider.builder(
        //shrinkWrap: true,
        // scrollDirection: Axis.horizontal,

        itemCount: _a.getImmagini().length,
        itemBuilder: (BuildContext, int index, realIndex) {
          return Stack(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FotoPage(_a.getImmagini(), index)),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey[400],
                  ),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 4, right: 4))),
              child: Center(
                  child: Container(
                      child: Image.asset(
                _a.getImmagini()[index],
                fit: BoxFit.cover,
                width: 400,
                height: 287,
              ))),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                    opacity: 0.7,
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        width: 40,
                        height: 30,
                        child: Center(
                            child: UtilsFront.textColor(
                                (activeIndex + 1).toString() +
                                    '/${_a.getImmagini().length}',
                                15,
                                Colors.black)))))
          ]);
        },

        options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            height: 300,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index)),
      ));
}
