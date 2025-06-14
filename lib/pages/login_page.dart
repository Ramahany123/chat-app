import 'package:chat_app2/constants.dart';
import 'package:chat_app2/helper/custom_snackbar.dart';
import 'package:chat_app2/helper/validators.dart';
import 'package:chat_app2/pages/register_page.dart';
import 'package:chat_app2/services/auth_exception_handler.dart';
import 'package:chat_app2/services/auth_service.dart';
import 'package:chat_app2/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final authService = AuthService();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: const Color(0xff27445E),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                const Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  'Email',
                  onChanged: (value) {
                    email = value;
                  },
                  validator: Validators.validateEmail,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hasToggleVisibility: true,
                  obscureText: true,
                  'Password',
                  onChanged: (value) {
                    password = value;
                  },
                  validator: Validators.validatePassword,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  "Login",
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await authService.loginUser(email!, password!);
                      final userDoc = await FirebaseFirestore.instance
                          .collection(kUsersCollection)
                          .doc(email!.toLowerCase())
                          .get();
                      if (userDoc.exists) {
                        final username = userDoc[kUsername];
                        showSuccessSnackBar(messenger, "Loged in successfully");
                        navigator.pushNamedAndRemoveUntil(
                            ChatPage.id, (Route<dynamic> route) => false,
                            arguments: {
                              'email': email!.toLowerCase(),
                              'username': username
                            });
                      }
                    } on AuthExceptionHandler catch (e) {
                      showErrorSnackBar(messenger, e.message);
                    } catch (e) {
                      showErrorSnackBar(
                          messenger, "An unexpected error occurred");
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffC6E8E7),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
