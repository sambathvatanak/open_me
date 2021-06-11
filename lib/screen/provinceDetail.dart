import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_cambodia/model/provinceContent.dart';
import 'package:province_cambodia/provider/authBloc.dart';
import 'package:province_cambodia/provider/favoriteBloc.dart';
import 'package:province_cambodia/screen/districtDetail.dart';
import 'package:province_cambodia/screen/map.dart';

import 'login.dart';

class ProvinceDetail extends StatefulWidget {
  final provinceName;
  final east;
  final west;
  final south;
  final north;
  final indexNum;
  final image;
  final khmer;
  final description;
  final district;
  final commune;
  final village;

  ProvinceDetail({Key key, this.provinceName, this.east, this.south, this.west, this.north, this.indexNum, this.image, this.khmer, this.description,this.district,this.village,this.commune}) : super(key: key);

  @override
  _ProvinceDetailState createState() => _ProvinceDetailState();
}

class _ProvinceDetailState extends State<ProvinceDetail> {
  bool isSaved = null;
  var fbUserNew;
  final FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription<User> homeStateSubscription;

  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }


  Future<void> getUser() async {
    var authBloc = Provider.of<AuthBloc>(context,listen: false);
    try{
      homeStateSubscription = authBloc.currentUser.listen((fbUser) {
        setState(() {
          if (fbUser != null){
            fbUserNew = fbUser;
          }
        });
      });
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var fav = Provider.of<Favorite>(context);
    isSaved = fav.saveProvince.contains(widget.provinceName);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Province Detail',
          ),
        ),
        body: ListView(
          children: [
            _imageHeader(isSaved,widget.provinceName,widget.khmer,widget.east,widget.west,widget.south,widget.north,widget.indexNum,widget.description,widget.district,widget.commune,widget.village),
            _provinceTitle(),
            _provinceDetail(),
            _boundaryDetail(),
            _districtDetail(),
          ],
        )
        );
  }

  Widget _imageHeader(isSaved,text,khmer,east,west,south,north,index,desc,district,commune,village) {
    var fav = Provider.of<Favorite>(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 260,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isSaved == false || isSaved == null
                            ? Container(
                                width: 42,
                                height: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Center(
                                  child: IconButton(
                                    iconSize: 26.0,
                                    icon: Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if(fbUserNew != null){
                                          fav.addProvince(fbUserNew.displayName,fbUserNew.uid,text,khmer,east,west,south,north,index,desc,district,commune,village);
                                        }else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => Login())
                                          );
                                        };
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                width: 42,
                                height: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: IconButton(
                                  iconSize: 26.0,
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      fav.removeProvince(text,fbUserNew.uid);
                                    });
                                  },
                                ),
                              ),
                      ],
                    ),
                  ],
                )),
          ],
        )
      ],
    );
  }

  Widget _provinceTitle() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProvinceMap(
              lat: '13.79',
              lng: '105.005800',
            ),),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: <BoxShadow>[
            //box shadow of login button
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.location_on,
                  size: 35,
                  color: Color(0xff4C9BE2),
                )),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.provinceName,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600,
                //color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _provinceDetail() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          //box shadow of login button
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 12.0, top: 12.0),
                        child: Icon(
                          Icons.description,
                          size: 30,
                          color: Color(0xff4C9BE2),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 12.0, top: 12.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          //color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.5,
            indent: 8,
            endIndent: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _boundaryDetail() {
    return Container(
        //color: Theme.of(context).accentColor,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: <BoxShadow>[
            //box shadow of login button
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.explore_sharp,
                    size: 35,
                    color: Color(0xff4C9BE2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Boundary',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      //color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1.5,
              indent: 8,
              endIndent: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.explore_outlined,
                        size: 24,
                        color: Color(0xff4C9BE2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'East',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          //color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.explore_outlined,
                        size: 24,
                        color: Color(0xff4C9BE2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'West',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          //color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.east,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.west,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18.0, right: 10.0),
                      child: Icon(
                        Icons.explore_outlined,
                        size: 24,
                        color: Color(0xff4C9BE2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'South',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          //color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 16.5, top: 10.0, bottom: 10.0, right: 10.0),
                      child: Icon(
                        Icons.explore_outlined,
                        size: 24,
                        color: Color(0xff4C9BE2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'North',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          //color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.south,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.north,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1.5,
              indent: 8,
              endIndent: 8,
            ),
          ],
        ));
  }

  Widget _districtDetail() {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          //box shadow of login button
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          var num = int.parse(widget.indexNum);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DistrictDetail(
                index: num - 1,
                provinceName: widget.provinceName,
              ),
            ),
          );
          // print(num);
          // print(num - 1);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 10.0),
          child: Row(
            children: [
              Row(
                children: [
                  // Icon(Icons.location_on_outlined, size: 40, color: Color(0xff263882),),
                  Text(
                    'View district of ' + widget.provinceName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      //color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_right_alt,
                size: 40,
                color: Color(0xff263882),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
