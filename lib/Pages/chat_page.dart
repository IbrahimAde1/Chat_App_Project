import 'package:chat_app/Pages/login_page.dart';
import 'package:chat_app/Pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../model/massage_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

CollectionReference massages =
    FirebaseFirestore.instance.collection('massages');
final controllero = ScrollController();
String? name;
bool chack = false;
bool chack2 = true;

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: massages.orderBy('created', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Massage> massagesRead = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massagesRead.add(Massage.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: Color.fromARGB(253, 255, 255, 255),
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(40, 255, 255, 255),
              centerTitle: false,
              titleSpacing: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        name ?? 'welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.videocam,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      PopupMenuButton(itemBuilder: (context) {
                        return List.empty();
                      }),
                    ],
                  )
                ],
              ),
            ),
            body: GlassContainer.clearGlass(
              borderColor: const Color.fromARGB(132, 0, 0, 0),
              height: double.infinity,
              width: double.infinity,
              color: const Color.fromARGB(197, 255, 255, 255),
              gradient: const LinearGradient(colors: [
                Colors.white,
                Colors.lightBlue,
                Colors.purple,
                Colors.blue,
              ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
              blur: 50,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: controllero,
                        itemCount: massagesRead.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          if (massagesRead[index].email == emailAddress) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BubbleSpecialOne(
                                  //   delivered: massagesRead[index].isSender,

                                  seen: massagesRead[index].isSender,
                                  text: massagesRead[index].massages.toString(),
                                  tail: true,
                                  color: const Color.fromARGB(88, 0, 0, 0),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            name = massagesRead[index].usernam.toString();
                            return BubbleSpecialOne(
                              text: massagesRead[index].massages.toString(),
                              isSender: false,
                              color: const Color.fromARGB(36, 0, 0, 0),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ),
                  MessageBar(
                    sendButtonColor: Colors.grey,
                    messageBarColor: const Color.fromARGB(120, 2, 2, 2),
                    onSend: (value) {
                      massages.add({
                        'masage': value,
                        'seen': true,
                        'falsesend': false,
                        'created': DateTime.now(),
                        'email': emailAddress,
                        'nameSender': username ?? 'User',
                      });
                      print(name);
                      controllero.animateTo(
                          controllero.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return GlassContainer.clearGlass(
            height: double.infinity,
            width: double.infinity,
            borderColor: Colors.transparent,
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter),
            child: const Scaffold(
              backgroundColor: Color.fromARGB(131, 255, 255, 255),
              body: ModalProgressHUD(
                inAsyncCall: true,
                blur: 20,
                child: Text('loading ....'),
              ),
            ),
          );
        }
      },
    );
  }
}
