import 'package:chat_app2/constants.dart';
import 'package:chat_app2/models/message_model.dart';
import 'package:chat_app2/pages/login_page.dart';
import 'package:chat_app2/widgets/custom_scroll_down_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController textController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  bool _showScrollDownBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll > 100) {
          if (!_showScrollDownBtn) {
            setState(() {
              _showScrollDownBtn = true;
            });
          }
        } else {
          if (_showScrollDownBtn) {
            setState(() {
              _showScrollDownBtn = false;
            });
          }
        }
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _submitData(String email, String username) {
    String input = textController.text.trim();
    String value = textController.text;

    if (input.isNotEmpty) {
      db.collection(kMessagesCollection).add(
        {
          kMessage: value,
          kCreatedAt: Timestamp.now(),
          kMessageId: email,
          kUsername: username,
        },
      );
      textController.clear();
      _scrollDown();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String email = args['email'];
    String username = args['username'];
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection(kMessagesCollection)
          .orderBy(kCreatedAt, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 55,
                  ),
                  const Text(
                    " Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () async {
                    //*initialize navigator with build context before using wait to avoid across async gaps
                    final navigator = Navigator.of(context);
                    await FirebaseAuth.instance.signOut();
                    navigator.pushNamedAndRemoveUntil(
                      LoginPage.id,
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  tooltip: "log out",
                ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      //wrap listview.builder with expanded to specify its height in column, as column need to know a definite height
                      child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index].id == email
                                ? SenderChatBubble(
                                    message: messagesList[index],
                                  )
                                : RecieverChatBubble(
                                    message: messagesList[index],
                                  );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SafeArea(
                        child: TextField(
                          controller: textController,
                          onSubmitted: (value) {
                            _submitData(email, username);
                          },
                          decoration: InputDecoration(
                            suffixIcon: textController.text.trim().isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _submitData(email, username);
                                    },
                                    tooltip: "send",
                                    icon: Icon(
                                      Icons.send,
                                      color: kPrimaryColor,
                                    ),
                                  )
                                : null,
                            hintText: "Type a Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                )),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 120,
                  right: 16,
                  child: CustomScrollDownBtn(
                      onPressed: _scrollDown, isVisible: _showScrollDownBtn),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
