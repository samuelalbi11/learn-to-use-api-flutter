import 'package:flutter/material.dart';
import 'package:forumapp/views/home.dart';
import 'package:forumapp/views/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
      home: token == null ? const LoginPage() : const HomePage(),
    );
  }
}
