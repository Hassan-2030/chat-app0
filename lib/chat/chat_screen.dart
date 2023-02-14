import 'package:caht0/base.dart';
import 'package:caht0/chat/chat_viewmodel.dart';
import 'package:caht0/moudel/room.dart';
import 'package:caht0/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../moudel/massge.dart';

class CahtScreen extends StatefulWidget {
  static const String routName = 'chat';

  @override
  State<CahtScreen> createState() => _CahtScreenState();
}

class _CahtScreenState extends BaseView<CahtScreen, ChatViewModel>
    implements CahtNavigator {
  var massegeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<MyProvider>(context);

    viewModel.myUser = provider.myUser!;
    viewModel.room = room;

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(room.tittle),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 48),
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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Massege>>(
                    stream: viewModel.getMassege(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Some thing went wrong ");
                      }
                      var masseges =
                          snapshot.data?.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            return Text(masseges![index].content);
                          },
                          itemCount: masseges?.length ?? 0);
                    },
                  )),
                  Container(
                    padding: EdgeInsets.only(bottom: 6, left: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: massegeController,
                            decoration: InputDecoration(
                                hintText: "Taype a masseg",
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.sendMassege(massegeController.text);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "send",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  ChatViewModel initviewModel() => ChatViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  void uploadMassegeToFierstor() {
    massegeController.clear();
    setState(() {});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
