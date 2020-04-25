import 'package:flutter/material.dart';
import 'package:healthcare/model/estado.dart';
import 'package:healthcare/services/covid_api.dart';
import 'package:healthcare/widgets/counter.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final controller = ScrollController();
  String nomeCidade = "";
  var _estados = [
    'Campos dos Goytacazes',
    'Alegre',
    'Campinas',
    'Rio de Janeiro'
  ];
  var _itemSelecionado = 'RJ';
  int _numero_casos = 0;
  int _numero_obitos = 0;
  Estado _estado;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: <Widget>[
          _header(),
          _visualizaCasos(),
//          RaisedButton(onPressed: (){
//            setState(() {
//              _itemSelecionado ='oi';
////              print();
//            });
//          })
        ],
      ),
    );
  }

  ClipPath _header() {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF3383CD), Color(0xFF12249F)]),
            image: DecorationImage(
                image: AssetImage('assets/backgrounds/fundo_virus.png'))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Image.asset('assets/images/doctor.png',
                      width: 230, fit: BoxFit.fitWidth),
                  Positioned(
                    top: 70,
                    left: 170,
                    child: Container(
                      width: 150,
                      child: Text(
                        'Um jeito SMART de se cuidar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }

  _visualizaCasos() {
    return FutureBuilder(
      future: DadosCovid19Api.fetch(),
      builder: (context, snapshot) {
        _estado = snapshot.data;
        _estados = _estado != null ? _estado.retornaEstados() : null;
        return Column(
          children: <Widget>[
            Text(
              'Casos confirmados',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _citySelector(),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                'Dados de $_itemSelecionado',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF12249F),
                  fontSize: 25,
                ),
              ),
            ),
//        SizedBox(
//          height: 20,
//        ),
            _mostraCasos(),
            SizedBox(
              height: 20,
            ),
//            Text(
//              'Cuidados no dia a dia',
//              style: TextStyle(
//                color: Colors.blue,
//                fontSize: 30,
//              ),
//            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  _citySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              underline: SizedBox(),
              value: _itemSelecionado != null ? _itemSelecionado : 'RJ',
              items: _estados != null
                  ? _estados.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList()
                  : ['RJ', 'ES'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
              onChanged: (String novoItem) {
                _dropDownItemSelected(novoItem);
                setState(() {
                  this._itemSelecionado = novoItem;
                  var casos = _estado.numeroCasos(novoItem);
                  print('Item: $novoItem');
                  print('Valor: $casos');
                  this._numero_casos = casos != null ? casos:0;
                  this._numero_obitos = _estado.numeroObitos();
//                  print( _estado.numeroCasos(_itemSelecionado));
                });
              }, // Executa acao ao selecionar cidade
            ),
          ),
        ],
      ),
    );
  }

  _mostraCasos() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.black,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Counter(
            color: Colors.yellow,
            number: _numero_casos,
            title: "Infectados",
          ),
//          Counter(
//            color: Colors.red,
//            number: _numero_obitos,
//            title: "Mortes",
//          ),

        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
//    throw UnimplementedError();
  }
}
