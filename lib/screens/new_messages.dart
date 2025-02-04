import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final TextEditingController _messageController = TextEditingController();
  bool _isload = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    setState(() {
      _isload = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle user not logged in
        return;
      }

      FocusScope.of(context).unfocus();
      _messageController.clear();

      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      await FirebaseFirestore.instance.collection('Chat_msg').add({
        'text': enteredMessage,
        'createdAt': DateTime.now(),
        'userId': user.uid,
        'userName': userData.data()?['userName'],
        'userImage': userData.data()?['imgUrl'],
      });


    } catch (error) {
      print('Error sending message: $error');
    } finally {
      setState(() {
        _isload = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Send a message",
              ),
              autocorrect: true,
              enableSuggestions: true,
            ),
          ),
          IconButton(
            onPressed: _isload ? null : _submitMessage,
            color: Colors.purple,
            icon: _isload
                ? SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                      strokeWidth: 3,
                    ))
                : Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
