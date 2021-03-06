import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlychatApp());
}
const String _name = "Gathua Kiragu";

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendly chat app",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textEditingController =
      new TextEditingController();

//  Widget build(BuildContext context) {
//// TODO: implement build
//    return new Scaffold(
//      appBar: new AppBar(title: new Text("Friendlychat")),
//      body: _buildTextComposer(),
//    );
//  }


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendlychat")),
      body: new Column(                                        //modified
        children: <Widget>[                                         //new
          new Flexible(                                             //new
            child: new ListView.builder(                            //new
              padding: new EdgeInsets.all(8.0),                     //new
              reverse: true,                                        //new
              itemBuilder: (_, int index) => _messages[index],      //new
              itemCount: _messages.length,                          //new
            ),                                                      //new
          ),                                                        //new
          new Divider(height: 1.0),                                 //new
          new Container(                                            //new
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),                                                        //new
        ],                                                          //new
      ),                                                            //new
    );
  }




  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: new Container(margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(

                controller: _textEditingController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send a message"),
              ),
            ),
            new Container(margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textEditingController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    ChatMessage message = new ChatMessage(                         //new
      text: text,
      animationController: new AnimationController(
          duration: new Duration(milliseconds: 700), vsync: this), //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    });
    message.animationController.forward();
  }


//  Disposing animation when no longer needed
  @override
  void dispose() {                                                   //new
    for (ChatMessage message in _messages)                           //new
      message.animationController.dispose();                         //new
    super.dispose();                                                 //new
  }
}


class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
        )
    );
  }
}