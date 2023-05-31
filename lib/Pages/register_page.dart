import 'package:chat_app/Pages/login_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../validetor/email_validatoer.dart';
import '../validetor/password_validetor.dart';
import '../widgets/castom_snackbar.dart';
import '../widgets/castom_textfield.dart';
import '../widgets/custom_button.dart';
import 'cubit/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';
  @override
  Widget build(BuildContext context) {
    String? username, emailAddress, password;
    bool isSave = false;
    GlobalKey<FormState> mykey = GlobalKey();
    TextEditingController controlleruser = TextEditingController(),
        controllerpassword = TextEditingController(),
        controlleremail = TextEditingController();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isSave = true;
        } else if (state is RegisterSaccess) {
          Navigator.pushNamed(context, Login.id);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
                backgroundColor: Colors.white,
                color: Colors.black,
                text: 'Success👍'),
          );
          isSave = false;
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
                backgroundColor: Colors.white,
                color: Colors.black,
                text: state.massageFail),
          );
          isSave = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          blur: 5,
          inAsyncCall: isSave,
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blueGrey,
              child: Form(
                key: mykey,
                child: ListView(
                  children: [
                    const Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 70, bottom: 20),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          backgroundImage: AssetImage('images/message.png'),
                        ),
                      ),
                      Text(
                        'Register',
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
                                    return null;
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
                                      return emialValidetor(
                                          data, context, emailAddress);
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
                                      return passwordVaildetor(
                                          data, context, password);
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
                              BlocProvider.of<RegisterCubit>(context).register(
                                  emailAddress: emailAddress!,
                                  password: password!,
                                  username: username!);
                              controlleruser.clear();
                              Navigator.pop(context);
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
        );
      },
    );
  }
}
