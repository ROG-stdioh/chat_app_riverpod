import 'package:chat_app_riverpod/colors.dart';
import 'package:chat_app_riverpod/common/widgets/loader.dart';
import 'package:chat_app_riverpod/features/auth/controller/auth_controller.dart';
import 'package:chat_app_riverpod/features/chat/widgets/bottom_chat_field.dart';
import 'package:chat_app_riverpod/models/user_model.dart';
import 'package:chat_app_riverpod/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return Column(
              children: [
                Text(name),
                Text(
                  snapshot.data!.isOnline ? 'online' : 'offline',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            );
          },
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        //chat list
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: uid,
            ),
          ),
          BottomChatField(
            recieverUserId: uid,
          )
        ],

        //text input
      ),
    );
  }
}
