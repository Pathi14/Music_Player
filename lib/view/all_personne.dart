import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/model/my_user.dart';

class AllPerson extends StatefulWidget {
  const AllPerson({super.key});

  @override
  State<AllPerson> createState() => _AllPersonState();
}

class _AllPersonState extends State<AllPerson> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: MyFirebaseHelper().mesUtilisateurs.snapshots(), 
      builder: (context, snap) {
        if(ConnectionState.waiting == snap.connectionState){
            return Center(
              child: CircularProgressIndicator(),
            );
        }
        else {
          if(!snap.hasData){
            return Center(
              child: Text("Aucune donnée disponible"),
            );
          }else
            {
              List documents = snap.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                  itemBuilder: (context,index){
                    MyUser other = MyUser.dbb(documents[index]);
                    return ListTile(
                      title: Text(other.nom!),
                      subtitle: Text(other.email),
                    );
                  }
              );
            }
        }
      }
    );
  }
}