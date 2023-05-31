import 'package:chat_app/Pages/register_page.dart';
import 'package:chat_app/Pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../validetor/email_validatoer.dart';
import '../validetor/password_validetor.dart';
import '../widgets/castom_snackbar.dart';
import '../widgets/castom_textfield.dart';
import '../widgets/custom_button.dart';
import 'cubit/login_cubit/login_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static String id = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey();
    TextEditingController controllerueser = TextEditingController(),
        controllerpass = TextEditingController();
    String? password, emailAddress;
    bool isLoaded = false;

    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitLoading) {
          isLoaded = true;
        } else if (state is LoginCubitSaccess) {
          Navigator.pushNamed(context, UserPage.id);
          isLoaded = false;
        } else if (state is LoginCubitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
                backgroundColor: Colors.white,
                color: Colors.black,
                text: state.massage),
          );
          isLoaded = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          blur: 5,
          inAsyncCall: isLoaded,
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blueGrey,
              child: Form(
                key: globalKey,
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
                                  return emialValidetor(
                                      data, context, emailAddress);
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
                                  return passwordVaildetor(
                                      data, context, password);
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
                              BlocProvider.of<LoginCubit>(context)
                                  .emailAddress = emailAddress;
                              BlocProvider.of<LoginCubit>(context).login(
                                  emailAddress: emailAddress!,
                                  password: password!);
                              Navigator.popAndPushNamed(context, UserPage.id);
                              controllerpass.clear();
                              controllerueser.clear();
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
                                Navigator.pushNamed(context, RegisterPage.id);
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
        );
      },
    );
  }
}
