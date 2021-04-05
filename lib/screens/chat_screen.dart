import 'dart:io';

import 'package:buyonic/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:buyonic/widgets/chatting_widgets.dart';
import 'package:image_picker/image_picker.dart';


class ChattingScreen extends StatefulWidget {
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  String textValue = '';
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  bool showEmojiPicker = false;
  var _isLoading = false;
  String url;


  @override
  void initState() {
    getImageUrl();
    super.initState();
  }

  getImageUrl() async {
    User _user = FirebaseAuth.instance.currentUser;
    final _fireStore = FirebaseFirestore.instance;
    if(_user.photoURL == null){
      await _fireStore.collection('Buyonic').doc('Users')
          .collection('Email').doc(_user.uid).get()
          .then((snapshotData) => {
        setState(() => url = snapshotData.data()['profile_pic'])
      });

    }
  }


  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  emojiContainer() {
    return EmojiPicker(
      bgColor: Color(0xff272c35),
      indicatorColor: Color(0xff272c35),
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          textEditingController.text = textEditingController.text+ emoji.emoji;
          textValue = textValue + emoji.emoji;
        });
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
      body: _isLoading ? Center(
        child: showAlertDialog()
      ):  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GettingMessagesAndDisplaying(),
          Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.face), onPressed: () {
                      if (!showEmojiPicker) {
                        // keyboard is visible
                        hideKeyboard();
                        showEmojiContainer();
                      } else {
                        //keyboard is hidden
                        showKeyboard();
                        hideEmojiContainer();
                      }

                    }),
                    Expanded(
                      child: TextField(
                        focusNode: textFieldFocus,
                        controller: textEditingController,
                        onTap: (){
                          hideEmojiContainer();
                        },
                        onChanged: (val){
                          setState(() {
                            textValue = val;
                          });
                        },
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: "Type Something...",
                            border: InputBorder.none),
                      ),
                    ),
                    textValue.trim().isEmpty ?
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            getChatImage(source: ImageSource.camera);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: (){
                            getChatImage(source: ImageSource.gallery);
                          },
                        )
                      ],
                    ) : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (){
                        messageSent(text: textValue, imageUrl: url);
                        textEditingController.clear();
                        setState(() {
                          textValue = '';
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          showEmojiPicker ? Container(child: emojiContainer()) : Container(),
        ],
      )
    );
  }


  getChatImage({ImageSource source}) async {
    User _user = FirebaseAuth.instance.currentUser;
    File selectedImage;
    PickedFile image = await ImagePicker().getImage(
      source: source, imageQuality: 80,);
    if(image!=null){
      setState(() {
        _isLoading = true;
      });
      selectedImage = File(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child("ChatImages/${_user.uid}/${DateTime.now()}");
      UploadTask uploadTask = reference.putFile(selectedImage);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {
        print('Uploaded')
      });
      String uploadedPhotoUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        _isLoading = false;
      });
      final _fireStore = FirebaseFirestore.instance;

      await _fireStore.collection('Messages').doc(_user.uid)
          .collection('F8ZVqZXavnbNsfsTRrmFJo8Spl22').add({
        'ImageUrl':uploadedPhotoUrl,
        'SenderID': _user.uid,
        'Type': 'image',
        'DateTime': DateTime.now()
      }).then((value) => {
        _fireStore.collection('Messages').doc('F8ZVqZXavnbNsfsTRrmFJo8Spl22')
            .collection(_user.uid).add({
          'ImageUrl':uploadedPhotoUrl,
          'SenderID': _user.uid,
          'Type': 'image',
          'DateTime': DateTime.now()
        })
      });
      String displayName;
      String userEmail;
      String email;
      if(_user.displayName!=null && _user.displayName!= ""){
        displayName = _user.displayName;
      }else{
        userEmail = _user.email;
      }
      if(userEmail != null) {
        String splittingEmail = userEmail.substring(0, userEmail.indexOf('@'));
        email = splittingEmail[0].toUpperCase() + splittingEmail.substring(1);
      }
      await _fireStore.collection('Chats').doc('Data')
          .collection('F8ZVqZXavnbNsfsTRrmFJo8Spl22').doc(_user.uid)
          .set({
        'DisplayName': displayName == null ? email
            : displayName.substring(0, displayName.indexOf(' ')),
        'LastText': 'Image',
        'ImageUrl': _user.photoURL != null ? _user.photoURL : url,
        'DatTime': DateTime.now(),
        'SenderID': _user.uid,
        'Type': 'image'
      });
    }
  }

}
