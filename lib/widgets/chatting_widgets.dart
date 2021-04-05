import 'package:buyonic/screens/image_display_screen.dart';
import 'package:buyonic/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Widget appBarWidget(){
  return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),

      title: Text('Admin', style: TextStyle(
          color: Colors.black,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          fontSize: 22
      ),),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0))
  );
}

// class InputField extends StatefulWidget {
//   @override
//   _InputFieldState createState() => _InputFieldState();
// }
//
// class _InputFieldState extends State<InputField> {
//   String textValue = '';
//   TextEditingController textEditingController = TextEditingController();
//   FocusNode textFieldFocus = FocusNode();
//   bool showEmojiPicker = false;
//   bool isWriting = false;
//
//   hideEmojiContainer() {
//     setState(() {
//       showEmojiPicker = false;
//     });
//   }
//
//   showEmojiContainer() {
//     setState(() {
//       showEmojiPicker = true;
//     });
//   }
//
//   showKeyboard() => textFieldFocus.requestFocus();
//
//   hideKeyboard() => textFieldFocus.unfocus();
//
//   Widget chatControls() {
//     setWritingTo(bool val) {
//       setState(() {
//         isWriting = val;
//       });
//     }
//   }
//
//   emojiContainer() {
//     return EmojiPicker(
//       bgColor: Colors.black,
//       indicatorColor: Colors.blue,
//       rows: 3,
//       columns: 7,
//       onEmojiSelected: (emoji, category) {
//         setState(() {
//           isWriting = true;
//         });
//
//         textEditingController.text = textEditingController.text+ emoji.emoji;
//       },
//       recommendKeywords: ["face", "happy", "party", "sad"],
//       numRecommended: 50,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(35.0),
//                 boxShadow: [
//                   BoxShadow(
//                       offset: Offset(0, 3),
//                       blurRadius: 5,
//                       color: Colors.grey)
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                       icon: Icon(Icons.face), onPressed: () {
//                     if (!showEmojiPicker) {
//                       // keyboard is visible
//                       hideKeyboard();
//                       showEmojiContainer();
//                     } else {
//                       //keyboard is hidden
//                       showKeyboard();
//                       hideEmojiContainer();
//                     }
//
//                   }),
//                   Expanded(
//                     child: TextField(
//                       focusNode: textFieldFocus,
//                       controller: textEditingController,
//                       onChanged: (val){
//                         setState(() {
//                           textValue = val;
//                         });
//                       },
//                       maxLines: null,
//                       decoration: InputDecoration(
//                           hintText: "Type Something...",
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   textValue.trim().isEmpty ?
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.photo_camera),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.attach_file),
//                         onPressed: () {},
//                       )
//                     ],
//                   ) : IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: (){
//                       messageSent(text: textValue);
//                       textEditingController.clear();
//                       setState(() {
//                         textValue = '';
//                       });
//                     },
//                   )
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class GettingMessagesAndDisplaying extends StatefulWidget {

  @override
  _GettingMessagesAndDisplayingState createState() => _GettingMessagesAndDisplayingState();
}

class _GettingMessagesAndDisplayingState extends State<GettingMessagesAndDisplaying> {
  final _fireStore = FirebaseFirestore.instance;

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('Messages').doc(_user.uid)
          .collection('F8ZVqZXavnbNsfsTRrmFJo8Spl22').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageListData = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final snapshotData = snapshot.data.docs;
        for (var message in snapshotData) {
          final type = message.get('Type');
          final messageText = type == 'text' ? message.get('Text')
              : message.get('ImageUrl');
          final messageSender = message.get('SenderID');
          final messageTime = message.get('DateTime');
          
          DateTime dateTime = message.get('DateTime').toDate();
          String formattedTime = DateFormat.jm().format(dateTime);
          final currentUser = _user.uid;
          bool value = currentUser == messageSender;
          final messageData =
          MessageBubble(text: messageText, sender: messageSender,isMe: value,
            time: messageTime, formattedTime: formattedTime, type: type);
          messageListData.add(messageData);
          messageListData.sort((a , b) => b.time.compareTo(a.time));
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListView(
              reverse: true,
              children: messageListData,
            ),
          ),
        );
      },
    );
  }
}



class MessageBubble extends StatefulWidget {
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time;
  final String formattedTime;
  final String type;

  MessageBubble({this.text, this.sender, this.isMe,this.time,
    this.formattedTime, this.type});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  var url;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
            crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.type == 'text' ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      borderRadius: widget.isMe? BorderRadius.only(topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)):
                      BorderRadius.only(topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      elevation: 3,
                      color: widget.isMe ? Colors.lightBlueAccent : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          '${widget.text}',
                          style: TextStyle(fontSize: 16,
                              color: widget.isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ) : GestureDetector(
                    child: Hero(
                      tag: widget.text,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CachedImage(
                          widget.text,
                          height: 250,
                          width: 250,
                          radius: 10,
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ImageDisplayScreen(imageUrl: widget.text,);
                      }));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 3 ),
                    child: Text(widget.formattedTime,
                      style: TextStyle(
                        fontSize: 11,
                      ),),
                  )
                ],

              ),
            ],
          ),
    );
  }
}

Widget showAlertDialog(){
  return AlertDialog(
    title: Text('Please Wait', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Raleway'),),
  );
}
