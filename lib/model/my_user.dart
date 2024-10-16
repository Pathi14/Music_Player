import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{

  late String uid;
  late String email;
  late String? nom;
  late String? prenom;
  late String? avatar;
  late List favoris;



  MyUser(){
    uid = "";
    email = "";
    favoris = [];
  }

  MyUser.dbb(DocumentSnapshot snapshot){
    uid = snapshot.id;
    Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
    favoris = data["FAVORIS"];
    email = data["MAIL"];
    nom = data["NOM"] ?? "";
    prenom = data["PRENOM"] ?? "";
    avatar = data["AVATAR"] ?? "";
  }


}