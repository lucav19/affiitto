import 'package:affiitto/front_end_class/sediPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../back_end_class/annuncio.dart';
import '../back_end_class/setSede.dart';
import '../back_end_class/vettoreAnnunci.dart';
import '../front_end_utils/firstLogin.dart';
import '../front_end_utils/icons.dart';
import '../front_end_utils/utilsFront.dart';
import 'Agevolazioni.dart';
import 'annuncioPage.dart';
import 'filtriPage.dart';
import 'loginPage.dart';
import 'ordinaPage.dart';


///La classe AnnunciPage costruisce la schermata principale dell' app, dove l' utente
///potrà andare sulla pagina dei filtri, dell' ordinamento, del cambio di sede e delle agevolazioni.
///Possiede una lista di annunci con le immagini dell' annuncio
///scrollabili, il prezzo la distanza dalla sede e i minuti necessari per
///percorrere dal sito dell' annuncio alla sede, a piedi e con bus.
///
class AnnunciPage extends StatefulWidget {

  ///La classe AnnunciPage costruisce la schermata principale dell' app, dove l' utente
  ///potrà andare sulla pagina dei filtri, dell' ordinamento, del cambio di sede e delle agevolazioni.
  ///Possiede una lista di annunci con le immagini dell' annuncio
  ///scrollabili, il prezzo la distanza dalla sede e i minuti necessari per
  ///percorrere dal sito dell' annuncio alla sede, a piedi e con bus.
  ///
  AnnunciPage({Key? key}) : super(key: key);

  @override
  State<AnnunciPage> createState() => _AnnunciPageState();
}

class _AnnunciPageState extends State<AnnunciPage> {

  VettoreAnnunci _v = VettoreAnnunci();
  List<Annuncio> _l = [];

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: UtilsFront.color,
        leading: Stack(children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Align(
                alignment: Alignment.center,
                child: Icon(Icons.euro),
              )),
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Agevolazioni()),
                  );
                },
                icon: Icon(MyFlutterApp.hand_holding, size: 29.8)),
          )
        ]),
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Ricerca Alloggio'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, size: 30),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Sei sicuro di voler uscire?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Annulla',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: const Text('Conferma',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: Stack(children: [
        Padding(
            padding: const EdgeInsets.only(top: 34),
            child: FutureBuilder(
                future: _v.caricaAnnunci(FirstLogin.daSede),
                builder: (context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _l = _v.visualizzaAnnunci();
                    FirstLogin.daSede = false;
                    if (_l.length == 0) {
                      return const Center(
                          child: Text(
                        'Nessun annuncio disponibile',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ));
                    }
                    return _listaAnnunci(_l);
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: UtilsFront.colorScaffold,
                  ));
                })),
        Container(
            color: UtilsFront.colorScaffold,
            height: UtilsFront.sizeSecondBarr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 2, left: 5),
                        child: Text('Sede:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: UtilsFront.bigSize - 1,
                            ))),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: ConstrainedBox(
                          //alignment: Alignment.center,

                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width / 2.35),
                          child: Text(
                            '${_v.getSede().getNome()}',
                            //softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.justify,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: UtilsFront.bigSize - 1,
                            ),
                          )),
                    ),
                    IconButton(
                        //padding: EdgeInsets.only(left: 0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SediPage(false)),
                          ).then((value) {
                            setState(() {
                              FirstLogin.daSede = true;
                            });

                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 26,
                        ),
                        color: Colors.white)
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 0.7),
                        width: 55,
                        child: Stack(children: [
                          _pallino(_v.getNumFiltri() == 0
                              ? ''
                              : _v.getNumFiltri().toString()),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FiltriPage(_v)),
                                ).then((value) {
                                  setState(() {
                                    _l = _v.visualizzaAnnunci();
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 28,
                              )),
                        ])),
                    Container(
                        width: 50,
                        child: Stack(children: [
                          _pallino(_v.getOrdByPrize()
                              ? '€'
                              : _v.getOrderByDistance()
                                  ? 'km'
                                  : ''),
                          Padding(
                              padding: EdgeInsets.only(top: 2.5, right: 0),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrdinaPage()),
                                        ).then((value) {
                                          setState(() {
                                            _l = _v.visualizzaAnnunci();
                                          });
                                        });
                                      },
                                      icon: Icon(
                                        MyFlutterApp.sort_alt_up,
                                        color: Colors.white,
                                        size: 21,
                                      )))),
                        ])),
                    Text('  ')
                  ],
                ),
              ],
            )),
      ]));

  Widget _listaAnnunci(List<Annuncio> _l) {
    if (_l.isEmpty) {
      return const Center(
          child: Text(
        'Nessun annuncio disponibile',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));
    }
    return Padding(
        padding: EdgeInsets.only(top: 11.4),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _l.length,
            itemBuilder: (BuildContext, int index) {
              Annuncio a = _l[index];
              String prezzo = _l[index].getPrezzo().toString();
              prezzo = prezzo.indexOf('.') == prezzo.length - 2
                  ? prezzo + '0'
                  : prezzo;
              prezzo += ' €    ';
              return Column(children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnnuncioPage(
                                annuncio: _l[index],
                              )),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0x2D2D2DFF)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 5, right: 5))),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProductCarousel(_l[index].getImmagini()),
                            UtilsFront.descrizionePrimaria(
                                _l[index].getTitolo(),
                                _l[index].getPrezzo().toString(),
                                _l[index].getDistanza().toString(),
                                _l[index].getMinBus(),
                                _l[index].getMinWalk(),
                                SetSede().getSede().getNome())
                          ])),
                ),
                Container(height: 8, color: UtilsFront.grey)
              ]);
            }));
  }

  Widget _pallino(String s) {
    double padR = 0;
    if (s == 'km' || s == '€')
      padR = 2.8;
    else
      padR = 8;
    if (s.length == 0) return Text('');
    return Padding(
        padding: EdgeInsets.only(right: padR, top: 2),
        child: Align(
            alignment: Alignment.topRight,
            child: Container(
                height: 19,
                width: 19,
                decoration: const BoxDecoration(
                    color: UtilsFront.sapienza,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                    child: Text(
                  s,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                )))));
  }
}

class ProductCarousel extends StatefulWidget {
  List<String> immagini;

  ProductCarousel(this.immagini);

  @override
  State<ProductCarousel> createState() => _ProductCarousel(immagini);
}

class _ProductCarousel extends State<ProductCarousel> {
  int activeIndex = 0;
  final List<String> immagini;
  List<Widget> w = [];

  _ProductCarousel(this.immagini) {
    for (String s in immagini) {
      w.add(Image.asset(
        s,
        fit: BoxFit.cover,
        width: 400,
        height: 287,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        height: 290,
        child: CarouselSlider.builder(
          //shrinkWrap: true,
          // scrollDirection: Axis.horizontal,

          itemCount: immagini.length,
          itemBuilder: (BuildContext, int index, realIndex) {
            return Stack(children: [
              Center(
                  child: Container(
                      child: Image.asset(
                immagini[index],
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 290,
              ))),
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
                          width: 50,
                          height: 25,
                          child: Center(
                              child: UtilsFront.textColor(
                                  (activeIndex + 1).toString() +
                                      '/${immagini.length}',
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
}
