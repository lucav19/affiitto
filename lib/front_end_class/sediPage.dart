import 'package:flutter/material.dart';
import '../back_end_class/sede.dart';
import '../back_end_class/setSede.dart';
import '../front_end_utils/firstLogin.dart';
import '../front_end_utils/utilsFront.dart';
import 'annunciPage.dart';

class SediPage extends StatefulWidget {
  bool dalLogin;

  ///La classe Sedi costruisce la schermata dove l' utente dovrà scegliere la sua sede.
  /// Vi compare anche un campo TextField dove l' utente potrà inserire i caratteri che filtreranno
  /// le sedi con i suddetti caratteri nel prefisso del nome
  SediPage(this.dalLogin, {Key? key}) : super(key: key);

  @override
  State<SediPage> createState() => _Sedi(dalLogin);
}

class _Sedi extends State<SediPage> {

  bool _dalLogin;

  final _controller = TextEditingController();
  List<Sede> _lista = SetSede().visualizzaSedi("");
  Icon _icon = Icon(Icons.search, color: Colors.grey);
  final SetSede _setSede = SetSede();

  Widget _noAn = Padding(
      padding: EdgeInsets.only(top: 90),
      child: UtilsFront.textColor('Nessuna sede trovata', 20, Colors.black));
  late Widget _usa;

  _Sedi(this._dalLogin);

  Widget daUsare() {
    setState(() {
      FirstLogin.daSede = true;
      if (_lista.isEmpty) {
        _usa = _noAn;
      } else {
        _usa = Expanded(
            child: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey[300],
              padding: EdgeInsets.only(top: 4),
              child: Padding(
                padding: EdgeInsets.only(right: 3, left: 3),
                child: Card(
                  child: ListTile(
                    title: Text(
                      _lista[index].getNome(),
                      style: TextStyle(fontSize: UtilsFront.bigSize),
                    ),
                    onTap: () {


                      _setSede.setSede(_lista[index]);
                      if (_dalLogin) {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnnunciPage()));
                      } else {

                        setState(() {
                          FirstLogin.daSede = true;
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ));
      }
    });
    return _usa;
  }

  @override
  Widget build(BuildContext context) {

    return (Scaffold(
      appBar: AppBar(
        title: Text('Ricerca Alloggio'),
        backgroundColor: UtilsFront.color,
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Material(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: TextField(
                          onChanged: (s) {
                            setState(() {

                              if (_controller.text.isNotEmpty) {
                                _icon = Icon(Icons.close, color: Colors.grey);
                              } else {
                                _icon = Icon(Icons.search, color: Colors.grey);
                              }
                              _lista =
                                  _setSede.visualizzaSedi(_controller.text);
                            });
                          },
                          onSubmitted: (s) {
                            setState(() {

                              if (_controller.text.length != 0) {
                                _icon = Icon(Icons.close, color: Colors.grey);
                              } else {
                                _icon = Icon(Icons.search, color: Colors.grey);
                              }
                              _lista =
                                  _setSede.visualizzaSedi(_controller.text);
                            });
                          },
                          cursorColor: Colors.grey,
                          controller: _controller,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: IconButton(
                                icon: _icon,
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {

                                    _icon =
                                        const Icon(Icons.search, color: Colors.grey);
                                    _lista = _setSede.visualizzaSedi("");
                                  });
                                }),
                            hintText: "Cerca",
                            contentPadding: EdgeInsets.all(8),
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ))),
                ))),
        const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 4, top: 10, bottom: 10),
                //TextField lo metto come figlio di material così posso usare elevation per farmi l'ombra sotto
                child: Text(
                  "Seleziona la tua sede:",
                  style: TextStyle(
                      fontSize: UtilsFront.bigSize + 4,
                      fontWeight: FontWeight.w500),
                ))),
        const Divider(
          height: 1,
          color: UtilsFront.color,
          thickness: 1.3,
        ),
        daUsare()
      ]),
    ));
  }
}
