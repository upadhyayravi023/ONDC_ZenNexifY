import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // For environment variables
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bazaar_to_go/repository/colors.dart';
import 'package:flutter/material.dart';
import 'package:bazaar_to_go/widgets/chatmsg.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final GenerativeModel model;
  TextEditingController chatText = TextEditingController();
  bool showIcon = false;
  String prompt = '';
  dynamic response; // Updated to make it nullable and safely initialized
  late final chat;
  final List<({String? image, String? text, bool isUser})> contentList = <({String? image, String? text, bool isUser})>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env["API_KEY"].toString(),
    );
    chat = model.startChat();
    chatText.addListener(() {
      setState(() {
        showIcon = chatText.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My AI Bot",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('kk:mm - d MMM').format(now);
                    return chat_ui(
                      isUser: contentList[index].isUser,
                      text: contentList[index].text,
                      time: formattedDate,
                      image: contentList[index].image,
                    );
                  },
                  itemCount: contentList.length,
                  controller: scrollController,
                ),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blueAccent,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    color: Colors.white,
                    onPressed: () {
                      sendImagePrompt(chatText.text);
                    },
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 13),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: "Write a message...",
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.white),
                          suffixIcon: showIcon
                              ? IconButton(
                            onPressed: () async {
                              await sendTextChat(chatText.text);
                              if (response != null && response.text != null) {
                                print(response.text);
                              } else {
                                print("Response is not ready.");
                              }
                            },
                            icon: const Icon(Icons.send, color: Colors.white),
                          )
                              : null,
                        ),
                        controller: chatText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendTextChat(String chat) async {
    contentList.add((image: null, text: chat, isUser: true));
    setState(() {
      contentList.add((image: null, text: "Gemini is typing!!!", isUser: false));
      chatText.clear();
      scrollDown();
    });
    try {
      final content = [Content.text(chat)];
      response = await model.generateContent(content);
      contentList.insert(contentList.length - 1, (image: null, text: response.text, isUser: false));
    } catch (e) {
      contentList.insert(contentList.length - 1, (image: null, text: "Error: Unable to process request.", isUser: false));
      print("Error generating content: $e");
    }
    setState(() {
      contentList.removeAt(contentList.length - 1);
      scrollDown();
    });
  }

  Future<void> sendImagePrompt(String chat) async {
    Uint8List byteData;
    ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      byteData = await pickedFile.readAsBytes();

      contentList.add((image: pickedFile.path, text: chat.isNotEmpty ? chat : "Describe the image.", isUser: true));
      setState(() {
        contentList.add((image: null, text: "Gemini is typing!!!", isUser: false));
        chatText.clear();
        scrollDown();
      });
      try {
        final content = [
          Content.multi([
            TextPart(chat.isNotEmpty ? chat : "Describe the image."),
            DataPart("image/*", byteData),
          ]),
        ];

        response = await model.generateContent(content);
        contentList.insert(contentList.length - 1, (image: null, text: response.text, isUser: false));
      } catch (e) {
        contentList.insert(contentList.length - 1, (image: null, text: "Error: Unable to process image.", isUser: false));
        print("Error generating content: $e");
      }
      setState(() {
        contentList.removeAt(contentList.length - 1);
        scrollDown();
      });
    }
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }
}
