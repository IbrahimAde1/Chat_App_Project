import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../model/user_model.dart';
import 'chat_page.dart';
import 'login_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  static String id = "UserPage";

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? user;
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Users> showusers = [];

          for (int f = 0; f < snapshot.data!.docs.length; f++) {
            showusers.add(Users.fromjson(snapshot.data!.docs[f]));
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(78, 250, 250, 250),
              centerTitle: true,
              title: const Text(
                ' Starting Chat',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Login.id);
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Chat.jpg'), fit: BoxFit.cover)),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: showusers.length,
                        itemBuilder: (context, we) {
                          return Container(
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Card(
                              borderOnForeground: true,
                              elevation: 30,
                              color: const Color.fromARGB(74, 105, 240, 175),
                              child: ListTile(
                                subtitle: Text(
                                  style: const TextStyle(color: Colors.grey),
                                  DateTime.now().toString().substring(0, 10),
                                  textAlign: TextAlign.right,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                enableFeedback: true,
                                onTap: () {
                                  user = snapshot.data!.docs[we]['name']
                                      .toString();
                                  Navigator.pushNamed(context, ChatPage.id,
                                      arguments: user);
                                },
                                title: Row(children: [
                                  CircleAvatar(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Text(
                                      snapshot.data!.docs[we]['name']
                                          .toString()
                                          .substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      snapshot.data!.docs[we]['name']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ]),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Color.fromARGB(131, 255, 255, 255),
            body: ModalProgressHUD(
              inAsyncCall: true,
              blur: 20,
              child: Text('loading ....'),
            ),
          );
        }
      },
    );
  }
}
