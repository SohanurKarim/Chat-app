import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn_14/widgets/chat/messages.dart';
import 'package:firebase_learn_14/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        centerTitle: true,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/rkvDaxJTk8ROKQWuJC3c/messages')
      //       .snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = snapshot.data!.docs;
      //     // final documents =snapshot.requireData;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: const EdgeInsets.all(8),
      //         child: Text(documents[index]["text"]), //docs[index]["text"]
      //       ),
      //     );
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/rkvDaxJTk8ROKQWuJC3c/messages')
      //         .add({'text': 'this new text'});
      //
      //     // FirebaseFirestore.instance
      //     //     .collection('chats/rkvDaxJTk8ROKQWuJC3c/messages')
      //     //     .snapshots()
      //     //     .listen((data) {
      //     //process 1
      //     // print(data.docs[0]['text']);
      //
      //     //process 2
      //     //     data.docs.forEach((document) {
      //     //       print(document['text']);
      //     //     });
      //     //    });
      //   },
      // ),
    );
  }
}
