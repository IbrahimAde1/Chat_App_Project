import 'package:chat_app/Pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/chat_page.dart';
import 'Pages/cubit/login_cubit/login_cubit.dart';
import 'Pages/cubit/register_cubit/register_cubit.dart';
import 'Pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => const Login(),
          UserPage.id: (context) => const UserPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          ChatPage.id: (context) => const ChatPage(),
        },
      ),
    );
  }
}
