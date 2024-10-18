import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:musicefreixdevgrp22024/model/my_music.dart';


class PlayMusique extends StatefulWidget {
  MyMucic music;
  PlayMusique({super.key, required this.music});

  @override
  State<PlayMusique> createState() => _PlayMusiqueState();
}

class _PlayMusiqueState extends State<PlayMusique> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration positionnement = Duration(seconds: 0);
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;
  Duration dureeTotal = Duration(seconds: 0);
  double valueSlider = 0;
  double volumeSound = 0.5;
  bool isPlaying = false;

  void configPlayer() {
    // Définir la musique à partir des assets
    audioPlayer.setSource(UrlSource(widget.music.link));

    // Écouteur pour la position
    positionStream = audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        positionnement = event;
      });
    });

    // Écouteur pour la durée totale
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        dureeTotal = event;
      });
    });

    // Écouteur pour l'état de lecture
    stateStream = audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (event == PlayerState.paused || event == PlayerState.stopped) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void play() async {
    await audioPlayer.play(UrlSource(widget.music.link), position: positionnement, volume: volumeSound);
    print(positionnement);
  }

  void pause() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    super.initState();
    configPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    positionStream.cancel();
    stateStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lecture de musiques"),
        actions: [
          IconButton(
            onPressed: (){
              if(!monUtilisateur.favoris.contains(widget.music.uid)){
                monUtilisateur.favoris.add(widget.music.uid);
                Map<String, dynamic> map = {
                  "FAVORIS": monUtilisateur.favoris,
                };
                MyFirebaseHelper().updateUser(monUtilisateur.uid, map);
              }
            }, 
            color: monUtilisateur.favoris.contains(widget.music.uid)?Colors.red: Colors.transparent,
            icon: Icon(Icons.favorite)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Text(widget.music.nom),
              Text(widget.music.auteur),
              Divider(),
              AnimatedContainer(
                duration: const Duration(seconds:5),
                height: (isPlaying)?150:300,
                width: (isPlaying)?50:200,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // image: const DecorationImage(
                    //   image: NetworkImage(widget.music.pochette),
                    //   fit: BoxFit.cover
                    // )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(positionnement.toString().substring(2,7)),
                  Text(dureeTotal.toString().substring(2,7))
                ],
              ),
              Slider(
                min: 0.0,
                max: dureeTotal.inSeconds.toDouble(),
                value: valueSlider, 
                onChanged: (value){
                  setState(() {
                    valueSlider = value;
                  });
                }
              ),
              Row(
                children: [
                  IconButton(
                    icon:Icon(Icons.navigate_before),
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                    },
                  ),
                  IconButton(
                    onPressed: () {

                      (isPlaying)?pause():play();
                    },
                    icon: FaIcon(isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play),
                  ),
                  IconButton(
                    icon:Icon(Icons.navigate_next),
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                    },
                  ),
                  Slider(
                    min: 0.0,
                    max: 1,
                    value: volumeSound, 
                    activeColor: Color.fromRGBO(61, 62, 65, 1),
                    onChanged: (value){
                      setState(() {
                        volumeSound = value;
                      });
                    }
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}