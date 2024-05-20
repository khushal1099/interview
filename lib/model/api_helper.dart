import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interview/model/product_model.dart';

class ApiHelper {
  static ApiHelper obj = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() {
    return obj;
  }

  RxList<Product> pList = <Product>[].obs;

  Future<void> getApi() async {
    try {
      var get = await http.get(
          Uri.parse(
              "https://dummyjson.com/products"));

      if(get.statusCode==200){
        Map<String,dynamic> data = jsonDecode(get.body) as Map<String,dynamic>;
        var dataList = data["products"] as List<dynamic>;
        pList.value=dataList.map((e) {
          print("EEEE = > $e");
          return Product.fromJson(e);
        }).toList();

      }

      print("ress ${get.body}");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
