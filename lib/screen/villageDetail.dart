import 'package:flutter/material.dart';
import 'package:province_cambodia/model/provinceContent.dart';

class VillageDetail extends StatefulWidget {
  final index;
  final indexCommune;
  final indexVillage;

  VillageDetail({Key key, this.index, this.indexCommune, this.indexVillage}) : super(key: key);

  @override
  _VillageDetailState createState() => _VillageDetailState();
}

class _VillageDetailState extends State<VillageDetail> {
  // ignore: deprecated_member_use
  List<ProvinceContent> _village = List<ProvinceContent>();
  // ignore: deprecated_member_use
  List<ProvinceContent> _villageDisplay = List<ProvinceContent>();

  @override
  void initState() {
    super.initState();
    print(widget.index);
    ProvinceContent.getIndex(widget.index, communeIndex: widget.indexCommune ,villageIndex: widget.indexVillage);
    fetchVillageContent().then((value) {
      _village.addAll(value);
      _villageDisplay = _village;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Village Detail')),
      body: Center(
        child: FutureBuilder(
          future: fetchVillageContent(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: _villageDisplay.length,
                    itemBuilder: (BuildContext context, index) {
                      return _villageView(context, index, snapshot);
                    },
                  ),
                  onRefresh: fetchVillageContent,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _villageView(context, index, snapshot) {
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
                      'ភូមិ' + _villageDisplay[index].khmer,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      _villageDisplay[index].latin + ' Village',
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
            // Spacer(),
            // Icon(
            //   Icons.arrow_right_alt,
            //   size: 40,
            //   color: Color(0xff263882),
            // ),
          ],
        ),
      ),
    );
  }

}
