import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:random_string/random_string.dart';

class AddMusic extends StatefulWidget {
  const AddMusic({super.key});

  @override
  State<AddMusic> createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  //attributs
  TextEditingController musicName = TextEditingController();
  TextEditingController autor = TextEditingController();
  String? lienImage;
  String? nameImage;
  //données de l'image
  Uint8List? byteImage;
  

  //methode
  //upload l'image
  UploadPicture() async{
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(resultat!=null){
      nameImage = resultat.files.first.name;
      byteImage = resultat.files.first.bytes;
      popUpImage();
    }
  }

  UploadMusic() async{
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.audio
    );
    if(resultat!=null){
      nameImage = resultat.files.first.name;
      byteImage = resultat.files.first.bytes;
      popUpImage();
    }
  }

  popUpImage(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Souhaitez-vous enregistrer cette image ?"),
          content: Image.memory(byteImage!),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text("Annuler")
            ),
            TextButton(
              onPressed: (){
                // MyFirebaseHelper().uploadData(dossier:"IMAGES",uuid: monUtilusateur.uid,nomData : nameImage!,byteData:byteImage!).then((onValue){
                //   lienImage = onValue;
                // });
                Navigator.pop(context);
              }, 
              child: Text("Valider")
            )
          ],
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(15),
        child: Column(
          children: [
             TextField(
                controller: musicName,
                decoration: InputDecoration(
                    hintText: "Entrer le titre de la musique",
                    prefixIcon: const Icon(Icons.music_note),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
        
                ),
        
              ),
              Spacer(),
              TextField(
                controller: autor,
                decoration: InputDecoration(
                    hintText: "Entrer le nom de l'auteur de musique",
                    prefixIcon: const Icon(Icons.person_2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
        
                ),
        
              ),
              Spacer(),
              TextButton(
                onPressed: (){
                  UploadPicture();                  
                }, 
                child: Text("Ajouter l'image'")
              ),
              Spacer(),
              TextButton(
                onPressed: (){
                  UploadMusic();
                }, 
                child: const Text("Ajouter le son")
              ),
              Spacer(),
              TextButton(
                onPressed: (){
                  Map<String, dynamic> map = {
                    "AUTEUR": autor.text,
                    "NOM": musicName.text,
                    "LIEN": lienImage
                  };
                  String uid = randomAlphaNumeric(20);

                  MyFirebaseHelper().addMusic(uid, map);

                  // MyFirebaseHelper().uploadData(
                  //   dossier: "IMAGES", 
                  //   uuid: monUtilisateur.uid,
                  //   nomData: nameImage!, 
                  //   bytesData: byteImage!, 
                  // ).then((onValue){
                  //   lienImage = onValue;
                  // });
                }, 
                child: Text("Valider")
              ),
          ],
        ),
      ),
    );
  }
}