import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/servicies/wallpaper.dart';

class CarsWallpaper extends StatefulWidget {
  const CarsWallpaper({Key? key}) : super(key: key);

  @override
  State<CarsWallpaper> createState() => _CarsWallpaperState();
}

class _CarsWallpaperState extends State<CarsWallpaper> {
  TextEditingController controller = TextEditingController();
  List<String> catagories = [
    'CARS',
    'ANIMALS',
    'NATURE',
    'BABIES',
    'DESIGNS',
    'HOLLYWoOD'
  ];
  List<String> imageList = [
    'assets/images/caaars.jpg',
    'assets/images/animals.jpg',
    'assets/images/nature.jpg',
    'assets/images/anime.jpg',
    'assets/images/bolly.jpg',
    'assets/images/holly.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Search',
            style: GoogleFonts.bebasNeue(
                color: Colors.black, fontSize: 50, letterSpacing: 5),
          ),
          backgroundColor: Colors.red.shade200,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.red.shade200, width: 3)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.red.shade200, fontSize: 20),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.red.shade200, fontSize: 17.5),
                        hintText: 'Search for any topic',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.red.shade200,
                ),
                onPressed: () {
                  Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return FrontPage(query: controller.text.trim().toString());
                            }));
                },
                child: Center(
                  child: Text('GO'),
                ),
              ),
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
            Expanded(
              child: SizedBox(
                child: GridView.builder(
                    itemCount: catagories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return FrontPage(query: catagories[index]);
                            }));
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imageList[index]),
                                    fit: BoxFit.cover),
                                color: Colors.red.shade200,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                catagories[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
