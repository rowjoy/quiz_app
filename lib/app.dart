import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/main_menu_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainMenuScreen(),
      builder: EasyLoading.init(),
    );
  }
}
