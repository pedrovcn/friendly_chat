import 'package:chat_app/theme/themes.dart';
import 'package:chat_app/widget/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "FriendlyChat",
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        home: ChatScreen(),
        debugShowCheckedModeBanner: false);
  }
}
