import 'package:chat_app/Pages/cubit/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../model/massage_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';
  @override
  State<ChatPage> createState() => _ChatPageState();
}

CollectionReference massages =
    FirebaseFirestore.instance.collection('massages');
final controllero = ScrollController();

bool chack = false;
bool chack2 = true;

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    String? emailAddress = BlocProvider.of<LoginCubit>(context).emailAddress;
    return StreamBuilder<QuerySnapshot>(
      stream: massages.orderBy('created', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Massage> massagesRead = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massagesRead.add(Massage.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(78, 250, 250, 250),
              centerTitle: false,
              titleSpacing: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(37, 249, 248, 248),
                          radius: 20,
                          child: Center(
                            child: Text(
                              name.characters.first,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.videocam,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      PopupMenuButton(
                          color: Colors.white,
                          itemBuilder: (context) {
                            return List.empty();
                          }),
                    ],
                  )
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Chat.jpg'), fit: BoxFit.cover)),
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
                    messageBarColor: const Color.fromARGB(31, 255, 255, 255),
                    onSend: (value) {
                      massages.add({
                        'masage': value,
                        'seen': true,
                        'falsesend': false,
                        'created': DateTime.now(),
                        'email': emailAddress,
                        'nameSender': 'name',
                      });

                      controllero.animateTo(
                          controllero.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    actions: [
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
          return const Scaffold(
            backgroundColor: Colors.transparent,
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
