import 'package:get/get.dart';
import 'package:interview/model/api_helper.dart';
import 'package:interview/model/product_model.dart';

class SearchProductController extends GetxController {

  RxList<Product> searchList = <Product>[].obs;
  ApiHelper helper = ApiHelper();
  RxBool isFav=false.obs;

  @override
  void onInit() {
    searchList.value = helper.pList;
    super.onInit();
  }


  void sProduct(String product) {
    List<Product> result = [];
    if (product.isEmpty) {
      result = helper.pList;
    } else {
      result = helper.pList
          .where((e) => e.title
              .toString()
              .toLowerCase()
              .contains(product.toLowerCase()))
          .toList();
    }
    searchList.value = result;
  }
}
