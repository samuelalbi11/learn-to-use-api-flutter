import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/views/home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  // digunakan utuk menyimpan tamu
  final box = GetStorage();

  Future register({
    // parameter register
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      // menginisialisasikan 'variable' : variable dari paramter
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password
      };

      // response authenctication menggunakan http.post
      var response = await http.post(
        // isi parameter berupa url + endPointnya dalam hal ini register, url didapat dari constants
        Uri.parse('${url}register'),
        headers: {
          // headers adalah best practice untuk membuat atau menggunakan api
          'Accept': 'application/json',
        },
        // mengisi body dengan data dari var dimana data merupakan json, dan ini sama seperti pada postman
        body: data,
      );

      // mengecek response jika 201 (created something) dimana berhasil maka is loading yang dimana dari tadi berputar akan mati dan pada terpinal akan menuliskan response data yang di insert
      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());
      } else {
        // jika gagal maka loading bar juga mati dan akan menampilkan pesan ke terinalnya
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future login({
    // parameter register
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      // menginisialisasikan 'variable' : variable dari paramter
      var data = {'username': username, 'password': password};

      // response authenctication menggunakan http.post
      var response = await http.post(
        // isi parameter berupa url + endPointnya dalam hal ini register, url didapat dari constants
        Uri.parse('${url}login'),
        headers: {
          // headers adalah best practice untuk membuat atau menggunakan api
          'Accept': 'application/json',
        },
        // mengisi body dengan data dari var dimana data merupakan json, dan ini sama seperti pada postman
        body: data,
      );

      // mengecek response jika 200 (OK) dimana berhasil maka is loading yang dimana dari tadi berputar akan mati dan pada terpinal akan menuliskan response data yang di insert
      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());
      } else {
        // jika gagal maka loading bar juga mati dan akan menampilkan pesan ke terinalnya
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
