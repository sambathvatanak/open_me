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

class saveFavorite extends StatefulWidget {
  @override
  _saveFavoriteState createState() => _saveFavoriteState();
}

class _saveFavoriteState extends State<saveFavorite> {

  bool isSwitched = false;
  bool isSearching = false;
  var _searchCtrl = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription<User> homeStateSubscription;
  var image;
  var indexCon;
  var fbUserNew;
  bool isSaved = null;

  @override
  void initState() {
    super.initState();
    var authBloc = Provider.of<AuthBloc>(context,listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      setState(() {
        if (fbUser != null){
          fbUserNew = fbUser;
        }
      });
    });
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fav = Provider.of<Favorite>(context);
    if(fbUserNew != null){
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: fbUserNew.uid).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: RefreshIndicator(
                    child: snapshot.data.docs.length > 0
                        ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        return _provinceView(context, index, snapshot.data.docs);
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
    }else{
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(onSurface: Colors.red),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login())
            );
          },
          child: Text('Please login'),
        ),
      );
    }

  }

  Widget _provinceView(context, index, List<QueryDocumentSnapshot<Object>> docs) {
    // isSaved = saveProvince.contains(_provinceDisplay[index].latin);
    return GestureDetector(
      onTap: (){
        if(fbUserNew != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(
            provinceName: docs[index]['latin'],
            east: docs[index]['east'],
            west: docs[index]['west'],
            south: docs[index]['south'],
            north: docs[index]['north'],
            indexNum: docs[index]['index'],
            image: pvc.getImage(docs[index]['latin']),
            khmer: docs[index]['khmer'],
            description: docs[index]['desc'],
            district: docs[index]['district'],
            commune: docs[index]['commune'],
            village: docs[index]['village'],
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
            _provinceImage(docs[index]['latin'], docs[index]['khmer'], docs[index]['east'],docs[index]['west'],docs[index]['south'],docs[index]['north'],docs[index]['index'],docs[index]['desc'],docs[index]['district'],docs[index]['commune'],docs[index]['village']),
            Container(
              padding: EdgeInsets.only(left: 20.0, top: 8.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      docs[index]['khmer'],
                      //snapshot.data[index]['khmer'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey.shade800
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      docs[index]['latin'],
                     // _provinceDisplay[index].latin,
                      //snapshot.data[index]['latin'],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.grey.shade600
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'District: ' + '50',
                      //snapshot.data[index]['districts'][index]['khmer'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Commune: 20',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Village: 30',
                      style: TextStyle(
                        color: Colors.grey.shade600,
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

  Widget _provinceImage(text, khmer, east, west, south, north, index, desc, district, commune, village) {
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
                      isSaved == false ?
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
                            fav.addProvince(fbUserNew.displayName,fbUserNew.uid,text,khmer,east,west,south,north,index,desc,district,commune,village);
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
}
