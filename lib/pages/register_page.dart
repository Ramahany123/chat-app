import 'package:chat_app2/constants.dart';
import 'package:chat_app2/helper/validators.dart';
import 'package:chat_app2/services/auth_exception_handler.dart';
import 'package:chat_app2/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/custom_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password, username;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final authService = AuthService();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ModalProgressHUD(
        color: kSecondaryColor,
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
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
                      "Register",
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
                  'Username',
                  onChanged: (data) {
                    username = data;
                  },
                  validator: Validators.validateUsername,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  'Email',
                  onChanged: (data) {
                    email = data;
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
                  onChanged: (data) {
                    password = data;
                  },
                  validator: Validators.validatePassword,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  "Register",
                  onTap: () async {
                    //made a variable to use it before await to avoid async gaps
                    final messenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    try {
                      await authService.registerUser(email!, password!);
                      showSuccessSnackBar(
                          messenger, "User registered successfully");
                      db
                          .collection(kUsersCollection)
                          .doc(email!.toLowerCase())
                          .set({
                        kUsername: username,
                        kUserEmail: email,
                      });
                      navigator.pushNamedAndRemoveUntil(
                          ChatPage.id, (Route<dynamic> route) => false,
                          arguments: {
                            'email': email!.toLowerCase(),
                            'username': username
                          });
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
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
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
