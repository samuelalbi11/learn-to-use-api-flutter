import 'package:flutter/material.dart';
import 'package:forumapp/controllers/authentication.dart';
import 'package:forumapp/views/login_page.dart';
import 'package:forumapp/views/widgets/input_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  
  // memasukan authenticationController ke variable _authencticationController
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register Page',
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                // mengirim parameter hintext berupa placeholder, obscure text berupa apakah text yang dimasukan tidak bisa dilihat, dan controllernya ke inputWidget
                hintText: 'Name',
                obsecureText: false,
                controller: _nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Username',
                obsecureText: false,
                controller: _usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Email',
                obsecureText: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password',
                obsecureText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              //takes a callback method that returns a widget
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.fromLTRB(30, 17, 30, 17)),
                onPressed: () async {
                  await _authenticationController.register(
                      // best practice memasukan variabel yang sudah ke dalam parameter register
                      name: _nameController.text.trim(),
                      username: _usernameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Register',
                          style: GoogleFonts.poppins(fontSize: size * 0.040),
                        );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
