import 'package:caht0/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:caht0/moudel/massge.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Massege massege;

  MessageWidget(this.massege);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.myUser!.id == massege.senderId
        ? SenderMessage(massege)
        : RecviedMessage(massege);
  }
}

class SenderMessage extends StatelessWidget {
  Massege massege;

  SenderMessage(this.massege);

  @override
  Widget build(BuildContext context) {
    int ts = massege.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat('mm/dd/yyyy , hh:mm a').format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Text(
                massege.content,
                style: TextStyle(color: Colors.white),
              )),
          Text(date.substring(12), style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}

class RecviedMessage extends StatelessWidget {
  Massege massege;

  RecviedMessage(this.massege);

  @override
  Widget build(BuildContext context) {
    int ts = massege.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat('mm/dd/yyyy , hh:mm a').format(dt);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              child: Text(massege.content)),
          Text(date.substring(12))
        ],
      ),
    );
  }
}
