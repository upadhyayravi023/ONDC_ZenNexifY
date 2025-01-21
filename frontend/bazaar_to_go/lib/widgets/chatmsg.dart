import 'dart:io';

import 'package:flutter/material.dart';

class chat_ui extends StatefulWidget {
  final image;
  final isUser;
  final text;
  final time;

  const chat_ui(
      {super.key,
        this.image,
        required this.isUser,
        required this.text,
        required this.time});

  @override
  State<chat_ui> createState() => _chat_uiState();
}

class _chat_uiState extends State<chat_ui> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: widget.isUser ? TextDirection.rtl : TextDirection.ltr,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(widget.isUser
              ? "assets/images/ondc.png"
              : "assets/images/ondc.png"),
        ),
        SizedBox(
          height: 4,
        ),
        if (widget.image != null) ...[
          Container(
            child: Image.file(
              File(widget.image),
              fit: BoxFit.cover,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.5,
              maxHeight: MediaQuery.of(context).size.width/1.5,
            ),
            decoration: BoxDecoration(
              color: widget.isUser ? Colors.blue[100] : Colors.green[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
          )
        ],
        Container(
          child: Text(
            widget.text,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.5,
          ),
          decoration: BoxDecoration(
            color: widget.isUser ? Colors.blue[100] : Colors.green[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(10),
        ),
        Text(
          widget.time,
          style: TextStyle(fontSize: 10),
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}