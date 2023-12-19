import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../front_end_utils/utilsFront.dart';

class FotoPage extends StatefulWidget {
  final List<String> foto;
  final int index;

  ///La classe FotoPage costruisce la schermata in cui saranno visualizzate le immagini dell' annuncio
  /// in grande con la possibilità di scrollarle
  FotoPage(this.foto,this.index);

  @override
  State<StatefulWidget> createState() => _FotoPage(foto,index);
}

class _FotoPage extends State<FotoPage> {
  final List<String> _fotoNormal;

  int activeIndex = 0;
  int ind;
  bool b = true;

  List<String> _foto = [];

  _FotoPage(this._fotoNormal, this.ind){

    _foto.add(_fotoNormal[ind]);
    for(int i = 0; i < _fotoNormal.length; i++){
      if(i != ind) _foto.add(_fotoNormal[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: Container(
            height: double.maxFinite,
            color: Colors.black,
            child: Container(
                width: double.maxFinite,
                height: 287,
                child: CarouselSlider.builder(
                  //shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,

                  itemCount: _foto.length,
                  itemBuilder: (BuildContext, int index, realIndex) {

                    return Stack(children: [

                      Center(
                          child: Container(
                              child: Image.asset(
                        _foto[index],
                        fit: BoxFit.cover,
                        width: 400,
                        height: double.maxFinite,
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
                                  width: 40,
                                  height: 30,
                                  child: Center(
                                      child: UtilsFront.textColor(
                                          (activeIndex + 1).toString() +
                                              '/${_foto.length}',
                                          15,
                                          Colors.black)))))
                    ]);
                  },
                  options: CarouselOptions(
                      viewportFraction: 1,

                      enlargeCenterPage: true,
                      height: 300,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {

                          setState(() => activeIndex = index);}),
                ))));
  }


}
