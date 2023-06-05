import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:belajar/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class User {
  final String id;
  final String email;
  final String namaLengkap;
  final String password;

  User({
    required this.id,
    required this.email,
    required this.namaLengkap,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'namaLengkap': namaLengkap,
        'password': password,
      };
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Colors.red;

  bool passwordObscure = true;

  Future registerUser(User users) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final json = users.toJson();

    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60),
                alignment: Alignment.center,
                child: Text(
                  "Register Account",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'NexaBold',
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              _fieldTitle('User ID'),
              const SizedBox(height: 15),
              Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 8,
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: primary,
                        size: screenWidth / 15,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth / 15),
                        child: TextFormField(
                          controller: idController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: idController.clear,
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight / 35),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _fieldTitle('Email'),
              const SizedBox(height: 15),
              Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 8,
                      child: Icon(
                        Icons.email,
                        color: primary,
                        size: screenWidth / 15,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth / 15),
                        child: TextFormField(
                          controller: emailController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: emailController.clear,
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight / 35),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _fieldTitle('Nama Lengkap'),
              const SizedBox(height: 15),
              Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 8,
                      child: Icon(
                        Icons.person,
                        color: primary,
                        size: screenWidth / 15,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth / 15),
                        child: TextFormField(
                          controller: namaController,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: namaController.clear,
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight / 35),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _fieldTitle('Password'),
              const SizedBox(height: 15),
              Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 8,
                      child: Icon(
                        Icons.lock,
                        color: primary,
                        size: screenWidth / 15,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth / 15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: passwordObscure,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight / 35),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    passwordObscure = !passwordObscure;
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  String id = idController.text.trim();
                  String password = passwordController.text.trim();
                  String email = emailController.text.trim();
                  String namaLengkap = namaController.text.trim();

                  if (id.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Masukan User ID"),
                      ),
                    );
                  } else if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Masukan Password"),
                      ),
                    );
                  } else if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Masukan Email"),
                      ),
                    );
                  } else if (namaLengkap.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Masukan Nama"),
                      ),
                    );
                  } else {
                    try {
                      final users = User(
                        id: idController.text,
                        email: emailController.text,
                        namaLengkap: namaController.text,
                        password: passwordController.text,
                      );

                      registerUser(users);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Register Sukses"),
                        ),
                      );
                      // ignore: empty_catches
                    } catch (e) {}
                  }

                  idController.clear();
                  emailController.clear();
                  namaController.clear();
                  passwordController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: 60,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NexaBold',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "Kembali ke",
                    style: TextStyle(fontFamily: 'NexaRegular'),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const KeyboardVisibilityProvider(
                            child: LoginScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue, fontFamily: 'NexaRegular'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontFamily: 'NexaBold',
        color: Colors.black,
      ),
    );
  }
}
