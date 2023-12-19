import 'package:flutter/material.dart';



class ContattaPage extends StatelessWidget {
  bool _chiamata;

  ///La pagina contatta page costruisce la schermata con cui saranno presenti, qualora con permesso,
  ///i dati del proprietario dell' alloggio con i relativi contatti
  ContattaPage(this._chiamata);

  @override
  Widget build(BuildContext context) {
    Icon ic;
    if (_chiamata) {
      ic = const Icon(
        Icons.call,
        color: Colors.green,
        size: 100,
      );
    } else {
      ic = const Icon(Icons.mail_outline, color: Colors.red, size: 100);
    }

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: Container(
            color: Colors.black,
            child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ic,
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
              Text('      '),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
                      Text('      '),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            ]))));
  }
}
