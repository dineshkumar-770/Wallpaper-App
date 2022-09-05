import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallpaper_app/models/page.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_app/screens/nature.dart';

class FrontPage extends StatefulWidget {
  String query;
  FrontPage({required this.query});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  String thanks = 'Photo by: ';
  bool _isGrid = true;
  bool _isIcon = true;
  Future getPagesInfo() async {
    Uri url = Uri.parse(
        'https://api.pexels.com/v1/search?query=${widget.query}&per_page=50');

    var response = await http.get(url, headers: {
      'Authorization':
          '563492ad6f91700001000001f3e66a7d7f554e18b537c1a1eb0c7260'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      var dataPage = PageInfo.fromJson(json);
      return dataPage;
    } else {
      throw (response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.query;
    getPagesInfo();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isGrid = !_isGrid;
                  _isIcon = !_isIcon;
                });
              },
              icon: _isIcon
                  ? Icon(
                      Icons.grid_view,
                      size: 30,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black,
                    )),
        ],
        title: Text(
          'Search',
          style: GoogleFonts.bebasNeue(
              color: Colors.black, fontSize: 50, letterSpacing: 5),
        ),
        backgroundColor: Colors.red.shade200,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: FutureBuilder(
              future: getPagesInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 150),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Try Again later!'),
                    );
                  } else {
                    return _isGrid
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 0.5,
                                    crossAxisCount: 3),
                            itemCount: snapshot.data.photos.length,
                            itemBuilder: (context, index) {
                              return GridTile(
                                child: InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          await MaterialPageRoute(
                                              builder: (context) {
                                            return DownloadPage(
                                              imageURLfordesktop: snapshot.data.photos[index].src.original,
                                                imageURLformobile: snapshot
                                                    .data
                                                    .photos[index]
                                                    .src
                                                    .portrait);
                                          }));
                                    },
                                    child: Ink.image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data.photos[index].src.medium))),
                              );
                            })
                        : ListView.builder(
                            physics: FixedExtentScrollPhysics(),
                            itemCount: snapshot.data.photos.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        await MaterialPageRoute(
                                            builder: (context) {
                                          return DownloadPage(
                                            imageURLfordesktop: snapshot.data.photos[index].src.original,
                                              imageURLformobile: snapshot.data
                                                  .photos[index].src.portrait);
                                        }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Container(
                                      height: height * 0.4,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot.data
                                                  .photos[index].src.portrait),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                  thanks +
                                      snapshot.data.photos[index].photographer
                                          .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green),
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                  }
                }
              })),
    );
  }
}
/*ListView.builder(
                      itemCount: snapshot.data.photos.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              try {
                                var imageID = ImageDownloader.downloadImage(snapshot.data.photos[index].src.portrait);
                                if (imageID == null) {
                                  print('cannot download');
                                } else {
                                  print('download sucessful');
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Container(
                              height: height * 0.95,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data.photos[index].src.portrait),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Center(
                              child: Text(
                            thanks +
                                snapshot.data.photos[index].photographer
                                    .toUpperCase(),
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ); */
/*AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 35,
              color: Colors.black,
            )),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Catagoary',
          style: GoogleFonts.bebasNeue(
              color: Colors.black, fontSize: 50, letterSpacing: 5),
        ),
        backgroundColor: Colors.red.shade200,
      ), */
/* */