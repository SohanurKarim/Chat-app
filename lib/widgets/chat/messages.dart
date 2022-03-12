import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn_14/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder:(ctx, AsyncSnapshot<User> futureSnapshot){
        if(futureSnapshot.connectionState == ConnectionState.waiting)
        {
          return const Center(child:CircularProgressIndicator() ,);
        }
      return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) =>
                MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['username'],
                    chatDocs[index]['userImage'],
                    chatDocs[index]['userId'] == futureSnapshot.data!.uid,
                    key: ValueKey(chatDocs[index].id),
                ),
            //Text(chatDocs[index]['text']),
          );
          }
        );
      },
    );
  }
}
