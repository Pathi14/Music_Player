import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/model/my_music.dart';
import 'package:musicefreixdevgrp22024/view/play_musique.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({super.key});

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: MyFirebaseHelper().mesMusiques.snapshots(), 
      builder: (context, snap){
        if(snap.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator.adaptive());
        }
        else if(!snap.hasData){
          return Center(child: Text("Aucune musique"),
          );
        }else{
          List documents = snap.data!.docs;
          return GridView.builder(
            itemCount: documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              MyMucic lesmusic = MyMucic.dbb(documents[index]);
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayMusique(music: lesmusic)));
                },
                child: Container(
                  child: Text(lesmusic.nom, style: TextStyle(color: const Color.fromARGB(255, 20, 120, 190), fontStyle: FontStyle.italic)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(lesmusic.pochette),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
    );
  }
}