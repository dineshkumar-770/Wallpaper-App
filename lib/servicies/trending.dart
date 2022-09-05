import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallpaper_app/models/page.dart';
import 'package:wallpaper_app/screens/nature.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  Future getPagesInfo() async {
    Uri url = Uri.parse('https://api.pexels.com/v1/curated?per_page=50');

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Trending',
          style: GoogleFonts.bebasNeue(
              color: Colors.black, fontSize: 50, letterSpacing: 5),
        ),
        backgroundColor: Colors.red.shade200,
      ),
      body: FutureBuilder(
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
                  child:
                      Text('Try again later or May be Color code incorrect!'),
                );
              } else {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  await MaterialPageRoute(builder: (context) {
                                    return DownloadPage(
                                      imageURLfordesktop: snapshot.data.photos[index].src.original,
                                        imageURLformobile: snapshot
                                            .data.photos[index].src.portrait);
                                  }));
                            },
                            child: Ink.image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot.data.photos[index].src.medium))),
                      );
                    });
              }
            }
          }),
    );
  }
}
