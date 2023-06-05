import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  var url = "https://fakestoreapi.com/products/category/";

  loadProductFromApi(String categoryName) async {
    var response = await http.get(Uri.parse(url + categoryName));
    return json.decode(response.body);
  }
}
