import 'package:chat_app/widget/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("FriendlyChat"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
        body: Container(
            child: Column(children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length)),
              Divider(height: 1.0),
              Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer())
            ]),
            decoration: Theme.of(context).platform == TargetPlatform.iOS
                ? new BoxDecoration(
                    border: new Border(
                      top: new BorderSide(color: Colors.grey[200]),
                    ),
                  )
                : null));
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(children: <Widget>[
              Flexible(
                  child: TextField(
                      controller: _textEditingController,
                      onChanged: (String text) {
                        setState(() {
                          _isComposing = text.length > 0;
                        });
                      },
                      onSubmitted: _handleSubmit,
                      decoration: InputDecoration.collapsed(
                          hintText: "Envie uma mensagem"))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Send"),
                          onPressed: _isComposing
                              ? () => _handleSubmit(_textEditingController.text)
                              : null,
                        )
                      : //new
                      new IconButton(
                          //modified
                          icon: new Icon(Icons.send),
                          onPressed: _isComposing
                              ? () => _handleSubmit(_textEditingController.text)
                              : null,
                        ))
            ])));
  }

  void _handleSubmit(String text) {
    _textEditingController.clear();

    setState(() {
      _isComposing = false;
    });

    ChatMessage message = ChatMessage(
        text: text,
        animationController: AnimationController(
            duration: Duration(milliseconds: 700), vsync: this));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }
}
