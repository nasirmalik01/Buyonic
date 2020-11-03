import 'package:flutter/material.dart';

Widget TextFormFieldValues({String hintText, BuildContext context}){
 return Padding(
    padding:
    const EdgeInsets.only(top: 10),
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
          validator: (value){
            if(value.isEmpty){
              return '$hintText can\'t be empty' ;
            }
            return null;
          },
          style: TextStyle(
              fontFamily: 'Raleway'),
        ),
      ),
    ),
  );
}

 Widget socialMediaButton({String imageURL, String text, Color color, BuildContext context, Function onPress}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width:MediaQuery.of(context).size.width*0.43,
    child: Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)),
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
            SizedBox(width: 14,),
            Text(
                text,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    color: Colors.white
                ),),
          ],
        ),
      ),
    ),
  );
}

Map<String, String> authValues = {
'email' : '',
'password' : '',
};
