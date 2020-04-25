import 'dart:convert';

import 'package:healthcare/model/estado.dart';
import 'package:http/http.dart' as http;

class DadosCovid19Api {
  static Future<Estado> fetch() async {
    try {
      var url = 'https://api.apify.com/v2/key-value-stores/TyToNta7jGKkpszMZ/records/LATEST?disableRedirect=true';
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);


//        print(data);
        return Estado.fromMap(data);
      }

    } catch (error) {
      print('Erro: $error');
//      return List<Question>();
    }
  }
}