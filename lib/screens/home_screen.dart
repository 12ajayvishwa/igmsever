import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:igmsaver/screens/video_player_screen.dart';
import 'package:igmsaver/widget/validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/input_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  TextEditingController reelController = TextEditingController();
  FlutterInsta flutterInsta = FlutterInsta();

  bool downloading = false;
  String? downloadedReel;
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort?.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");
    _receivePort.listen((message) {
      DownloadTaskStatus status = message[1];
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("downloade reel $downloadedReel");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeData().scaffoldBackgroundColor,
        title: const Text(
          "Insta Saver",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextFormFields(
                  size: size,
                  controller: reelController,
                  hintText: "Paste Copied Url",
                  validator: (value) => titleValidator(value),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("downloading...")));
                          setState(() {
                            downloading = true;
                          });
                          download();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Something wrong")));
                          print("Something Wrong");
                        }
                      },
                      child: const Text(
                        "Download",
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: size.height * 0.05,
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: downloading
                      ? Center(
                          child:
                              CircularProgressIndicator(), //if downloading is true show Progress Indicator
                        )
                      : downloadedReel != null?
                      
                      Container(  
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DownloadedVideoPlayer(
                                               downloadedReel,
                                            )));
                              },
                              child: Text("Play video")),
                        ):Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void download() async {
    var myvideourl = await flutterInsta.downloadReels(reelController.text);
    final externalDir = await getExternalStorageDirectory();
    var status = await Permission.storage.request();
    if (status.isGranted) {
      await FlutterDownloader.enqueue(
        url: '$myvideourl',
        savedDir: externalDir!.path,
        showNotification: true,
        fileName: "Download",
        // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ).whenComplete(() {
        setState(() {
          downloading = false;
          downloadedReel = myvideourl;
          print(myvideourl);
          print(externalDir);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Task Downloaded")));
          // set to false to stop Progress indicator
        });
      });
    }
  }
}
