import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:belajar/screens/home_screen.dart';
import 'package:belajar/screens/register_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  bool passwordObscure = true;

  Color primary = Colors.red;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isKeyboardVisible
                ? SizedBox(height: screenHeight / 16)
                : Container(
                    height: screenHeight / 3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(35),
                        bottomLeft: Radius.circular(35),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'TOKOKU',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NexaBold',
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(
                top: screenHeight / 20,
                bottom: screenHeight / 20,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: screenWidth / 18, fontFamily: 'NexaBold'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldTitle('Username'),
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
                  _fieldTitle('Password'),
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
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      String id = idController.text.trim();
                      String password = passwordController.text.trim();

                      if (id.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Username masih kosong"),
                          ),
                        );
                      } else if (password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password masih kosong"),
                          ),
                        );
                      } else {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("users")
                            .where('id', isEqualTo: id)
                            .get();
                        try {
                          if (password == snap.docs[0]['password']) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Password salah"),
                              ),
                            );
                          }
                        } catch (e) {
                          String error = " ";

                          if (e.toString() ==
                              "RangeError (index): Invalid value: Valid value range is empty: 0") {
                            setState(
                              () {
                                error = "Username salah";
                              },
                            );
                          } else {
                            setState(() {
                              error = "Terjadi kesalahan!";
                            });
                          }
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                            ),
                          );
                        }
                      }
                    },
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
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NexaBold',
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Belum memiliki akun?",
                    style: TextStyle(fontFamily: 'NexaRegular'),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterAccountScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.blue, fontFamily: 'NexaRegular'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: 'NexaBold',
        ),
      ),
    );
  }
}
