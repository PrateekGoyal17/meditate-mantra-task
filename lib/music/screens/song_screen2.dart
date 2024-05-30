// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditate_mantra_task/constants.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: must_be_immutable
class SongScreen2 extends StatefulWidget {
  String songName;
  String soundName;
  bool instrumentalData;

  SongScreen2(
      {super.key,
      required this.songName,
      required this.soundName,
      required this.instrumentalData});

  @override
  State<SongScreen2> createState() => _SongScreen2State();
}

class _SongScreen2State extends State<SongScreen2>
    with SingleTickerProviderStateMixin {
  // AnimationController? animationController;
  final audioPlayer = AudioPlayer();
  Duration? loopDuration;
  late Timer timer = Timer(Duration.zero, () {});
  bool isPlaying = false;
  Duration? remainingTime;
  final TextEditingController _timeController = TextEditingController();
  double initialValue = 0;
  Duration time = Duration.zero;
  int n = 1;
  int modulo = 0;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await audioPlayer.setUrl(
          'http://soundscape.boostproductivity.online/api/meditate/v1/media/getSound?sound_type=bgwnct&sound_name=${widget.soundName}');
      audioPlayer.positionStream.listen((position) {
        setState(() {
          initialValue = position.inMilliseconds.toDouble();
        });

        if (loopDuration != null) {
          setState(() {
            remainingTime = loopDuration! - time - position;
            modulo = loopDuration!.inMinutes ~/ audioPlayer.duration!.inMinutes;
            setState(() {
              if (modulo + 1 == n && remainingTime! < Duration.zero) {
                togglePlayPause();
              }
            });
            if (remainingTime! < Duration.zero) {
              remainingTime = Duration.zero;
            }
            if (remainingTime! < Duration.zero) {
            } else {
              _timeController.text = formatDuration(remainingTime!);
            }
          });
        }
      });
      audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            loopDuration = duration;
            if (remainingTime == null) {
              remainingTime = duration;
              if (remainingTime! < Duration.zero) {
              } else {
                _timeController.text = formatDuration(remainingTime!);
              }
            }
          });
        }
      });
      audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          if (remainingTime != null && remainingTime! > Duration.zero) {
            time = audioPlayer.duration! * n;
            n++;
            print("Printing n $n");
            print("Printing modulo $modulo");
            audioPlayer.seek(Duration.zero);
            if (!(n > modulo)) {
              audioPlayer.play();
            }
          } else {
            setState(() {
              isPlaying = false;
            });
          }
        }
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    _timeController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else if (remainingTime == Duration.zero) {
      audioPlayer.seek(Duration.zero);
      _timeController.text = formatDuration(audioPlayer.duration!);
    } else {
      if (audioPlayer.processingState == ProcessingState.completed) {
        audioPlayer.seek(Duration.zero);

        remainingTime = loopDuration;
        _timeController.text = formatDuration(remainingTime!);
      }
      audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _updateRemainingTime(String time) {
    final parts = time.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      final newDuration = Duration(minutes: minutes, seconds: seconds);

      setState(() {
        audioPlayer.seek(Duration.zero);
        remainingTime = newDuration;

        loopDuration = remainingTime;
        initialValue = remainingTime!.inMilliseconds.toDouble();
      });
      if (audioPlayer.duration != null &&
          audioPlayer.duration! > remainingTime!) {
        setState(() {
          audioPlayer.seek(Duration.zero);
          loopDuration = remainingTime;
        });
      }
      if (!isPlaying) {
        _timeController.text = formatDuration(remainingTime!);
      }
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            audioPlayer.pause();
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
          // crossAxisAlignment: CrossAxisAlignment.center,
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
              max: audioPlayer.duration?.inMilliseconds.toDouble() ?? 0,
              initialValue: initialValue.clamp(
                  0, audioPlayer.duration?.inMilliseconds.toDouble() ?? 0),
              onChangeEnd: (double value) {
                final newPosition = Duration(milliseconds: value.round());
                audioPlayer.seek(newPosition);
              },
              innerWidget: (value) => GestureDetector(
                onTap: togglePlayPause,
                child: Icon(
                  isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                  size: 56.0,
                  color: kPlayerColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                remainingTime != null
                    ? formatDuration(remainingTime!)
                    : '00:00',
                style: const TextStyle(
                    fontFamily: "NunitoSans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
