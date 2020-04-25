

class Estado{
  List<String> _lista_estados = List<String>();
  List _dados_estados = List<Map>();
  int _numero_casos = null;
  int _numero_obitos = null;

  Estado(this._dados_estados, this._numero_casos,this._numero_obitos){
    _geraListaEstados(this._dados_estados);


  }

  void _geraListaEstados(estados){
    estados.forEach((estado){
      _lista_estados.add(estado['state'].toString());
    });
//    print(_lista_estados);
  }

  factory Estado.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return Estado(json['infectedByRegion'],json['infected'],json['deceased']);
  }
  List retornaEstados() => _lista_estados != null ? _lista_estados:['RJ'];

  int numeroCasos(String estado_selecionado){
    _dados_estados.forEach((element) {
      if(element['state'] == estado_selecionado) {
        _numero_casos = element['count'] as int;
        _numero_obitos = element['count'] as int;
      }

    });
    return _numero_casos;
  }
  int numeroObitos() => _numero_obitos;
}