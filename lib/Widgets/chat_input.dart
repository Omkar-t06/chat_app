import 'package:chatting_app/Models/chat_msg_entities.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({super.key, required this.onSubmit});

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() {
    print('ChatMessage: ${chatMessageController.text}');
    //TODO: Add this new message to the default list

    final newChatMessage = ChatMessageEntity(
      text: chatMessageController.text,
      id: "244",
      createdAt: DateTime.now().millisecondsSinceEpoch,
      author: Author(userName: 'poojab26'),
    );

    onSubmit(newChatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            controller: chatMessageController,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                hintText: "Type your message",
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: InputBorder.none),
          )),
          IconButton(
            onPressed: onSendButtonPressed,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
