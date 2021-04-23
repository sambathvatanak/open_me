import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_cambodia/model/provinceContent.dart';
import 'package:province_cambodia/provider/themeChanger.dart';
import 'package:province_cambodia/screen/list_province.dart';
import 'package:province_cambodia/screen/login.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

int _page = 0;
bool isSwitched = false;
GlobalKey _bottomNavigationKey = GlobalKey();

class _homePageState extends State<homePage> {

  // ignore: deprecated_member_use
  List<ProvinceContent> _province = List<ProvinceContent>();
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _botNavList = [
      _homeScreen(context),
      ListProvince(),
      _provinceContent(),
      _provinceContent(),
      //home(),
      Login(),
    ];
    return Scaffold(
      body: _botNavList[_page],
      //drawer: _drawerMenu(context),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Color(0xff4C9BE2),),
          Icon(Icons.list, size: 30, color: Color(0xff4C9BE2),),
          Icon(Icons.favorite_rounded, size: 30, color: Color(0xff4C9BE2),),
          Icon(Icons.map_rounded, size: 30, color: Color(0xff4C9BE2),),
          Icon(Icons.perm_identity, size: 30, color: Color(0xff4C9BE2),),
        ],
        color: Theme.of(context).bottomAppBarColor,
        buttonBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Color(0xff4C9BE2),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

Widget _homeScreen(context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Welcome'),
    ),
    drawer: _drawerMenu(context),
    body: Container(
      child: ListView(
        children: [
          _imageSlider(),
          _title(context),
          _searchBar(context),
          _provinceContent(),
        ],
      ),
    ),
  );
}

  Widget _drawerMenu(context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Vatanak Sambath"),
              accountEmail: Text("sambathvatanak@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "VS",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            ListTile(
              leading:
              Icon(Icons.settings, size: 26, color: Color(0xff4C9BE2)),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts_rounded,
                  size: 26, color: Color(0xff4C9BE2)),
              title: Text("About"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
                margin: EdgeInsets.only(left: 18),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      size: 26,
                      color: Color(0xff4C9BE2),
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      'Dark Mode',
                      //style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          isSwitched ? themeChanger.setTheme(ThemeMode.dark) : themeChanger.setTheme(ThemeMode.light);
                        });
                      },
                      activeTrackColor: Colors.blueAccent[200],
                      activeColor: Colors.grey[50],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _title(context){
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Text(
        'What would you like to search ?',
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[600],
          fontWeight: FontWeight.w400,
          fontFamily: 'Khmer OS',
        ),
      ),
    );
  }

  Widget _searchBar(context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Theme.of(context).bottomAppBarColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            onTap: () {
              Future.delayed(Duration.zero, () {
                // Navigator.pop(context, '/home');
                //Navigator.pushNamed(context, '/SearchResult');
                final CurvedNavigationBar navigationBar = _bottomNavigationKey.currentWidget;
                navigationBar.onTap(1);
              });
            },
            readOnly: true,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              suffixIcon: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 20,
                    top: 14,
                    bottom: 14,
                  ),
                  child: Icon(
                    Icons.search,
                    size: 26,
                    color: Colors.blueAccent[200],
                  ),
                ),
              ),
              border: InputBorder.none,
              hintText: 'Search location here...',
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 20,
                top: 14,
                bottom: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _provinceContent(){
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.only(left: 12.0),
        height: 380,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: getProvinceContent.length,
          itemBuilder:(context,index){
            return Stack(
              alignment: Alignment.topLeft,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      width: 240,
                      //height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          //color: Colors.red,
                          child: Image.asset(
                            '${getProvinceContent[index].image}',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Text(
                    getProvinceContent[index].latin,
                  ),
                ),
              ],
            );
          },
        )
    );
  }

}

final List<String> imgList = ['assets/image/KP.jpg', 'assets/image/TBK.jpg', 'assets/image/KPC.jpg',
  'assets/image/BTB.jpg', 'assets/image/BTC.jpg', 'assets/image/KD.jpg',
  'assets/image/KJ.jpg', 'assets/image/KEP.jpg', 'assets/image/KPCH.jpg',
  'assets/image/KPS.jpg', 'assets/image/KPT.jpg', 'assets/image/KS.jpg',
  'assets/image/MDK.jpg', 'assets/image/ODC.jpg', 'assets/image/ST.jpg'];
final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                // child: Text(
                //   'No. ${imgList.indexOf(item)} image',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();

Widget _imageSlider(){
  return Container(
    height: 280,
    child: CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
        autoPlay: true,
      ),
      items: imageSliders,
    ),
  );
}




