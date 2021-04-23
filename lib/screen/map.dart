import 'package:flutter/material.dart';

class ProvinceMap extends StatefulWidget {
  @override
  _ProvinceMapState createState() => _ProvinceMapState();
}

class _ProvinceMapState extends State<ProvinceMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map',
        ),
      ),
    );
  }
}
