import 'package:affiitto/front_end_class/sediPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../front_end_utils/firstLogin.dart';
import '../front_end_utils/utilsFront.dart';
import 'Agevolazioni.dart';
import 'annunciPage.dart';


class LoginPage extends StatelessWidget {

  ///La classe LoginPage costruisce la schermata del login, dove comparirà l' immagine con il logo
  /// dell' app, la possibilità di scrivere email e password, in oltre ci sarà il pulsante
  /// che consentirà di andare alla pagina di agevolazioni
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Ricerca Alloggio'),
          leading: new Container(),
          centerTitle: true,
          backgroundColor: UtilsFront.color),
      body: BodyLogin(),
    );
  }
}

class BodyLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var _controller = TextEditingController();
    var _controller2 = TextEditingController();
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 230),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 16,top: 0),
                    child: Text('ACCESSO', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,))),
                Container(
                    margin: EdgeInsets.only(bottom: 8,top: 10, right: 150),
                    child: Text('Email istituzionale', style: TextStyle(fontSize: 18))),
                Container(
                  height: 40,
                  width: 300,
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Material(
                    elevation: 5,
                    child: TextField(
                        cursorColor: Colors.grey,
                        controller: _controller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffixIcon: IconButton(icon: Icon(Icons.close, color: Colors.grey),
                              onPressed: () {_controller.clear();}),
                          hintText: "cognome.matricola@studenti.uniroma1.it",
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 8,top: 10, right: 220),
                    child: Text('Password', style: TextStyle(fontSize: 18))),
                Container(
                  height: 40,
                  width: 300,
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Material(
                    elevation: 6,
                    child:
                    TextField(
                        cursorColor: Colors.grey,
                        obscureText: true,
                        controller: _controller2,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffixIcon: IconButton(icon: Icon(Icons.close, color: Colors.grey),
                              onPressed: () {_controller2.clear();}),
                          hintText: "• • • • • •", //stringa che compare SOLO all'interno della barra
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic), //fontStyle: FontStyle.normal, per cambiare il font della scritta,
                        )
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: (ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: UtilsFront.color,),
                    child: Text('Login', style: TextStyle(fontSize: 18),),
                    onPressed: ()  {

                      if(FirstLogin.firstLogin) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SediPage(true)
                        ));
                      }
                      else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AnnunciPage()
                            ));
                      }
                    },
                  )
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(bottom: 16,top: 10),
                    width: 300,
                    constraints: BoxConstraints.expand(height: 40, width: 300),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: UtilsFront.color,),
                      child: Row(
                        children: <Widget>[

                          Text("Consulta le agevolazioni", style: TextStyle(fontSize: 20),
                          ),

                          Image.asset(
                            'assets/mano.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Agevolazioni()
                          ));
                      },
                    )
                ),
              ]
          ),
        ),
      ],
    );
  }
}