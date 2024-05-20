import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:interview/db_helper.dart';
import 'package:interview/view/homepage.dart';
import 'package:interview/view/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLogin = false;
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool('isLogin') ?? false;
  await DbHelper().initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin == false ? LoginPage() : HomePage(),
    );
  }
}
