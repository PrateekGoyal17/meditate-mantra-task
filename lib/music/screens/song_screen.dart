// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditate_mantra_task/constants.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: must_be_immutable
class SongScreen extends StatefulWidget {
  String songName;
  String soundName;
  bool instrumentalData;

  SongScreen(
      {super.key,
      required this.songName,
      required this.soundName,
      required this.instrumentalData});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  int initialTime = 5 * 60; // 5 minutes in seconds
  int remainingTime = 5 * 60;
  Timer? timer;
  bool isPlaying = false;
  final TextEditingController textEditingControlller = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    textEditingControlller.text = formatDuration(remainingTime);
    audioPlayer.setUrl('http://soundscape.boostproductivity.online/api/meditate/v1/media/getSound?sound_type=bgwnct&sound_name=${widget.soundName}');
    audioPlayer.playerStateStream.listen((playerState) {
    if (playerState.processingState == ProcessingState.completed) {
      audioPlayer.seek(Duration.zero); // Restart the audio
      if (isPlaying) {
        audioPlayer.play();
      }
    }
  });

  }



  void startTimer() {
    
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        print("Printing ${remainingTime}");
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          audioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
        textEditingControlller.text = formatDuration(remainingTime);
      });
    });
  }

  void togglePlayPause() {
    if (isPlaying) {
      timer?.cancel();
      audioPlayer.pause();  
    } else {
      startTimer();
      audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void updateRemainingTime(double value) {
    setState(() {
      remainingTime = value.toInt();
      // maxSliderValue = remainingTime.toDouble();
      print("Printing duration ${Duration(seconds: initialTime - remainingTime)}");

      audioPlayer.seek(Duration(seconds: initialTime - remainingTime));
      if (isPlaying) {
        timer?.cancel();
        startTimer();
      }
      textEditingControlller.text = formatDuration(remainingTime);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    textEditingControlller.dispose();
    super.dispose();
    audioPlayer.dispose();
  }

  int convertToSeconds(String time) {
    final parts = time.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return minutes * 60 + seconds;
    }
    return 0;
  }

  String formatDuration(int seconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(seconds ~/ 60);
    final remainingSeconds = twoDigits(seconds % 60);
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // audioPlayer.pause();
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        toolbarHeight: 103,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.songName,
          style: const TextStyle(
              fontFamily: "NunitioSans",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                startAngle: 270,
                angleRange: 360,
                size: 180.0,
                customColors: CustomSliderColors(
                    progressBarColor: kPlayerColor,
                    dotColor: kPlayerColor,
                    trackColor: kTileColor),
                customWidths: CustomSliderWidths(
                    trackWidth: 20, progressBarWidth: 20, shadowWidth: 0),
              ),
              min: 0,
              max: initialTime.toDouble(),
              initialValue: initialTime.toDouble() - remainingTime.toDouble(),
              onChangeEnd: (double value) {
                updateRemainingTime(initialTime.toDouble() - value);
              },
              innerWidget: (value) {
                return IconButton(
                  icon: Icon(
                    isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                    size: 56.0,
                    color: kPlayerColor,
                  ),
                  onPressed: togglePlayPause,
                );
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: textEditingControlller,
              onTap: () {
                textEditingControlller.text = "";
              },
              onEditingComplete: () {
                initialTime = convertToSeconds(textEditingControlller.text);
                remainingTime = initialTime;
                // _updateRemainingTime(_timeController.text);
              },
              style: const TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              // focusNode: focusNode,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
