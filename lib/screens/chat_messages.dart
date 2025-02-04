import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Chat_msg')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
                strokeWidth: 3,
              ),
            );
          }

          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Messages yet!!"),
            );
          }

          if (chatSnapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          final loadedMsg = chatSnapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),
            itemCount: loadedMsg.length,
            reverse: true,
            itemBuilder: (ctx, idx) {
              final messageData = loadedMsg[idx].data() as Map<String, dynamic>;

              // Determine if the message is sent by the current user
              bool isMe = messageData['userId'] == userId;

              // Check if the previous message is from the same user
              bool isFirstInSequence = idx == 0 ||
                  (loadedMsg[idx - 1].data()
                          as Map<String, dynamic>)['userId'] !=
                      messageData['userId'];

              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isMe &&
                        isFirstInSequence) // Show avatar only for received messages and first in sequence
                      CircleAvatar(
                        backgroundColor:
                            Colors.purple, // Background color for avatar
                        child: Text(
                          messageData['userName'] != null &&
                                  messageData['userName'].isNotEmpty
                              ? messageData['userName'][0]
                                  .toUpperCase() // First letter of username
                              : '?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    SizedBox(width: 8), // Space between avatar and message
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 22, top: 5, bottom: 5),
                      margin: EdgeInsets.only(
                          left: isMe ? 50 : 5, right: isMe ? 5 : 50),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.purple[100]
                            : Colors.grey[300], // Set background color
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: isMe ? Radius.circular(10) : Radius.zero,
                          bottomRight: isMe ? Radius.zero : Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messageData['text'] ?? 'No message',
                            style: TextStyle(
                              fontFamily: 'Roboto', // Use custom font
                              color:
                                  isMe ? Colors.purple.shade900 : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            messageData['createdAt'] != null
                                ? (messageData['createdAt'] as Timestamp)
                                    .toDate()
                                    .toLocal()
                                    .toString()
                                    .split(' ')[1]
                                    .substring(0, 5) // Format the timestamp
                                : '',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isMe &&
                        isFirstInSequence) // Show avatar only for sent messages and first in sequence
                      CircleAvatar(
                        backgroundColor:
                            Colors.purple, // Background color for avatar
                        child: Text(
                          messageData['userName'] != null &&
                                  messageData['userName'].isNotEmpty
                              ? messageData['userName'][0]
                                  .toUpperCase() // First letter of username
                              : '?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
