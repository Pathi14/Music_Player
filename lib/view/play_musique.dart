import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayMusique extends StatefulWidget {
  const PlayMusique({super.key});

  @override
  State<PlayMusique> createState() => _PlayMusiqueState();
}

class _PlayMusiqueState extends State<PlayMusique> {
  String? nameMusic;
  String? auteur;
  String? image;
  double valueSlider = 0;
  double volume=0;
  //final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lecture de musiques"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Text("nameMusic!"),
              Text("auteur!"),
              Divider(),
              AnimatedContainer(
                duration: const Duration(seconds:5),
                height: 300, //()?150:300,
                width: 200, //()?50:200,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        // Image.network(image!),
                      image: AssetImage("lib/assets/woman.jpg"),
                      fit: BoxFit.fill
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("temps mis"),
                  Text("durée totale")
                ],
              ),
              Slider(
                min: 0.0,
                //max: ,
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
                    icon:Icon(Icons.play_arrow),
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                    },
                  ),
                  IconButton(
                    icon:Icon(Icons.pause),
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                    },
                  ),
                  // IconButton(
                  //   icon:FaIcon(FontAwesomeIcons.forward),
                  //   onPressed: (){
                  //     //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                  //   },
                  // ),
                  IconButton(
                    icon:Icon(Icons.navigate_next),
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMusic()));
                    },
                  ),
                  Slider(
                    min: 0.0,
                    max: 1,
                    value: volume, 
                    activeColor: Color.fromRGBO(61, 62, 65, 1),
                    onChanged: (value){
                      setState(() {
                        volume = value;
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