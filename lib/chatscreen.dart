import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {

  TextEditingController _inputMessageController = new TextEditingController();

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
   // allPerson();
    socket = IO.io('http://192.168.1.37:3000');
    IO.OptionBuilder().setTransports(['websocket'])
        .disableAutoConnect().build();
    socket.connect();
    setUpSocketListner();
  }

  setUpSocketListner(){
    print('lisn');
socket.on('msg-recv',(data){
  print(data);
});

  }


  final Message =TextEditingController();


  bool imageshow=false;

late IO.Socket socket;



  sendmsg(){



    var arr={
      'id':socket.id,
      'mag':Message.text,
    };

socket.emit('msg',arr);
    print('send');
    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));


  }








  @override
  Widget build(BuildContext context) {
    _scrollToBottom();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Amarjeet kushwaha",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            chatSpaceWidget(),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.blueGrey,
            ),
            bottomChatView()
          ],
        ),
      ),
    );
  }

  Widget chatSpaceWidget() {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          sendmsg();
        }, child: Text('Send'))
      ],
    );
  }

  Widget bottomChatView() {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      height: 60,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: Message,
              onSubmitted: (String str) {
              //  Savedata();
              },
              decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              sendmsg();
            //  Savedata();
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
            backgroundColor: Colors.blue,
            elevation: 0,
          ),
        ],
      ),
    );
  }

  _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }


}
