import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicefreixdevgrp22024/globale.dart';

class MyMucic{

  late String uid;
  late String nom;
  late String auteur;
  late String pochette;
  late MyStyleMusic style;
  late String link;



  MyMucic(){
    uid = "";
    nom = "";
    auteur = "";
    pochette = "";
    style = MyStyleMusic.disco;
    link = "";
  }

  MyMucic.dbb(DocumentSnapshot snap){
    uid = snap.id;
    Map <String, dynamic> map = snap.data() as Map <String, dynamic>;
    nom = map["NOM"];
    auteur = map["AUTEUR"];
    pochette = map["LIEN"];
    link = map["SONG"];
  }

}