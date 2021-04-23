import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

Widget _buildCoverImage(Size screenSize) {
  return Container(
    width: screenSize.width,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/food-3.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _build_Login_Logo(Size screenSize) {
  return Expanded(
    child: Container(
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/food-1.jpg',
          width: screenSize.width / 3.2,
        ),
      ),
    ),
  );
}

Widget _title(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
    //color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Khmer Education',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(58.0),
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(58.0),
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _divider(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: new EdgeInsetsDirectional.only(start: 80.0, end: 80.0),
          height: 12.0,
          decoration: BoxDecoration(
            color: Color(0xffE3E3E3),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        SizedBox(height: 12,),
        Container(
          margin: new EdgeInsetsDirectional.only(start: 120.0, end: 120.0),
          height: 12.0,
          decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        SizedBox(height: 12,),
        Container(
          margin: new EdgeInsetsDirectional.only(start: 102.0, end: 102.0),
          height: 12.0,
          decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ],
    ),
  );
}

Widget _login_button(BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(120.0),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //padding: EdgeInsets.symmetric(vertical: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: <BoxShadow>[
              //box shadow of login button
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
            color: Color(0xff4267B2),
          ),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/food-1.jpg',
                  width: 15.0,
                ),
                SizedBox(width: 10,),
                Text(
                  'ចូលប្រើតាមរយះ Facebook',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(38.0),
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),
        ),
        Container(
          child: Text(
            'ឬ',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(38.0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(120.0),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //padding: EdgeInsets.symmetric(vertical: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                //box shadow of login button
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
              gradient: LinearGradient(
                // start to shape the login button
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff00B1F5), Color(0xff007FC7)],
              )),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              'ចុះឈ្មោះ',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(38.0),
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              print('hello');
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'មានគណនីរួចហើយ? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:  ScreenUtil().setSp(38.0),
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  TextSpan(
                      text: 'ចូលប្រើប្រាស់',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize:  ScreenUtil().setSp(38.0),
                        fontWeight: FontWeight.w400,
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1650),
        orientation: Orientation.portrait);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.40,
            child: Container(
              child: Stack(
                children: <Widget>[
                  _buildCoverImage(screenSize),
                  Column(
                    children: <Widget>[
                      _build_Login_Logo(screenSize),
                    ],
                  )
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.65,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _title(context),
                    _divider(context),
                    SizedBox(height: 40,),
                    _login_button(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}