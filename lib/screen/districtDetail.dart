import 'package:flutter/material.dart';
import 'package:province_cambodia/model/provinceContent.dart';

class DistrictDetail extends StatefulWidget {

  final index;

  DistrictDetail({Key key, this.index}) : super(key: key);

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
    print(widget.index);
    ProvinceContent.getIndex(widget.index);
    fetchDistrictContent().then((value) {
      _district.addAll(value);
      _districtDisplay = _district;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('District Detail')
      ),
      body: Center(
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
          // var num = int.parse(widget.indexNum);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DistrictDetail(
          //       index: num - 1,
          //     ),
          //   ),
          // );
           print('hello');
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
                        _districtDisplay[index].latin,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            ),
                      ),
                    ],
                  ),
                  // Text(
                  //   _districtDisplay[index].latin,
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color(0xff263882)),
                  // ),
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
