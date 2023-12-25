import 'package:chatting_app/Models/chat_msg_entities.dart';
import 'package:chatting_app/Widgets/picker_body.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  const ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _selecedImageUrl = "";

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() {
    final newChatMessage = ChatMessageEntity(
      text: chatMessageController.text,
      id: "244",
      createdAt: DateTime.now().millisecondsSinceEpoch,
      author: Author(userName: 'poojab26'),
    );

    if (_selecedImageUrl.isNotEmpty) {
      newChatMessage.imageUrl = _selecedImageUrl;
    }

    widget.onSubmit(newChatMessage);

    chatMessageController.clear();
    setState(() {
      _selecedImageUrl = "";
    });
  }

  void onImageSelected(String url) {
    setState(() {
      _selecedImageUrl = url;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NetworkImagePickerBody(
                      onImageSelected: onImageSelected,
                    );
                  });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TextField(
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
                ),
                if (_selecedImageUrl.isNotEmpty)
                  Image.network(_selecedImageUrl),
              ],
            ),
          ),
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
