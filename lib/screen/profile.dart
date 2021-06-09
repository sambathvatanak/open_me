import 'package:flutter/material.dart';

class userProfile extends StatefulWidget {
  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _logo({String picture}){
    picture == null ? picture = 'assets/image/KP.jpg' : picture = picture;
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            height: 120,
            width: 120,
            child: CircleAvatar(
              backgroundImage: AssetImage(picture),
            ),
          ),
          SizedBox(
            height: 90,
          ),
        ],
      ),
    );
  }

}
