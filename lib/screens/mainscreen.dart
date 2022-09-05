import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/screens/cars.dart';
import 'package:wallpaper_app/servicies/search_by_color.dart';
import 'package:wallpaper_app/servicies/trending.dart';
import 'package:wallpaper_app/servicies/wallpaper.dart';
import 'package:wallpaper_app/widgets/or_seperator.dart';
import 'package:wallpaper_app/widgets/wallpaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController colorController = TextEditingController();

  int selectedIndex = 0;

  void onItenTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<String> topCatagoryList = [
    'Cats',
    'Baby',
    'Sky',
    'Lakes',
    'Earth',
    'Airplanes',
  ];
  List<String> randomTopics = [
    'Airplanes',
    'Sky',
    'Lakes',
    'Earth',
    'dark',
    'patterns',
    'sports',
  ];

  List<Color> topColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.pink,
    Colors.white,
    Colors.black,
  ];
  List<String> colorsCatagory = [
    'red',
    'blue',
    'green',
    'yellow',
    'purple',
    'pink',
    'white',
    'black',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 10,
          backgroundColor: Color(0xff414A4C),
          iconTheme: MaterialStateProperty.all(
            IconThemeData(opacity: 0.75, color: Colors.amber.shade100),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 65,
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        child: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 400),
          color: Colors.red.shade200,
          height: 50,
          backgroundColor: Colors.black,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            Icon(
              Icons.home_rounded,
              size: 25,
            ),
            Icon(
              Icons.grid_on,
              size: 25,
            ),
            Icon(
              Icons.search,
              size: 25,
            ),
          ],
          index: selectedIndex,
          onTap: (value) {
            setState(() {
              this.selectedIndex = value;
              print(selectedIndex.toString());
            });
          },
        ),
      ),
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
          child: Drawer(
            elevation: 10,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Trending(),
          FrontPage(query: 'designs'),
          CarsWallpaper(),
        ],
      ),
    );
  }
}
/**IndexedStack(
          index: selectedIndex,
          children: [
            HomePage(),
            InternationalNews(),
            SportsNews(),
            TechNews(),
            LocalNews(),
          ],
        ), */
/* SafeArea(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular',
                style: GoogleFonts.fredoka(
                    fontSize: 40, color: Colors.red.shade200),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 60,
                width: width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topCatagoryList.length,
                    itemBuilder: (context, index) => Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FrontPage(
                                      query: topCatagoryList[index]);
                                }));
                              },
                              child: Container(
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.red.shade200, width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    topCatagoryList[index],
                                    style: GoogleFonts.sairaCondensed(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'By Colors',
                style: GoogleFonts.fredoka(
                    fontSize: 40, color: Colors.red.shade200),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 80,
                width: width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topColor.length,
                    itemBuilder: (context, index) => Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchByColor(
                                      colortype: colorsCatagory[index],
                                      query2: 'patterns');
                                }));
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: topColor[index],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OrSeperator(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: Colors.red.shade200, width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: colorController,
                      style:
                          TextStyle(color: Colors.red.shade200, fontSize: 20),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.red.shade200, fontSize: 17.5),
                          hintText: 'Search by Color Code',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: width * 0.2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade200)),
                    onPressed: () {
                      if (colorController.text.startsWith('#') &&
                          colorController.text.length == 7) {
                        print('Going to Next Page');
                      } else {
                        print('please enter correct value');
                      }
                    },
                    child: Center(
                      child: Text('GO'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Main Catagories',
                style: GoogleFonts.fredoka(
                    fontSize: 40, color: Colors.red.shade200),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ), */