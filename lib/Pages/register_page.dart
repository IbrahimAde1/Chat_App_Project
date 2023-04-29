import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/castom_snackbar.dart';
import '../widgets/castom_textfield.dart';
import '../widgets/custom_button.dart';

String? username;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? emailAddress;
  String? password;
  bool isSave = false;
  GlobalKey<FormState> mykey = GlobalKey();
  TextEditingController controlleruser = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controlleremail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 20,
      inAsyncCall: isSave,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.bottomCenter),
          ),
          child: Container(
            color: const Color.fromARGB(78, 0, 0, 0),
            child: Form(
              key: mykey,
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
                                keyboardType: TextInputType.name,
                                controller: controlleruser,
                                onChanged: (data) {
                                  username = data;
                                },
                                vaildite: (data) {
                                  if (data!.isEmpty) {
                                    return 'Enter username';
                                  }
                                },
                                hintText: 'Enter userName',
                                labelText: 'UserName',
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                )),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CastomTextFiled(
                                  autofocus: false,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controlleremail,
                                  onChanged: (data) {
                                    emailAddress = data;
                                  },
                                  vaildite: (data) {
                                    if (data!.isNotEmpty) {
                                      final bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(data);

                                      if (emailValid == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBar(
                                              backgroundColor: Colors.white,
                                              color: Colors.black,
                                              text: 'Valid email.🤨'),
                                        );
                                        return 'valid email';
                                      }
                                    } else if (data.isEmpty ||
                                        emailAddress!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  icon: const Icon(Icons.email,
                                      color: Colors.blue))),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: CastomTextFiled(
                                  autofocus: false,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: controllerpassword,
                                  onChanged: (deta) {
                                    password = deta;
                                  },
                                  vaildite: (data) {
                                    if (data != null) {
                                      if (data.length < 8 && data.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          snackBar(
                                              backgroundColor: Colors.white,
                                              color: Colors.black,
                                              text:
                                                  'Password lessthen 8 char.🤨'),
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
                                  icon: const Icon(Icons.password,
                                      color: Colors.blue))),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (mykey.currentState!.validate()) {
                            isSave = true;
                            setState(() {});
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailAddress!,
                                password: password!,
                              );
                              CollectionReference addUser = FirebaseFirestore
                                  .instance
                                  .collection('users');
                              addUser.add({
                                'email': emailAddress,
                                'name': username,
                                'password': password,
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                      backgroundColor: Colors.white,
                                      color: Colors.black,
                                      text: 'weak-password'),
                                );
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                      backgroundColor: Colors.white,
                                      color: Colors.black,
                                      text:
                                          'The account already exists for that email.🤨'),
                                );
                              }
                            }
                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () {
                                setState(() {
                                  isSave = false;
                                });
                              },
                            );

                            Future.delayed(const Duration(seconds: 2), () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBar(
                                    backgroundColor: Colors.white,
                                    color: Colors.black,
                                    text: 'Success👍'),
                              );
                              controlleruser.clear();
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const CustomButton(
                            width: 300,
                            textButtom: 'Register',
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
                            "Already Have Accont?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.lightBlue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
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
