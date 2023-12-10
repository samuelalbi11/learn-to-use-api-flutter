import 'package:flutter/material.dart';
import 'package:forumapp/controllers/authentication.dart';
import 'package:forumapp/views/register_page.dart';
import 'package:forumapp/views/widgets/input_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                'Login Page',
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                // mengirim parameter hintext berupa placeholder, obscure text berupa apakah text yang dimasukan tidak bisa dilihat, dan controllernya ke inputWidget
                hintText: 'Username',
                obsecureText: false,
                controller: _usernameController,
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(30, 17, 30, 17)),
                  onPressed: () async {
                    await _authenticationController.login(
                        username: _usernameController.text.trim(),
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
                            'Login',
                            style: GoogleFonts.poppins(fontSize: size * 0.040),
                          );
                  })),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const RegisterPage());
                },
                child: Text(
                  'Register',
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
