import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

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
    latlng = LatLng(double.parse(widget.lat), double.parse(widget.lng));
    // addPoints();
    // List<Polygon> addPolygon = [
    //   Polygon(
    //     polygonId: PolygonId('Cambodia'),
    //     points: point,
    //     consumeTapEvents: true,
    //     strokeColor: Colors.grey,
    //     strokeWidth: 1,
    //     fillColor: Colors.green[300],
    //   ),
    // ];
    // //print(addPolygon);
    // polygon.addAll(addPolygon);
    // super.initState();
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
      appBar: AppBar(
        title: Text(
          'Map',
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            // markers: Set.from(
            //   markers,
            // ),
            initialCameraPosition: CameraPosition(target: latlng, zoom: 8.0),
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              mapController = controller;
              String value = await DefaultAssetBundle.of(context)
                  .loadString('assets/data/map_style.json');
              mapController.setMapStyle(value);
            },
            polygons: polygon,
          ),
          buildFloatingSearchBar(),
        ],
      )
    );
  }
  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        print(query);
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 90, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Future<void> _goToPlace(Place place) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(
  //               place.geometry.location.lat, place.geometry.location.lng),
  //           zoom: 14.0),
  //     ),
  //   );
}
