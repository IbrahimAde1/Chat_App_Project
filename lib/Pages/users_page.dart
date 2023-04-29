import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../model/user_model.dart';
import 'chat_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Users> showusers = [];

          for (int f = 0; f < snapshot.data!.docs.length; f++) {
            showusers.add(Users.fromjson(snapshot.data!.docs[f]));
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue,
              title: const Text(
                ' Starting Chat',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: GlassContainer.clearGlass(
              borderColor: Colors.transparent,
              height: double.infinity,
              width: double.infinity,
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topCenter),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: showusers.length,
                        itemBuilder: (context, we) {
                          return GlassContainer.clearGlass(
                            color: const Color.fromARGB(55, 0, 0, 0),
                            height: 90,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            blur: 20,
                            borderColor: const Color.fromARGB(36, 0, 0, 0),
                            width: double.infinity,
                            child: ListTile(
                              subtitle: Text(
                                DateTime.now().toString().substring(0, 10),
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.white),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              enableFeedback: true,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const ChatPage();
                                  },
                                ));
                              },
                              title: Row(children: [
                                CircleAvatar(
                                  radius: 25,
                                  child: Text(
                                    snapshot.data!.docs[we]['name']
                                        .toString()
                                        .substring(0, 1),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(snapshot.data!.docs[we]['name'].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ]),
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
