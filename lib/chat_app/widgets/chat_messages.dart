import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_web/chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(36.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('chats/${currentUser.uid}/history')
              .orderBy('createdAt', descending: false)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData == false || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No message found...'),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong..!'),
              );
            }

            final messages = snapshot.data!.docs;

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, idx) => MessageBubble.next(isMe: true, message: messages[idx].data()['text']),
            );
          },
        ));
  }
}
