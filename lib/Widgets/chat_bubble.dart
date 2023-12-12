import 'package:chatting_app/Models/chat_msg_entities.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;
  const ChatBubble({
    super.key,
    required this.alignment,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(50),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            if (entity.imageUrl != null)
              Image.network(
                entity.imageUrl!,
                height: 200,
              )
          ],
        ),
      ),
    );
  }
}
