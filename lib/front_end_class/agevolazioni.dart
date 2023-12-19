import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../front_end_utils/utilsFront.dart';

class Agevolazioni extends StatelessWidget {

  ///Metodo che produce la schermata con rappresentato un testo
  ///e un link con cui l'utente potrà accedere alla pagina delle agevolazioni della sapienza
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Agevolazioni'),
        backgroundColor: UtilsFront.color,
      ),
      body: BodyAgevolazioni(),
    );
  }
}


class BodyAgevolazioni extends StatelessWidget {

  TextStyle defaultStyle = const TextStyle(color: Colors.black, fontSize: 40.0);
  TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  ///metodo che costruisce il corpo della schermata agevolazioni
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 13, 15, 8),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style:
              TextStyle(color: Colors.black, fontSize: UtilsFront.bigSize+5),
          children: <TextSpan>[
            TextSpan(text: UtilsFront.agevolazioni),
            TextSpan(
                text: 'link',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(
                        'https://www.uniroma1.it/it/pagina/borse-di-studio');
                  }),
            TextSpan(text: UtilsFront.agevolazioni2),
          ],
        ),
      ),
    );
  }
}
