import 'package:bubble/bubble.dart';
import 'package:chat/model/user_id.dart';

import 'package:chat/view/group_chat/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String? id, accountName, text, time;

  ChatBubble({this.id, this.accountName, this.text, this.time});

  @override
  Widget build(BuildContext context) {
    String? displayHour12, displayHour24, amPm = 'AM', displayTime;
    displayHour24 = time!.substring(8, 10);
    displayHour12 = displayHour24;
    if (int.parse(displayHour24) >= 12) {
      displayHour12 = (int.parse(displayHour24) - 12).toString();
      amPm = 'PM';
    }
    displayTime = displayHour12 + ":" + time!.substring(10, 12);

    bool isOwner = false;
    final user = Provider.of<UserID?>(context);
    if (user!.id == id) {
      isOwner = true;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Bubble(
            style: BubbleStyle(
              elevation: 0,
              nip: isOwner ? BubbleNip.rightTop : BubbleNip.leftTop,
              color: bubbleColor(context),
            ),
            child: isOwner
                ? ownerBubble(context, displayTime, amPm)
                : otherBubble(context, displayTime, amPm),
          ),
        ],
      ),
    );
  }

  Widget ownerBubble(BuildContext context, String? displayTime, String? amPm) {
    double bubbleWidth = 25;
    if (text!.length <= 10) {
      bubbleWidth = 75;
    } else if (text!.length >= 10 && text!.length <= 21) {
      bubbleWidth = 150;
    } else {
      bubbleWidth = 200;
    }
    return Container(
      constraints: BoxConstraints(maxWidth: bubbleWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: bubbleText(context),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              '$displayTime $amPm',
              style: bubbleTimeText(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherBubble(BuildContext context, String? displayTime, String? amPm) {
    double bubbleWidth = 25;
    if (text!.length <= 10) {
      bubbleWidth = 100;
    } else if (text!.length >= 10 && text!.length <= 21) {
      bubbleWidth = 150;
    } else {
      bubbleWidth = 200;
    }
    return Container(
      constraints: BoxConstraints(maxWidth: bubbleWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$accountName',
            style: bubbleNameText(context),
          ),
          Text(
            '$text',
            style: bubbleText(context),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              '$displayTime $amPm',
              style: bubbleTimeText(context),
            ),
          ),
        ],
      ),
    );
  }
}
