import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  static const String BASE_URL = 'https://api.thecatapi.com/v1/breeds';
  static const String API_KEY = 'bda53789-d59e-46cd-9bc4-2936630fde39';

  Future<List<dynamic>> getData() async {
    final url = Uri.parse('$BASE_URL');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $API_KEY'});

    List<dynamic> lstData = jsonDecode(response.body);

    for (dynamic element in lstData) {
      element["cfa_url"] = await getDataImg(element["id"]);
    }

    if (response.statusCode == 200) {
      return lstData;
    } else {
      throw Exception('Error cargando la información');
    }
  }

  Future<dynamic> getDataImg(String id) async {
    final url =
        Uri.parse('https://api.thecatapi.com/v1/images/search?breed_ids=$id');
    final response = await http.get(url);

    dynamic obt = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return obt.isEmpty ? null : obt[0]["url"];
    } else {
      throw Exception('Error cargando la información');
    }
  }
}
