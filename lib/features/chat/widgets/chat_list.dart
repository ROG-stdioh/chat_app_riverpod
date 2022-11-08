import 'package:chat_app_riverpod/common/widgets/loader.dart';
import 'package:chat_app_riverpod/features/chat/controller/chat_controller.dart';
import 'package:chat_app_riverpod/info.dart';
import 'package:chat_app_riverpod/models/message.dart';
import 'package:chat_app_riverpod/widgets/my_message_card.dart';
import 'package:chat_app_riverpod/widgets/sender_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({required this.recieverUserId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream:
          ref.read(chatControllerProvider).chatStream(widget.recieverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          messageController.jumpTo(messageController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final messageData = snapshot.data![index];
            var timeSent = DateFormat.Hm().format(messageData.timeSent);
            if (messageData.senderId ==
                FirebaseAuth.instance.currentUser!.uid) {
              // My Message Card
              return MyMessageCard(
                message: messageData.text,
                date: timeSent,
              );
            }
            // Senders Card
            return SenderMessageCard(
              message: messageData.text,
              date: timeSent,
            );
          },
        );
      },
    );
  }
}
