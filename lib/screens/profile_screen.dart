import 'dart:io';

import 'package:buyonic/firebase_services/profile.dart';
import 'package:buyonic/screens/login_screen.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/clippath_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User _user;
  Object profileData;
  String dob;
  String address;
  String phone;
  String socialAccount;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  DateTime dateTime;
  String photoUrl;
  bool isLoading = false;
  bool isEmailLoading = false;
  bool isEmailAccount = false;
  File _selectedFile;

  Future<DocumentSnapshot> loadProfileData() async {
    _user =  FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Buyonic')
        .doc('Users')
        .collection('Google')
        .doc(_user.uid)
        .get();

    if (documentSnapshot.data() != null) {
      dob = documentSnapshot.get('DOB');
      address = documentSnapshot.get('Address');
      phone = documentSnapshot.get('Phone');
      socialAccount = documentSnapshot.get('type');
      print('Social: $socialAccount');

      _addressController = TextEditingController(
          text: address == 'Not set' ? "" : address.toString());
      _phoneController = TextEditingController(
          text: phone == 'Not set' ? "" : phone.toString());
      return documentSnapshot;
    }

    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection('Buyonic')
        .doc('Users')
        .collection('Facebook')
        .doc(_user.uid)
        .get();

    if (documentSnapshot2.data() != null) {
      dob = documentSnapshot2.get('DOB');
      address = documentSnapshot2.get('Address');
      phone = documentSnapshot2.get('Phone');
      socialAccount = documentSnapshot2.get('type');
      print('Social: $socialAccount');
      _addressController = TextEditingController(
          text: address == 'Not set' ? "" : address.toString());
      _phoneController = TextEditingController(
          text: phone == 'Not set' ? "" : phone.toString());
      return documentSnapshot2;
    }

    DocumentSnapshot documentSnapshot3 = await FirebaseFirestore.instance
        .collection('Buyonic')
        .doc('Users')
        .collection('Email')
        .doc(_user.uid)
        .get();

    if (documentSnapshot3.data() != null) {
      dob = documentSnapshot3.get('DOB');
      address = documentSnapshot3.get('Address');
      phone = documentSnapshot3.get('Phone');
      socialAccount = documentSnapshot3.get('type');
      photoUrl = documentSnapshot3.get('profile_pic');
      isEmailAccount = true;

      print('Social: $socialAccount');

      _addressController = TextEditingController(
          text: address == 'Not set' ? "" : address.toString());
      _phoneController = TextEditingController(
          text: phone == 'Not set' ? "" : phone.toString());

      return documentSnapshot3;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: _logout)
        ],
      ),
      body: isEmailLoading == true ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wait!',style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            Text('Uploading your Picture',style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
            ),),
          ],
        ),
      ) :
      FutureBuilder(
        future: loadProfileData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: SpinKitFadingCircle(color: Colors.deepOrange));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                if (socialAccount != 'Email')
                  Stack(
                    children: [
                      ClipPathDesign(),
                      isLoading==true ? SpinKitFadingCircle(color: Colors.white,) :
                      stackProfileInfo(
                          imageUrl: _user.photoURL,
                          email: _user.email ?? '',
                          displayName: _user.displayName,
                      )
                    ],
                  )
                else
                  Stack(
                    children: [
                      ClipPathDesign(),
                      isLoading==true ? SpinKitFadingCircle(color: Colors.white,) :
                      stackProfileInfo(
                          imageUrl: photoUrl,
                          isEmail: true,
                          context: context,
                          onTap:() {
                             getImage(source: ImageSource.gallery);
                          }
                      ),
                    ],
                  ),
                SizedBox(height: 15,),
                if (socialAccount != 'Email')
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: profileListTile(
                          title: 'Name',
                          subTitle: _user.displayName,
                          leadingIcon: Icons.assignment_ind_sharp)),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: profileListTile(
                        title: 'Email',
                        subTitle: _user.email ?? '',
                        leadingIcon: Icons.email)),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: profileListTile(
                        title: 'Address',
                        subTitle: address == null || address == ""
                            ? 'Not Set'
                            : address.toString(),
                        leadingIcon: Icons.location_on,
                        trailingIcon: Icons.edit,
                        onEditClick: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return editProfileValues(
                                    title: 'Edit Your Address',
                                    context: context,
                                    isLoading: isLoading,
                                    controller: _addressController,
                                    onPress: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await editProfileDbValues(
                                          addressController: _addressController,
                                          account: socialAccount,
                                          address: address,
                                          dob: dob,
                                          phone: phone,
                                          user: _user,
                                          isEmail: isEmailAccount,
                                          emailPhotoUrl: photoUrl);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                              });
                        })),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: profileListTile(
                        title: 'Phone',
                        subTitle: phone == null || phone == ""
                            ? 'Not Set'
                            : phone.toString(),
                        leadingIcon: Icons.phone,
                        trailingIcon: Icons.edit,
                        onEditClick: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return editProfileValues(
                                    title: 'Edit Your Phone',
                                    context: context,
                                    isLoading: isLoading,
                                    controller: _phoneController,
                                    onPress: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await editProfileDbValues(
                                          phoneController: _phoneController,
                                          account: socialAccount,
                                          address: address,
                                          dob: dob,
                                          phone: phone,
                                          user: _user,
                                          isEmail: isEmailAccount,
                                          emailPhotoUrl: photoUrl);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                              });
                        })),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 15),
                  child: profileListTile(
                    title: 'Date of birth',
                    subTitle: dob == null ? 'Not Set' : dob.toString(),
                    leadingIcon: Icons.date_range,
                    trailingIcon: Icons.edit,
                    onEditClick: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1060),
                              lastDate: DateTime.now())
                          .then((value) async {
                        setState(() {
                          dateTime = value;
                        });
                        await FirebaseFirestore.instance
                            .collection('Buyonic')
                            .doc('Users')
                            .collection(socialAccount)
                            .doc(_user.uid)
                            .set({
                          'name': _user.displayName,
                          'profile_pic': socialAccount == 'Email'
                              ? photoUrl
                              : _user.photoURL,
                          'email': _user.email,
                          'type': socialAccount,
                          'Address': _addressController == null
                              ? address
                              : _addressController.text,
                          'DOB': dateTime == null
                              ? dob
                              : dateTime.toString().substring(0, 10),
                          'Phone': _phoneController == null
                              ? phone
                              : _phoneController.text,
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.remove('type');
    await FirebaseAuth.instance.signOut();

    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (r) => false);
  }

  getImage({ImageSource source}) async {

    PickedFile image = await ImagePicker().getImage(source: source);
    if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(0xFFFF4828),
            toolbarWidgetColor: Colors.white,
            toolbarTitle: "Crop Your Picture",
            statusBarColor: Color(0xFFFF4828),
            backgroundColor: Colors.white,
          )
      );

      setState((){
        _selectedFile = cropped;
      });
      if(_selectedFile!=null) {
        try {
          setState(() {
            isEmailLoading = true;
          });
          FirebaseStorage storage = FirebaseStorage.instance;
          Reference reference = storage.ref().child("profileImages/${_user.uid}");
          UploadTask uploadTask = reference.putFile(_selectedFile);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
              print('Uploaded'));

          // Waits till the file is uploaded then stores the download url
          String uploadedPhotoUUrl = await taskSnapshot.ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('Buyonic')
              .doc('Users')
              .collection(socialAccount)
              .doc(_user.uid)
              .set({
            'name': _user.displayName,
            'profile_pic': uploadedPhotoUUrl,
            'email': _user.email,
            'type': socialAccount,
            'Address': _addressController == null
                ? address
                : _addressController.text,
            'DOB': dateTime == null
                ? dob
                : dateTime.toString().substring(0, 10),
            'Phone': _phoneController == null
                ? phone
                : _phoneController.text,
          });
          setState(() {
            isEmailLoading = false;
          });
        }catch(e){
          setState(() {
            isEmailLoading = false;
          });
        }

      }
    }
    else{
      return null;
    }
  }
}
