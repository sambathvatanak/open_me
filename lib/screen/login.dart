import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:province_cambodia/provider/authBloc.dart';
import 'package:province_cambodia/screen/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map _userObj = {};
  final FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription<User> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context,listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => homePage())
        );
      }
    });
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  Widget _entryField(String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextField (
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey[300],
                  filled: true,
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget(){
    return Column(
      children: <Widget>[
        _entryField('Email:'),
        _entryField('Password:')
      ],
    );
  }

  Widget _logo(String picture,bool isNetwork){
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
              backgroundImage: isNetwork == true ? AssetImage(picture) : NetworkImage(picture),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _submitButton (){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 23),
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[ //box shadow of login button
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2,4),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          gradient: LinearGradient( // start to shape the login button
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue[300], Color(0xff4C9BE2)],
          )
      ),
      child: new GestureDetector(
        onTap: () {print('hello');},
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20, color: Colors.white,
          ),
        ),
      ),

    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), // give the space between Or word
              child: Divider(
                thickness: 2, // draw line
              ),
            ),
          ),
          Text('Or Login with'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), // give the space between Or word
              child: Divider(
                thickness: 2, //draw line
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _socialButton(){
    var authBloc = Provider.of<AuthBloc>(context);
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.facebook),
            iconSize: 40,
            color: Colors.blue[800],
            onPressed: () async {
              // FacebookAuth.instance.login(
              //     permissions: ["public_profile", "email"]).then((value) {
              //   FacebookAuth.instance.getUserData().then((userData) {
              //     setState(() {
              //       //user.isLogin = true;
              //       _userObj = userData;
              //       user.setLogin(true,_userObj);
              //     });
              //   });
              // });
              authBloc.loginFacebook();
            },
          ),
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.google),
            iconSize: 40,
            color: Colors.blue[800],
            onPressed: () {
              authBloc.signInWithGoogle()
                  .then((User user){});
            },
          ),
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.twitter),
            iconSize: 40,
            color: Colors.blue[500],
            onPressed: () {},
          ),
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.phone),
            iconSize: 40,
            color: Colors.blue[500],
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Register',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 23),
      alignment: Alignment.centerRight,
      child: new GestureDetector(
        onTap: () {print('hello');},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  _logo('assets/image/KP.jpg', true),
                  SizedBox(height: 30),
                  _emailPasswordWidget(),
                  _submitButton(),
                  _forgotPassword(),
                  _divider(),
                  _socialButton(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}