import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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

  Widget _logo(){
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
              backgroundImage: AssetImage('assets/image/KP.jpg'),
            ),
          ),
          SizedBox(
            height: 90,
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
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.facebook),
            iconSize: 40,
            color: Colors.blue[800],
            onPressed: () {},
          ),
          SizedBox(width: 40),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.google),
            iconSize: 40,
            color: Colors.blue[800],
            onPressed: () {},
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  _logo(),
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