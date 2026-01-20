
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thisismeapp/components/chat_bubble.dart';
import 'package:thisismeapp/components/textfield.dart';
import 'package:thisismeapp/services/auth/auth_service.dart';
import 'package:thisismeapp/services/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

//text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something in text field
    if (_messageController.text.isNotEmpty) {
      //SEND MESSAGE
      await _chatService.sendMessage(receiverID, _messageController.text);
      //clear controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessagesList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        //return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //messagealignment
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(isCurrentUser: isCurrentUser, message: data["message"]),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
                controller: _messageController,
                hintText: "Type A Message",
                obscureText: false),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.orange.shade800,
            shape: BoxShape.circle),
            margin: const EdgeInsets.only(right:25),
            child: IconButton(
                onPressed: sendMessage, icon:  const Icon(Icons.arrow_forward, color:Colors.black)),
          ),
        ],
      ),
    );
  }
}
