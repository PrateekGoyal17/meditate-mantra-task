import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/constants.dart';
import 'package:meditate_mantra_task/landing/screens/setting_screen.dart';
import 'package:meditate_mantra_task/music/screens/song_screen2.dart';
import 'package:meditate_mantra_task/music/screens/song_screen.dart';

// ignore: must_be_immutable
class SongList extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var challengingData;
  // ignore: prefer_typing_uninitialized_variables
  var instrumentalData;
  SongList(
      {super.key,
      required this.challengingData,
      required this.instrumentalData});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 103,
        backgroundColor: Colors.white,
        title: const Text(
          "Welcome, User",
          style: TextStyle(
              fontFamily: "NunitioSans",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  )))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 24),
            child: Text(
              "For Challenging Times",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongScreen2(
                              songName: widget.challengingData['sounds_data']
                                  [index]['name'],
                              soundName: widget.challengingData['sounds_data']
                                  [index]['sound_name'],
                              instrumentalData: false,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kTileColor,
                        ),
                        child: Text(
                          widget.challengingData['sounds_data'][index]['name'],
                          style: const TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child: Text(
              "Instrumental",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true,
                padding: EdgeInsets.only(top: 8),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongScreen(
                              songName: widget.instrumentalData['sounds_data']
                                  [index]['name'],
                              soundName: widget.instrumentalData['sounds_data']
                                  [index]['sound_name'],
                                  instrumentalData: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kTileColor,
                        ),
                        child: Text(
                          widget.instrumentalData['sounds_data'][index]['name'],
                          style: const TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
