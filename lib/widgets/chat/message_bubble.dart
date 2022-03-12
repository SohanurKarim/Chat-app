import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
//  const MessageBubble({Key? key}) : super(key: key);
  const MessageBubble(
      this.message,
      this.userName,
      this.userImage,
      this.isMe,
      {required this.key});

  final Key key;
  final String userName;
  final String message;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(12),
                  bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //   future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
                  //   builder: (context,snapshot) {
                  //     if(snapshot.connectionState == ConnectionState.waiting)
                  //       {
                  //         return const Text('Loading...');
                  //       }
                  //     return Text(
                  //       snapshot.data,
                  //       style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),);
                  //   }
                  // ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.subtitle1!.color,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: isMe? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.subtitle1!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
         Positioned(
          top: 0,
          left: isMe ? null: 120,
          right: isMe ? 120:null,
          child:  CircleAvatar(
          backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    //  clipBehavior: Clip.none,
    );
  }
}
