import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_cambodia/model/provinceContent.dart';
import 'package:province_cambodia/provider/authBloc.dart';
import 'package:province_cambodia/provider/favoriteBloc.dart';
import 'package:province_cambodia/screen/login.dart';
import 'package:province_cambodia/screen/provinceDetail.dart';

class ListProvince extends StatefulWidget {
  @override
  _ListProvinceState createState() => _ListProvinceState();
}

class _ListProvinceState extends State<ListProvince> {
  bool isSwitched = false;
  bool isSearching = false;
  var _searchCtrl = TextEditingController();
  // ignore: deprecated_member_use
  List<ProvinceContent> _province = List<ProvinceContent>();
  // ignore: deprecated_member_use
  List<ProvinceContent> _district = List<ProvinceContent>();
  // ignore: deprecated_member_use
  List<ProvinceContent> _provinceDisplay = List<ProvinceContent>();
  ProvinceContent pvc = new ProvinceContent();
  final FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription<User> homeStateSubscription;
  var image;
  var indexCon;
  var fbUserNew;
  bool isSaved = null;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchProvinceContent().then((value) {
      _province.addAll(value);
      _provinceDisplay = _province;
    });
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
    fav.clearListProvince();
    dataOnCloud();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchCtrl,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "search by province name...",
            hintStyle: TextStyle(color: Colors.white),
          ),
          onTap: () {
            setState(() {
              isSearching = true;
            });
          },
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              void _showProvince(){
                _provinceDisplay = _province.where((province) {
                  var pro = province.latin.toLowerCase();
                  return pro.contains(text);
                }).toList();
                if(_provinceDisplay.isEmpty){
                  _provinceDisplay = _province.where((province) {
                    var pro = province.khmer.toLowerCase();
                    return pro.contains(text);
                  }).toList();
                }
              }

              if(text == ''){
                _provinceDisplay = _province.toList();
              }
              if (_provinceDisplay.isNotEmpty) {
                _showProvince();
              }else{
                _showProvince();
              }
            });
          },
        ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      FocusScope.of(context).unfocus();
                      _searchCtrl.clear();
                      _provinceDisplay = _province.toList();
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchProvinceContent(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                child: RefreshIndicator(
                  child:  _provinceDisplay.length > 0
                      ? ListView.builder(
                          itemCount: _provinceDisplay.length,
                          itemBuilder: (BuildContext context, index) {
                            String province = _provinceDisplay[index].latin;
                            isSaved = fav.saveProvince.contains(province);
                            return _provinceView(context, index);
                          },
                        )
                      : _dataIsNull(),
                  onRefresh: fetchProvinceContent,
                ),
              );
            }
          },
        ),
      ), //_provinceView(context),
      // drawer: _drawerMenu(context),
    );
  }

  Widget _provinceView(context, index) {
    return GestureDetector(
      onTap: (){
        if(fbUserNew != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(
            provinceName: _provinceDisplay[index].latin,
            east: _provinceDisplay[index].east,
            west: _provinceDisplay[index].west,
            south: _provinceDisplay[index].south,
            north: _provinceDisplay[index].north,
            indexNum: _provinceDisplay[index].code,
            image: pvc.getImage(_provinceDisplay[index].latin),
            khmer: _provinceDisplay[index].khmer,
            description: _provinceDisplay[index].description,
            district: _provinceDisplay[index].district,
            commune: _provinceDisplay[index].commune,
            village: _provinceDisplay[index].village,
            lat: _provinceDisplay[index].lat,
            lng: _provinceDisplay[index].lng,
          )),
          );
        }else{
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Login())
          );
        }
      },
      child: Container(
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
        margin: EdgeInsets.all(8.0),
        height: 140,
        //color: Colors.red,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _provinceImage(_provinceDisplay[index].latin, _provinceDisplay[index].khmer,_provinceDisplay[index].east,_provinceDisplay[index].west,_provinceDisplay[index].south,_provinceDisplay[index].north,_provinceDisplay[index].code,_provinceDisplay[index].description,_provinceDisplay[index].district,_provinceDisplay[index].commune,_provinceDisplay[index].village,_provinceDisplay[index].lat,_provinceDisplay[index].lng),
            Container(
              padding: EdgeInsets.only(left: 20.0, top: 8.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      _provinceDisplay[index].khmer,
                      //snapshot.data[index]['khmer'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        // color: Colors.grey.shade800
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _provinceDisplay[index].latin,
                      //snapshot.data[index]['latin'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                          // color: Colors.grey.shade600
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'District: ' + _provinceDisplay[index].district,
                      //snapshot.data[index]['districts'][index]['khmer'],
                      style: TextStyle(
                        //color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Commune: ' + _provinceDisplay[index].commune,
                      style: TextStyle(
                        //color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Village: ' + _provinceDisplay[index].village,
                      style: TextStyle(
                        //color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _provinceImage(text, khmer,east ,west, south, north, index, desc, district, commune, village, lat, lng) {
    var fav = Provider.of<Favorite>(context);
    image = pvc.getImage(text);
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: 180,
              height: 120,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(image != null ? image : 'assets/image/BTC.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isSaved == false || isSaved == null ?
                      Container(
                        width: 26,
                        height: 24,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(0.0),
                          iconSize: 19.0,
                          icon: Icon(
                            Icons.favorite_border_rounded,
                            color: Color(0xff4C9BE2),
                          ),
                          onPressed: () {
                            if(fbUserNew != null){
                              fav.addProvince(fbUserNew.displayName,fbUserNew.uid,text,khmer,east,west,south,north,index,desc,district,commune,village,lat,lng);
                            }else {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Login())
                              );
                            };
                          },
                        ),
                      )
                          : Container(
                        width: 26,
                        height: 24,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(0.0),
                          iconSize: 19.0,
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: Color(0xff4C9BE2),
                          ),
                          onPressed: () {
                            fav.removeProvince(text,fbUserNew.uid);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dataIsNull() {
    return Center(
      key: UniqueKey(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Text("Not found",
              style: TextStyle(
                color: Colors.grey,
              )),
        ],
      ),
    );
  }

  Future<void> dataOnCloud () async {
     var fav = Provider.of<Favorite>(context);
     var uid = await fbUserNew.uid;
     await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get()
     .then((QuerySnapshot querySnapshot) {
       querySnapshot.docs.forEach((doc) {
         if(!fav.saveProvince.contains(doc['latin'])){
           fav.saveProvince.add(doc['latin']);
         }
       });
     });
  }
}
