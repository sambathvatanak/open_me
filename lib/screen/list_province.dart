import 'package:flutter/material.dart';
import 'package:province_cambodia/model/provinceContent.dart';
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
  var image;

  @override
  void initState() {
    super.initState();
    fetchProvinceContent().then((value) {
      _province.addAll(value);
      _provinceDisplay = _province;
    });
  }

  var indexCon;

  @override
  Widget build(BuildContext context) {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(
          provinceName: _provinceDisplay[index].latin,
          east: _provinceDisplay[index].east,
          west: _provinceDisplay[index].west,
          south: _provinceDisplay[index].south,
          north: _provinceDisplay[index].north,
          indexNum: _provinceDisplay[index].code,
          image: pvc.getImage(_provinceDisplay[index].latin),
        )),
        );
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
            _provinceImage(_provinceDisplay[index].latin),
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
                        color: Colors.grey.shade800
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
                          color: Colors.grey.shade600
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'District: ' + _district.length.toString(),
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

  Widget _provinceImage(text) {
    image = pvc.getImage(text);
    return Container(
      width: 180,
      height: 140,
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(image != null ? image : 'assets/image/BTC.jpg')),
      ),
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
