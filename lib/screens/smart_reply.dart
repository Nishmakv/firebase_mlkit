import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class SmartReplyScreen extends StatefulWidget {
  const SmartReplyScreen({super.key});

  @override
  State<SmartReplyScreen> createState() => SmartReplyScreenState();
}

class SmartReplyScreenState extends State<SmartReplyScreen> {
  List reply = [];
  bool isPressed1 = true;

  final _control = TextEditingController();
  String result1 = "";

  Future getsmartreply(String msg) async {
    result1 = "";
    reply = [];

    final SmartReply smartreply = SmartReply();
    smartreply.addMessageToConversationFromLocalUser(
        msg, DateTime.now().microsecondsSinceEpoch);
    final response = await smartreply.suggestReplies();
    for (final suggestReplies in response.suggestions) {
      String text = suggestReplies;
      reply.add(text);

      result1 += "| $text |";
    }
    setState(() {});

    smartreply.close();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Smart Reply',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _control,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Type here',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Button(
                onButtonTap: () async {
                  getsmartreply(_control.text);
                },
                text: 'Smart Reply',
                isPress: isPressed1,
                  isIcon: false,
              ),
              const SizedBox(height: 25),
              const SizedBox(width: 20),
              SizedBox(
                width: 300,
                height: 80,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: reply.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 90,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.blue,
                              ),
                              ),
                              child: Center(
                                child: Text(
                                  "${reply[index]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
