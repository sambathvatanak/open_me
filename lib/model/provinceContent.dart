import 'dart:convert';

import 'package:flutter/services.dart';

class ProvinceContent{
  String image;
  String code;
  String khmer;
  String latin;
  String east;
  String west;
  String south;
  String north;
  static int index;

  ProvinceContent({this.image, this.code, this.khmer, this.latin, this.east, this.west, this.north, this.south});

  ProvinceContent.fromJsonProvince(Map<String, dynamic> json){
    code = json['code'].toString();
    khmer = json['khmer'].toString();
    latin = json['latin'].toString();
    east = json['boundary']['east'].toString();
    west = json['boundary']['west'].toString();
    north = json['boundary']['north'].toString();
    south = json['boundary']['south'].toString();
  }

  ProvinceContent.fromJsonOther(Map<String, dynamic> json){
    code = json['code'].toString();
    khmer = json['khmer'].toString();
    latin = json['latin'].toString();
  }

  ProvinceContent.getIndex(dynamic num){
    index = num;
    print(index);
  }

  int getNum(){
    return index;
  }

  String getImage(title){
    var imageAsset;
    if(title == 'Banteay Meanchey'){
      imageAsset = 'assets/image/BTC.jpg';
    }else if(title == 'Battambang'){
      imageAsset = 'assets/image/BTB.jpg';
    }else if(title == 'Kampong Cham'){
      imageAsset = 'assets/image/KPC.jpg';
    }else if(title == 'Kampong Chhnang'){
      imageAsset = 'assets/image/KPCH.jpg';
    }else if(title == 'Kampong Speu'){
      imageAsset = 'assets/image/KS.jpg';
    }else if(title == 'Kampong Thom'){
      imageAsset = 'assets/image/KPT.jpg';
    }else if(title == 'Kampot'){
      imageAsset = 'assets/image/KP.jpg';
    }else if(title == 'Kandal'){
      imageAsset = 'assets/image/KD.jpg';
    }else if(title == 'Koh Kong'){
      imageAsset = 'assets/image/KK.jpg';
    }else if(title == 'Kratie'){
      imageAsset = 'assets/image/KJ.jpg';
    }else if(title == 'Mondul Kiri'){
      imageAsset = 'assets/image/MDK.jpg';
    }else if(title == 'Phnom Penh Capital'){
      imageAsset = 'assets/image/PP.jpg';
    }else if(title == 'Preah Vihear'){
      imageAsset = 'assets/image/PVH.jpg';
    }else if(title == 'Prey Veng'){
      imageAsset = 'assets/image/PV.jpg';
    }else if(title == 'Pursat'){
      imageAsset = 'assets/image/PS.jpg';
    }else if(title == 'Ratanak Kiri'){
      imageAsset = 'assets/image/RKR.jpg';
    }else if(title == 'Siemreap'){
      imageAsset = 'assets/image/SR.jpg';
    }else if(title == 'Preah Sihanouk'){
      imageAsset = 'assets/image/KPS.jpg';
    }else if(title == 'Stung Treng'){
      imageAsset = 'assets/image/ST.jpg';
    }else if(title == 'Svay Rieng'){
      imageAsset = 'assets/image/SR.jpg';
    }else if(title == 'Takeo'){
      imageAsset = 'assets/image/TK.jpg';
    }else if(title == 'Oddar Meanchey'){
      imageAsset = 'assets/image/ODC.jpg';
    }else if(title == 'Kep'){
      imageAsset = 'assets/image/KEP.jpg';
    }else if(title == 'Pailin'){
      imageAsset = 'assets/image/PL.jpg';
    }else if(title == 'Tboung Khmum'){
      imageAsset = 'assets/image/TBK.jpg';
    }
    return imageAsset;
  }

}

ProvinceContent pvc = ProvinceContent();

Future<List<ProvinceContent>> fetchProvinceContent() async {
  var response =
  await rootBundle.loadString('assets/data/cambodia_gazetteer.json');
  // ignore: deprecated_member_use
  var province = List<ProvinceContent>();
  if (response != '') {
    var provinceJson = json.decode(response);
    for (var json in provinceJson) {
      province.add(ProvinceContent.fromJsonProvince(json));
    }
  }
  return province;
}

Future<List<ProvinceContent>> fetchDistrictContent() async {
  var response = await rootBundle.loadString('assets/data/cambodia_gazetteer.json');
  int index = pvc.getNum();
  // ignore: deprecated_member_use
  var district = List<ProvinceContent>();
  if (response != '') {
    var provinceJson = json.decode(response);
    provinceJson = provinceJson[index]['districts'];
    for (var json in provinceJson) {
      district.add(ProvinceContent.fromJsonOther(json));
    }
  }
  return district;
}

Future<List<dynamic>> fetchCommuneContent() async {
  var response = await rootBundle.loadString('assets/data/cambodia_gazetteer.json');
  var communeJson = json.decode(response);
  return communeJson[0]['districts'][0]['communes'];
}

Future<List<dynamic>> fetchVillageContent() async {
  var response = await rootBundle.loadString('assets/data/cambodia_gazetteer.json');
  var villageJson = json.decode(response);
  return villageJson[0]['districts'][0]['communes'][0]['villages'];
}

List<ProvinceContent> getProvinceContent = [
  ProvinceContent(
      image: 'assets/image/food-1.jpg',
      latin: 'FOOD-1'
  ),
  ProvinceContent(
      image: 'assets/image/food-3.jpg',
      latin: 'FOOD-1'
  ),
  ProvinceContent(
      image: 'assets/image/food-4.jpeg',
      latin: 'FOOD-1'
  ),
  ProvinceContent(
      image: 'assets/image/food-1.jpg',
      latin: 'FOOD-1'
  ),
  ProvinceContent(
      image: 'assets/image/food-3.jpg',
      latin: 'FOOD-1'
  ),
];

