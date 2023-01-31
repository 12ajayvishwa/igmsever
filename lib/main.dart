import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:igmsaver/screens/home_screen.dart';
import 'package:igmsaver/screens/video_player_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  print("initialized");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}


// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   FlutterInsta flutterInsta =
//       FlutterInsta(); // create instance of FlutterInsta class
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController reelController = TextEditingController();
//   TabController? tabController;

//   String? username, followers = " ", following, bio, website, profileimage;
//   bool pressed = false;
//   bool downloading = false;
//   int progress = 0;

//   ReceivePort _receivePort = ReceivePort();

//   static downloadingCallback(id, status, progress) {
//     ///Looking up for a send port
//     SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

//     ///ssending the data
//     sendPort?.send([id, status, progress]);
//   }

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(vsync: this, initialIndex: 1, length: 2);

//     IsolateNameServer.registerPortWithName(
//         _receivePort.sendPort, "downloading");
//     _receivePort.listen((message) {
//       DownloadTaskStatus status = message[1];
//       setState(() {
//         progress = message[2];
//       });

//       print(progress);
//     });

//     FlutterDownloader.registerCallback(downloadingCallback);
//   }
//   @override
//   void dispose() {
//    FlutterDownloader.registerCallback(downloadingCallback);
//     super.dispose();
//   }

//   void downloadReels(String reelLink) async {
//     var s = await flutterInsta.downloadReels(reelLink);
//     print(s);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Package example app'),
//         bottom: TabBar(
//           controller: tabController,
//           tabs: [
//             Tab(
//               text: "Home",
//             ),
//             Tab(
//               text: "Reels",
//             )
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: tabController,
//         children: [
//           homePage(), //  // home screen for Getting profile details
//           reelPage() // reel download Screen
//         ],
//       ),
//     );
//   }

// //get data from api
//   Future printDetails(String username) async {
//     await flutterInsta.getProfileData(username);
//     setState(() {
//       this.username = flutterInsta.username; //username
//       this.followers = flutterInsta.followers; //number of followers
//       this.following = flutterInsta.following; // number of following
//       this.website = flutterInsta.website; // bio link
//       this.bio = flutterInsta.bio; // Bio
//       this.profileimage = flutterInsta.imgurl; // Profile picture URL
//       print(followers);
//     });
//   }

//   Widget homePage() {
//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
//               controller: usernameController,
//             ),
//             ElevatedButton(
//               child: Text("Print Details"),
//               onPressed: () async {
//                 setState(() {
//                   pressed = true;
//                 });

//                 printDetails(usernameController.text); //get Data
//               },
//             ),
//             pressed
//                 ? SingleChildScrollView(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: Card(
//                         child: Container(
//                           margin: EdgeInsets.all(15),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                               ),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: Image.network(
//                                   "$profileimage",
//                                   width: 120,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                               ),
//                               Text(
//                                 "$username",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Text(
//                                     "$followers\nFollowers",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Text(
//                                     "$following\nFollowing",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                               ),
//                               Text(
//                                 "$bio",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               Padding(padding: EdgeInsets.only(top: 10)),
//                               Text(
//                                 "$website",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }

// //Reel Downloader page
//   Widget reelPage() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         TextField(
//           controller: reelController,
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               downloading = true; //set to true to show Progress indicator
//             });
//             download();
//           },
//           child: Text("Download"),
//         ),
//         downloading
//             ? Center(
//                 child:
//                     CircularProgressIndicator(), //if downloading is true show Progress Indicator
//               )
//             : Container()
//       ],
//     );
//   }

// //Download reel video on button clickl
//   void download() async {
//     var myvideourl = await flutterInsta.downloadReels(reelController.text);
//     final externalDir = await getExternalStorageDirectory();
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       await FlutterDownloader.enqueue(
//         url: '$myvideourl',
//         savedDir: externalDir!.path,
//         showNotification: true,
//         fileName: "Download",

//         // show download progress in status bar (for Android)
//         openFileFromNotification:
//             true, // click on notification to open downloaded file (for Android)
//       ).whenComplete(() {
//         setState(() {
//           downloading = false;
//           print(myvideourl);
//           print(externalDir);
//           // set to false to stop Progress indicator
//         });
//       });
//     }
//   }
// }
