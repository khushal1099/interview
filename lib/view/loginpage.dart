import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/controller/password_controller.dart';
import 'package:interview/db_helper.dart';
import 'package:interview/view/homepage.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PWDController controller = Get.put(PWDController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  DbHelper helper = DbHelper();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          // Wrap your form with Form widget
          key: _formKey, // Assign the global key to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email: ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Please enter your email';
                  }
                  else if (!value!.contains("@")) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Password: ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => TextFormField(
                  controller: password,
                  obscureText: controller.passwordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Enter your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.toggle();
                      },
                      icon: Icon(
                        // Use different icon based on whether the password is visible or not
                        controller.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed only if the form is valid
                      helper.insertUser(email.text, password.text);
                      prefs.setBool('isLogin', true);
                      Get.off(HomePage());
                      email.clear();
                      password.clear();
                    }
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
