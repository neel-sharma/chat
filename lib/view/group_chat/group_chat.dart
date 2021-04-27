/*
Navigating all authorized personnel to a single group chat.
*/

import 'package:chat/model/message.dart';
import 'package:chat/controller/navigation/shortcuts.dart';
import 'package:chat/model/user_id.dart';
import 'package:chat/model/services/database.dart';
import 'package:chat/view/group_chat/style.dart';
import 'package:chat/view/group_chat/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChat extends StatefulWidget {
  final String? accountName;
  GroupChat(this.accountName);

  @override
  _GroupChatState createState() => _GroupChatState(accountName: accountName);
}

class _GroupChatState extends State<GroupChat> {
  String? accountName;

  _GroupChatState({this.accountName});

  List<Message> messages = [];
  int messageCount = 0;
  Stream? messageStream;

  getMessages() async {
    messageStream = await DatabaseService().getMessages();
    setState(() {});
  }

  @override
  void initState() {
    getMessages();
    super.initState();
  }

  Widget displayMessages(BuildContext context) {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot message = snapshot.data!.docs[index];
                  return ChatBubble(
                    id: message['id'],
                    accountName: message['accountName'],
                    text: message['text'],
                    time: message['time'],
                  );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID?>(context);
    TextEditingController textController = TextEditingController();
    textController.text = '';
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Group Chat',
          style: chatTitleText(context),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "settings",
            icon: Icon(Icons.settings, size: 25),
            color: Theme.of(context).accentColor,
            onPressed: () {
              goToSettings(context);
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
      ),
      body: Container(
        height: 1000,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(child: displayMessages(context)),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).accentColor.withOpacity(0.2),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 2, 15, 3),
                          child: TextFormField(
                            controller: textController,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String time = DateTime.now().toString();
                        await DatabaseService(uid: user?.id).uploadMessage(
                          user?.id,
                          accountName,
                          textController.text,
                          time,
                        );
                        setState(() {
                          textController.clear();
                        });
                      },
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
