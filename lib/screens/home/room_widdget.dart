import 'package:flutter/material.dart';

import '../../chat/chat_screen.dart';
import '../../moudel/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator to chat screen
        Navigator.pushNamed(context, CahtScreen.routName, arguments: room);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "asset/images/${room.catId}.png",
                    width: MediaQuery.of(context).size.width * 30,
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(height: 10),
              Text(room.tittle)
            ],
          ),
        ),
      ),
    );
  }
}
