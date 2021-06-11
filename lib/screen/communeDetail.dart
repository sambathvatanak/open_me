import 'package:flutter/material.dart';
import 'package:province_cambodia/model/provinceContent.dart';
import 'package:province_cambodia/screen/villageDetail.dart';

class CommuneDetail extends StatefulWidget {

  final index;
  final indexCommune;

  CommuneDetail({Key key, this.index, this.indexCommune}) : super(key: key);

  @override
  _CommuneDetailState createState() => _CommuneDetailState();
}

class _CommuneDetailState extends State<CommuneDetail> {

  List<ProvinceContent> _commune = List<ProvinceContent>();
  // ignore: deprecated_member_use
  List<ProvinceContent> _communeDisplay = List<ProvinceContent>();

  void initState() {
    super.initState();
    ProvinceContent.getIndex(widget.index, communeIndex: widget.indexCommune);
    fetchCommuneContent().then((value) {
      _commune.addAll(value);
      _communeDisplay = _commune;
      print(_communeDisplay);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Commune Detail')
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchCommuneContent(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print('commune');
              return Container(
                child: ListView.builder(
                  itemCount: _communeDisplay.length,
                  itemBuilder: (BuildContext context, index) {
                    print(_communeDisplay.length);
                    return _communeView(context, index, snapshot);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _communeView(context, index, snapshot) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      height: 65,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
          var num = int.parse(_communeDisplay[0].code);
          var indexCommune = int.parse(_communeDisplay[index].code);
          indexCommune = _validateName(index, indexCommune);
          num = indexCommune - num;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VillageDetail(
                index: widget.index,
                indexCommune: widget.indexCommune,
                indexVillage: num,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 10.0, top: 8.0),
          child: Row(
            children: [
              Row(
                children: [
                  // Icon(Icons.location_on_outlined, size: 40, color: Color(0xff263882),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _communeDisplay[index].khmer,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        _communeDisplay[index].latin,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
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

  int _validateName(index, indexCommune){
    if(_communeDisplay[index].latin == 'Dang Kdar'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Khpob Ta Ngoun'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Me Sar Chrey'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Ou Mlu'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Peam Kaoh Snar'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Preah Andoung'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Preaek Bak'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Preak Kak'){
      return indexCommune -= 1;
    }else if(_communeDisplay[index].latin == 'Soupheas'){
      return indexCommune -= 2;
    }else if(_communeDisplay[index].latin == 'Tuol Preah Khleang'){
      return indexCommune -= 2;
    }else if(_communeDisplay[index].latin == 'Tuol Sambuor'){
      return indexCommune -= 2;
    }else{
      return indexCommune;
    }
  }

}
