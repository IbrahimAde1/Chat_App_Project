import 'package:chat_app/Pages/register_page.dart';
import 'package:chat_app/Pages/users_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/castom_snackbar.dart';
import '../widgets/castom_textfield.dart';
import '../widgets/custom_button.dart';

String? emailAddress;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController controllerueser = TextEditingController();
TextEditingController controllerpass = TextEditingController();

class _LoginState extends State<Login> {
  String? password;
  bool isLoaded = false;
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 20,
      inAsyncCall: isLoaded,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.purple,
              Colors.blue,
            ], begin: Alignment.topCenter),
          ),
          child: GlassContainer.clearGlass(
            width: double.infinity,
            height: double.infinity,
            borderColor: Colors.transparent,
            blur: 5,
            color: const Color.fromARGB(66, 8, 8, 8),
            child: Form(
              key: globalKey,
              child: ListView(
                children: [
                  Column(children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 20),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/message.png'),
                      ),
                    ),
                    Text(
                      'CHAT APP',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ]),
                  Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: CastomTextFiled(
                              autofocus: true,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              controller: controllerueser,
                              onChanged: (data) {
                                emailAddress = data;
                              },
                              vaildite: (data) {
                                if (data!.isNotEmpty) {
                                  final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(data);

                                  if (emailValid == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(
                                          backgroundColor: Colors.white,
                                          color: Colors.black,
                                          text: 'Valid email.🤨'),
                                    );
                                    return 'valid email';
                                  }
                                } else if (data.isEmpty ||
                                    emailAddress!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar(
                                        backgroundColor: Colors.white,
                                        color: Colors.black,
                                        text: 'Enter email.🤨'),
                                  );
                                  return 'Enter email';
                                }
                              },
                              hintText: 'Enter Email',
                              labelText: 'Email',
                              icon: const Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: CastomTextFiled(
                              autofocus: false,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: controllerpass,
                              onChanged: (data) {
                                password = data;
                              },
                              vaildite: (data) {
                                if (data != null) {
                                  if (data.length < 8 && data.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(
                                          backgroundColor: Colors.white,
                                          color: Colors.black,
                                          text: 'Email or password.🤨'),
                                    );
                                    return 'Password lessthen 8 char';
                                  } else if (data.isEmpty ||
                                      password!.isEmpty) {
                                    return 'Enter password';
                                  }
                                }
                              },
                              hintText: 'Enter Password',
                              labelText: 'Password',
                              icon: const Icon(
                                Icons.password,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (globalKey.currentState!.validate()) {
                            isLoaded = true;
                            setState(() {
                              emailAddress;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailAddress!,
                                      password: password!);

                              setState(() {
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const UserPage(),
                                      ));
                                });
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                      backgroundColor: Colors.white,
                                      color: Colors.black,
                                      text: 'No user found for that email.🤨'),
                                );
                              } else if (e.code == 'wrong-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                      backgroundColor: Colors.white,
                                      color: Colors.black,
                                      text: 'Erorr Email or password'),
                                );
                              }
                            }

                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () {
                                setState(() {
                                  isLoaded = false;
                                  controllerpass.clear();
                                  controllerueser.clear();
                                });
                              },
                            );
                          }
                        },
                        child: const CustomButton(
                            width: 300,
                            textButtom: 'LogIn',
                            height: 50,
                            backColor: Colors.black54,
                            textcolor: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            borderRadius: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            textAlign: TextAlign.center,
                            "Don't Have Accont?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.lightBlue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignUp();
                              }));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
