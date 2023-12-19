import 'package:flutter/material.dart';

import '../back_end_class/vettoreAnnunci.dart';
import '../front_end_utils/utilsFront.dart';


class FiltriPage extends StatefulWidget {
  final VettoreAnnunci vettore;

  /// La classe FiltriPage costruisce la schermata dei filtri. Ha due slider per settare
  /// distanza e prezzo e delle caselle di selezione multiscelta per gli altri filtri.
  /// Ha un pulsante applica che se premuto applica i filtri, se invece si torna indietro
  /// li disapplica
  FiltriPage(this.vettore);

  @override
  State<FiltriPage> createState() => _FiltriPageState(vettore);
}

class _FiltriPageState extends State<FiltriPage> {
  late double _prezzoMinAssoluto;
  late double _prezzoMaxAssoluto;
  late double _distanzaMinAssoluto;
  late double _distanzaMaxAssoluto;
  late double _distanzaMax;
  late double _distanzaMin;
  late double _prezzoMax;
  late double _prezzoMin;
  late String _minP; //stringhe di appoggio
  late String _maxP;
  late String _minD;
  late String _maxD;
  late bool _appartamento;
  late bool _singola;
  late bool _doppia;
  late bool _femminile;
  late bool _maschile;
  late bool _misto;
  late bool _noAnimali;
  late bool _noFumatori;
  late bool _noProprietario;

  /*
  Appaggio per tenere stato nel caso non si applicassero ppiù i filtri premendo x
   */
  late double _distanzaMax2;
  late double _distanzaMin2;
  late double _prezzoMax2;
  late double _prezzoMin2;
  late bool _appartamento2;
  late bool _singola2;
  late bool _doppia2;
  late bool _femminile2;
  late bool _maschile2;
  late bool _misto2;
  late bool _noAnimali2;
  late bool _noFumatori2;
  late bool _noProprietario2;

  VettoreAnnunci _v;

  _FiltriPageState(this._v) {
    _prezzoMaxAssoluto = _v.getMaxPrice();
    _prezzoMinAssoluto = _v.getMinPrice();
    _distanzaMaxAssoluto = _v.getMaxDistance();
    _distanzaMinAssoluto = _v.getMinDistance();

    List<double> minMaxPrice = _v.getPriceList();

    double maxP = minMaxPrice[1];
    _prezzoMax = maxP == -1 ? _prezzoMaxAssoluto : maxP.toDouble();
    _prezzoMax2 = _prezzoMax;
    double minP = minMaxPrice[0];
    _prezzoMin = minP == -1 ? _prezzoMinAssoluto : minP.toDouble();
    _prezzoMin2 = _prezzoMin;

    List<String> l = _minMaxStr(_prezzoMin, _prezzoMax, true);

    _minP = l[0];
    _maxP = l[1];

    List<double> minMaxDistance = _v.getDistanceList();
    double maxD = minMaxDistance[1];

    _distanzaMax = maxD == -1 ? _distanzaMaxAssoluto : maxD;
    _distanzaMax2 = _distanzaMax;
    double minD = minMaxDistance[0];
    _distanzaMin = minD == -1 ? _distanzaMinAssoluto : minD;
    _distanzaMin2 = _distanzaMin;

    List<String> ll = _minMaxStr(_distanzaMin, _distanzaMax, false);

    _minD = ll[0];
    _maxD = ll[1];

    List<bool> t = _v.getTipo();

    _appartamento = t[0];
    _singola = t[1];
    _doppia = t[2];

    _appartamento2 = t[0];
    _singola2 = t[1];
    _doppia2 = t[2];

    t = _v.getSesso();
    _femminile = t[0];
    _maschile = t[1];
    _misto = t[2];

    _femminile2 = t[0];
    _maschile2 = t[1];
    _misto2 = t[2];

    t = _v.getCaratteristiche();
    _noAnimali = t[0];
    _noFumatori = t[1];
    _noProprietario = t[2];

    _noAnimali2 = t[0];
    _noFumatori2 = t[1];
    _noProprietario2 = t[2];
  }

  void _rimuoviFiltri() {
    _v.filtraPrezzo(_prezzoMin2, _prezzoMax2);
    _v.filtraDistanza(_distanzaMin2, _distanzaMax2);
    _v.filtraAppartamento(_appartamento2);
    _v.filtraSingola(_singola2);
    _v.filtraDoppia(_doppia2);
    _v.filtraFemmina(_femminile2);
    _v.filtraMaschio(_maschile2);
    _v.filtraMisto(_misto2);
    _v.filtraAnimali(_noAnimali2);
    _v.filtraFumatori(_noFumatori2);
    _v.filtraProprietario(_noProprietario2);
  }

  @override
  Widget build(BuildContext context) {
    int divisionPrice =
        ((_prezzoMaxAssoluto - _prezzoMinAssoluto) / 50).toInt();
    int divisionDistance =
        (_distanzaMaxAssoluto - _distanzaMinAssoluto).toInt();
    if (divisionPrice < 1) divisionPrice = 1;
    if (divisionDistance < 1) divisionDistance = 1;
    return WillPopScope(
      onWillPop: () async {
        _rimuoviFiltri();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: UtilsFront.color,
            title: Text('Filtri'),
            leading: IconButton(
                onPressed: () {
                  _rimuoviFiltri();
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Stack(children: [
            ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: UtilsFront.textTitle(
                  '  Prezzo:   €',
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: UtilsFront.padIntraFilter.toDouble())),
              Row(children: [
                BuildSideLabel(_minP),
                Expanded(
                    child: SliderTheme(

                        data: const SliderThemeData(
                          thumbColor: UtilsFront.color,
                          activeTrackColor: UtilsFront.color,
                          activeTickMarkColor: Colors.transparent,
                          inactiveTickMarkColor: Colors.transparent,
                          //overlayColor: Colors.grey.opacity(200),

                        ),
                        child: RangeSlider(
                          values: RangeValues(_prezzoMin, _prezzoMax),
                          //activeColor: UtilsFront.color,
                          min: _prezzoMinAssoluto,
                          max: _prezzoMaxAssoluto,
                          divisions: divisionPrice,
                          onChanged: (values) {
                            setState(() {
                              _prezzoMin = values.start.toDouble();
                              _prezzoMax = values.end.toDouble();

                              List<String> l =
                                  _minMaxStr(_prezzoMin, _prezzoMax, true);

                              _minP = l[0];
                              _maxP = l[1];

                              _v.filtraPrezzo(_prezzoMin, _prezzoMax);
                            });
                          },
                        ))),
                BuildSideLabel(_maxP),
              ]),
              Padding(
                padding:
                    EdgeInsets.only(top: UtilsFront.padOutFilter.toDouble()),
                child: UtilsFront.textTitle(
                  '  Distanza dalla Sede:   km',
                ),
              ),
              Container(
                  child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
                    child: Text(
                      ' Sede: ${_v.getSede().getNome()}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: UtilsFront.mediumSize,
                      ),
                      maxLines: 3,
                    )),
              )),
              Padding(
                  padding: EdgeInsets.only(
                      top: UtilsFront.padIntraFilter.toDouble())),
              Row(children: [
                BuildSideLabel(_minD),
                Expanded(
                    child: SliderTheme(
                        data: const SliderThemeData(
                          thumbColor: UtilsFront.color,
                          activeTrackColor: UtilsFront.color,
                          activeTickMarkColor: Colors.transparent,
                          inactiveTickMarkColor: Colors.transparent,
                        ),
                        child: RangeSlider(
                          values: RangeValues(_distanzaMin, _distanzaMax),

                          min: _distanzaMinAssoluto,
                          max: _distanzaMaxAssoluto,
                          divisions: divisionDistance,
                          onChanged: (values) {
                            setState(() {
                              _distanzaMin = values.start.toDouble();
                              _distanzaMax = values.end.toDouble();
                              List<String> ll =
                                  _minMaxStr(_distanzaMin, _distanzaMax, false);
                              _minD = ll[0];
                              _maxD = ll[1];

                              _v.filtraDistanza(_distanzaMin, _distanzaMax);
                            });
                          },
                        ))),
                BuildSideLabel(_maxD),
              ]),
              Padding(
                  padding:
                      EdgeInsets.only(top: UtilsFront.padOutFilter.toDouble())),
              UtilsFront.textTitle('  Tipo di alloggio:'),
              Padding(
                  padding: EdgeInsets.only(
                      top: UtilsFront.padIntraFilter.toDouble())),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _appartamento,
                    onChanged: ((value) {
                      setState(() {
                        _appartamento = value!;
                        _v.filtraAppartamento(_appartamento);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'appartamento', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _singola,
                    onChanged: ((value) {
                      setState(() {
                        _singola = value!;
                        _v.filtraSingola(_singola);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'stanza singola', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _doppia,
                    onChanged: ((value) {
                      setState(() {
                        _doppia = value!;
                        _v.filtraDoppia(_doppia);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'stanza doppia', UtilsFront.mediumSize, Colors.black))
              ]),
              Padding(
                  padding:
                      EdgeInsets.only(top: UtilsFront.padOutFilter.toDouble())),
              UtilsFront.textTitle('  Sesso:'),
              Padding(
                  padding: EdgeInsets.only(
                      top: UtilsFront.padIntraFilter.toDouble())),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _femminile,
                    onChanged: ((value) {
                      setState(() {
                        _femminile = value!;
                        _v.filtraFemmina(_femminile);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'solo femminile', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _maschile,
                    onChanged: ((value) {
                      setState(() {
                        _maschile = value!;
                        _v.filtraMaschio(_maschile);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'solo maschile', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _misto,
                    onChanged: ((value) {
                      setState(() {
                        _misto = value!;
                        _v.filtraMisto(_misto);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'misto', UtilsFront.mediumSize, Colors.black))
              ]),
              Padding(
                  padding:
                      EdgeInsets.only(top: UtilsFront.padOutFilter.toDouble())),
              UtilsFront.textTitle('  Caratteristiche:'),
              Padding(
                  padding: EdgeInsets.only(
                      top: UtilsFront.padIntraFilter.toDouble())),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _noAnimali,
                    onChanged: ((value) {
                      setState(() {
                        _noAnimali = value!;
                        _v.filtraAnimali(_noAnimali);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'no animali', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _noFumatori,
                    onChanged: ((value) {
                      setState(() {
                        _noFumatori = value!;
                        _v.filtraFumatori(_noFumatori);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor(
                        'no fumatori', UtilsFront.mediumSize, Colors.black))
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Checkbox(
                    fillColor: MaterialStateProperty.all(UtilsFront.color),
                    activeColor: UtilsFront.color,
                    value: _noProprietario,
                    onChanged: ((value) {
                      setState(() {
                        _noProprietario = value!;
                        _v.filtraProprietario(_noProprietario);
                      });
                    })),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: UtilsFront.textColor('no proprietario di casa',
                        UtilsFront.mediumSize, Colors.black))
              ]),
              Text("\n\n\n\n\n\n")
            ]),
            Align(
                alignment: FractionalOffset.bottomLeft,
                child: Container(
                    height: 45,
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

  Widget BuildSideLabel(String s) => Row(children: [
        Text('    '),
        Container(
            width: 35,
            height: 22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: UtilsFront.color),
            child: Center(
                child: Text(s,
                    style: TextStyle(
                        fontSize: UtilsFront.smollSize, color: Colors.white)))),
        Text('    ')
      ]);

  List<String> _minMaxStr(double min, double max, bool prezzo) {
    double minimum = prezzo ? _prezzoMinAssoluto : _distanzaMinAssoluto;
    double maximum = prezzo ? _prezzoMaxAssoluto : _distanzaMaxAssoluto;
    String mini = min == minimum ? 'Min' : min.toInt().toString();
    String maxi = max == maximum ? 'Max' : max.toInt().toString();
    return [mini, maxi];
  }
}
