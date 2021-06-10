import 'package:flutter/material.dart';
import 'package:province_cambodia/model/provinceContent.dart';
import 'package:province_cambodia/screen/communeDetail.dart';

class DistrictDetail extends StatefulWidget {

  final index;
  final provinceName;

  DistrictDetail({Key key, this.index, this.provinceName}) : super(key: key);

  @override
  _DistrictDetailState createState() => _DistrictDetailState();

}

class _DistrictDetailState extends State<DistrictDetail> {

  List<ProvinceContent> _district = List<ProvinceContent>();
  // ignore: deprecated_member_use
  List<ProvinceContent> _districtDisplay = List<ProvinceContent>();

  @override
  void initState() {
    super.initState();
    ProvinceContent.getIndex(widget.index);
    fetchDistrictContent().then((value) {
      _district.addAll(value);
      _districtDisplay = _district;
      print(_districtDisplay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('District Detail')
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: FutureBuilder(
                future: fetchDistrictContent(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: _districtDisplay.length,
                          itemBuilder: (BuildContext context, index) {
                            return _districtView(context, index, snapshot);
                          },
                        ),
                        onRefresh: fetchDistrictContent,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _districtView(context, index, snapshot) {
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
          var num = int.parse(_districtDisplay[0].code);
          var indexDistrict = int.parse(_districtDisplay[index].code);
          indexDistrict = _validateName(index, indexDistrict);
          num = indexDistrict - num;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommuneDetail(
                index: widget.index,
                indexCommune: num,
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
                        _districtDisplay[index].khmer,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            ),
                      ),
                      Text(
                        _districtDisplay[index].latin + ' District',
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

  Widget _districtDetail() {
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
                          Icons.location_on,
                          size: 30,
                          color: Color(0xff4C9BE2),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 12.0, top: 12.0),
                      child: Text(
                        widget.provinceName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
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
                  child: Text(
                    'Banteay Meanchey is a province of Cambodia located in the far northwest. It borders the provinces of Oddar Meanchey and Siem Reap to the east, Battambang to the south, and shares an international border with Thailand to the west. Its capital and largest city is Serei Saophoan.',
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

  int _validateName(index, indexDistrict){
    if (_districtDisplay[index].latin == 'Kampong Cham Municipality') {
      return indexDistrict -= 1;
    } else if (_districtDisplay[index].latin == 'Kampong Siem') {
      return indexDistrict -= 1;
    }else if(_districtDisplay[index].latin == 'Kang Meas'){
      return indexDistrict -= 1;
    }else if(_districtDisplay[index].latin == 'Kaoh Soutin'){
      return indexDistrict -= 1;
    }else if(_districtDisplay[index].latin == 'Prey Chhor'){
      return indexDistrict -= 5;
    }else if(_districtDisplay[index].latin == 'Srei Santhor'){
      return indexDistrict -= 5;
    }else if(_districtDisplay[index].latin == 'Stueng Trang'){
      return indexDistrict -= 5;
    }else{
      return indexDistrict;
    }
  }

}
