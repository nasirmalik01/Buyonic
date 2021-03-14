import 'package:flutter/material.dart';

Widget textFormFieldValues({String hintText, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 4,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: 'Raleway'),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return '$hintText can\'t be empty';
            }
            return null;
          },
          style: TextStyle(fontFamily: 'Raleway'),
        ),
      ),
    ),
  );
}

Widget socialMediaButton(
    {String imageURL,
    String text,
    Color color,
    BuildContext context,
    Function onPress}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: MediaQuery.of(context).size.width * 0.43,
    child: Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: color,
      child: MaterialButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(imageURL),
              height: 25,
              width: 25,
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget stackProfileInfo(
    {String imageUrl,
    String displayName,
    String email,
    bool isEmail = false,
    Function onTap,
    BuildContext context}) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      children: [
        CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(
              imageUrl,
            )),
        SizedBox(
          height: 10,
        ),
        isEmail == true
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      child: Text(
                        'Change profile picture',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      onPressed: onTap),
                ),
              )
            : Text(
                displayName,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Raleway', fontSize: 20),
              ),
        if (isEmail != true)
          Text(
            email,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Raleway', fontSize: 15),
          ),
      ],
    ),
  );
}

Widget addInputField({
  TextEditingController controller,
}) {
  return TextFormField(
    textInputAction: TextInputAction.next,
    controller: controller,
    decoration: InputDecoration(
      // hintText: hintText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    ),
    style: TextStyle(fontFamily: 'Raleway'),
    // validator: (value) {
    //   if (value.isEmpty) {
    //     return '$inputField can\'t be empty';
    //   }
    //   return null;
    // },
  );
}

Widget profileListTile(
    {String title,
    String subTitle,
    IconData leadingIcon,
    IconData trailingIcon,
    Function onEditClick}) {
  return Card(
    elevation: 5,
    child: ListTile(
      leading: Icon(
        leadingIcon,
      ),
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontFamily: 'Nunito',
        ),
      ),
      trailing: IconButton(icon: Icon(trailingIcon), onPressed: onEditClick),
    ),
  );
}

Widget editProfileValues(
    {BuildContext context,
    TextEditingController controller,
    bool isLoading,
    Function onPress,
    String title}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 26, left: 20, right: 20),
            child: addInputField(
              controller: controller,
              // hintText: address == 'Not set' ? 'Enter Your Address' : address,
              //initialValue:  address == 'Not set' ? 'Enter Your Address' : address,
              // inputField: 'Address'
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlue,
                gradient: LinearGradient(colors: [
                  Color(0xFFFF4828),
                  Color(0xFFFE8D03),
                ])),
            child: FlatButton(
                child: isLoading == true
                    ? CircularProgressIndicator()
                    : Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                onPressed: onPress),
          )
        ],
      ),
    ),
  );
}

Map<String, String> authValues = {
  'email': '',
  'password': '',
};

Widget titleText({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 17),
  );
}

Widget quantityText({String title}) {
  return Text(
    title,
    style: TextStyle(fontFamily: 'Raleway', fontSize: 17, color: Colors.white),
  );
}

Widget descText({String title}) {
  return Text(
    title,
    style: TextStyle(fontFamily: 'Nunito', fontSize: 16, color: Colors.grey),
  );
}

Widget titleText2({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Raleway', fontWeight: FontWeight.normal, fontSize: 17),
  );
}

Widget titleText3({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Nunito',
        color: Color(0xFFFF5222),
        fontWeight: FontWeight.bold,
        fontSize: 14),
  );
}

Widget titleText4({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: 14),
  );
}

Widget reviewText({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Raleway', fontWeight: FontWeight.normal, fontSize: 16),
    textAlign: TextAlign.end,
  );
}

Widget getInfo({String title, String prodInfo}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 3,
      ),
      Text(prodInfo),
    ],
  );
}
