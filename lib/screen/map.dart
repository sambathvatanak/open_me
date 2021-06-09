import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProvinceMap extends StatefulWidget {

  final lat;
  final lng;
  ProvinceMap({Key key, this.lat, this.lng}) : super(key: key);

  @override
  _ProvinceMapState createState() => _ProvinceMapState();
}

class _ProvinceMapState extends State<ProvinceMap> {

  LatLng latlng = LatLng(11.5564, 104.9282);
  Set<Polygon> polygon = new Set();
  List<LatLng> point = [];
  GoogleMapController mapController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const List cam = [
                            [103.4972799011397,10.632555446815928],[103.09068973186724,11.153660590047165],[102.5849324890267,12.186594956913282],
                            [102.348099399833,13.394247341358223],[102.98842207236163,14.225721136934467],[104.28141808473661,14.416743068901367],
                            [105.21877689007887,14.273211778210694],[106.04394616091552,13.881091009979954],[106.49637332563087,14.570583807834282],
                            [107.38272749230109,14.202440904186972],[107.61454796756243,13.535530707244206],[107.49140302941089,12.337205918827946],
                            [105.81052371625313,11.567614650921227],[106.24967003786946,10.961811835163587],[105.19991499229235,10.889309800658097],
                            [104.33433475140347,10.48654368737523],[103.4972799011397,10.632555446815928]
                          ];
  @override
  void initState() {
    // firestore.collection("users").add(
    // {
    //     "name" : "john",
    //     "age" : 50,
    //     "email" : "example@example.com",
    //     "address" : {
    //     "street" : "street 24",
    //     "city" : "new york"
    // }});
    addPoints();
    List<Polygon> addPolygon = [
      Polygon(
        polygonId: PolygonId('Cambodia'),
        points: point,
        consumeTapEvents: true,
        strokeColor: Colors.grey,
        strokeWidth: 1,
        fillColor: Colors.blueAccent,
      ),
    ];
    //print(addPolygon);
    polygon.addAll(addPolygon);
    super.initState();
  }

  void addPoints()
  {
    for( var i=0 ; i < cam.length ; i++ )
    {
      var lang = LatLng(cam[i][1], cam[i][0]);
      point.add(lang);
    }
  }

  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Map',
      //   ),
      // ),
      body: GoogleMap(
        // markers: Set.from(
        //   markers,
        // ),
        initialCameraPosition: CameraPosition(target: latlng, zoom: 5.0),
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {},
        polygons: polygon,
      ),
    );
  }
}
