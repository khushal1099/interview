import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class PWDController extends GetxController{
  var passwordVisible = true.obs;

  void toggle() {
    passwordVisible.value = !passwordVisible.value;
  }
}