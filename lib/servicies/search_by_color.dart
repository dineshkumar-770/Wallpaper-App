import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallpaper_app/models/page.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class SearchByColor extends StatefulWidget {
  String query2;
  String colortype;
  SearchByColor({required this.colortype, required this.query2});

  @override
  State<SearchByColor> createState() => _SearchByColorState();
}

class _SearchByColorState extends State<SearchByColor> {
  Future getPagesInfo() async {
    Uri url = Uri.parse(
        'https://api.pexels.com/v1/search?query=${widget.query2}&per_page=50&color=${widget.colortype}');

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
    widget.query2;
    getPagesInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Wallpapers',
          style: TextStyle(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: FutureBuilder(
              future: getPagesInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Try again later or May be Color code incorrect!'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.photos.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data.photos[index].src.medium),
                                    fit: BoxFit.cover)),
                          ),
                          Center(
                              child: Text(
                            'Say Thanks:  ' +
                                snapshot.data.photos[index].photographer,
                            style: TextStyle(fontSize: 20),
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
