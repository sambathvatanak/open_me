import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:province_cambodia/provider/favoriteBloc.dart';

class ProvinceContent{
  String image;
  String code;
  String khmer;
  String latin;
  String district;
  String commune;
  String village;
  String east;
  String west;
  String south;
  String north;
  String description;
  static int index;
  static int indexCommune;
  static int indexVillage;

  ProvinceContent({this.image, this.code, this.khmer, this.latin, this.district, this.commune, this.village, this.description, this.east, this.west, this.north, this.south});

  ProvinceContent.fromJsonProvince(Map<String, dynamic> json){
    code = json['code'].toString();
    khmer = json['khmer'].toString();
    latin = json['latin'].toString();
    district = json['districtNum'].toString();
    commune = json['communeNum'].toString();
    village = json['villageNum'].toString();
    description = json['description'].toString();
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

  ProvinceContent.getIndex(dynamic num, {dynamic communeIndex, dynamic villageIndex,}){
    index = num;
    indexCommune = communeIndex;
    indexVillage = villageIndex;
    //print(index);
  }

  int getNum(){
    return index;
  }

  int getNumCommune(){
    return indexCommune;
  }

  int getNumVillage(){
    return indexVillage;
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
  var url = ('https://raw.githubusercontent.com/sambathvatanak/province_cambodia/master/assets/cambodia_gazetteer.json');
  var response = await http.get(Uri.parse(url));
  // ignore: deprecated_member_use
  var province = List<ProvinceContent>();
  if(response.statusCode == 200) {
    var provinceJson = json.decode(response.body);
    for (var json in provinceJson) {
      province.add(ProvinceContent.fromJsonProvince(json));
    }
  }
  //print(province.length);
  return province;
}

Future<List<ProvinceContent>> fetchDistrictContent() async {
  var url = ('https://raw.githubusercontent.com/sambathvatanak/province_cambodia/master/assets/data/cambodia_gazetteer.json');
  var response = await http.get(Uri.parse(url));
  int index = pvc.getNum();
  // ignore: deprecated_member_use
  var district = List<ProvinceContent>();
  if (response.statusCode == 200) {
    var provinceJson = json.decode(response.body);
    provinceJson = provinceJson[index]['districts'];
    for (var json in provinceJson) {
      district.add(ProvinceContent.fromJsonOther(json));
    }
  }
  return district;
}

Future<List<ProvinceContent>> fetchCommuneContent() async {
  var url = ('https://raw.githubusercontent.com/sambathvatanak/province_cambodia/master/assets/data/cambodia_gazetteer.json');
  var response = await http.get(Uri.parse(url));
  int index = pvc.getNum();
  int indexCommune = pvc.getNumCommune();
  // ignore: deprecated_member_use
  var commune = List<ProvinceContent>();
  if (response.statusCode == 200) {
    var provinceJson = json.decode(response.body);
    provinceJson = provinceJson[index]['districts'][indexCommune]['communes'];
    for (var json in provinceJson) {
      commune.add(ProvinceContent.fromJsonOther(json));
    }
  }
  return commune;
}

Future<List<ProvinceContent>> fetchVillageContent() async {
  var url = ('https://raw.githubusercontent.com/sambathvatanak/province_cambodia/master/assets/data/cambodia_gazetteer.json');
  var response = await http.get(Uri.parse(url));
  int index = pvc.getNum();
  int indexCommune = pvc.getNumCommune();
  int indexVillage = pvc.getNumVillage();
  // ignore: deprecated_member_use
  var village = List<ProvinceContent>();
  if (response.statusCode == 200) {
    var provinceJson = json.decode(response.body);
    provinceJson = provinceJson[index]['districts'][indexCommune]['communes'][indexVillage]['villages'];
    for (var json in provinceJson) {
      village.add(ProvinceContent.fromJsonOther(json));
    }
  }
  return village;
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

