import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meditate_mantra_task/music/screens/songlist_screen.dart';
import 'package:meditate_mantra_task/music/services/songs_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var challengingData = await SongData().getData("1");
    var instrumentalData = await SongData().getData("2");
    print(challengingData['sounds_data'][0]['name']);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SongList(
        challengingData: challengingData,
        instrumentalData: instrumentalData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
