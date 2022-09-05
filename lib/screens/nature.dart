import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DownloadPage extends StatefulWidget {
  String imageURLformobile;
  String imageURLfordesktop;
  DownloadPage({required this.imageURLformobile, required this.imageURLfordesktop});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageData();
  }

  Future getImageData() async {
    String imageUrl = await widget.imageURLformobile;
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getImageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.imageURLformobile),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          width: width * 0.4,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.white24,
                              ),
                              onPressed: () {
                                var imageID = ImageDownloader.downloadImage(
                                    widget.imageURLformobile);
                                imageID.whenComplete(
                                  () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Image Downloaded'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'))
                                      ],
                                      backgroundColor: Colors.white38,
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Download for Mobile',
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                        Container(
                          height: 50,
                          width: width * 0.4,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.white24,
                              ),
                              onPressed: () {
                                var imageID = ImageDownloader.downloadImage(
                                    widget.imageURLfordesktop);
                                imageID.whenComplete(
                                  () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Image Downloaded'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'))
                                      ],
                                      backgroundColor: Colors.white38,
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Download for Desktop',
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
/*Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imageURL), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.white24,
                  ),
                  onPressed: () {
                    var imageID =
                        ImageDownloader.downloadImage(widget.imageURL);
                    imageID.whenComplete(
                      () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Image Downloaded'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          backgroundColor: Colors.white38,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Text('Download'),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ), */
