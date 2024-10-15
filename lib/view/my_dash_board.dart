import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicefreixdevgrp22024/view/my_profil_page.dart';


class MyDashBoard extends StatefulWidget {
  String email;
  MyDashBoard({super.key,required this.email});

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  //variable
  int tappedIcon = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.75,
        color: Colors.red,
        child: const MyProfilPage(),

      ),
      appBar: AppBar(
        title: Text(widget.email),
        centerTitle: true,
      ),
      body: bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value){
          setState(() {
            tappedIcon = value;
          });


        },
        currentIndex: tappedIcon,
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.music),
              label: "Ma musique"

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Mes favoris"

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Mes paramètres"

          ),
        ],
      ),

    );
  }

  Widget bodyPage(){
    switch (tappedIcon){
      case 0 : return const Text("Toutes les personnes");
      case 1 : return const Text("Mes favoris");
      case 2 : return const Text("Mes paramètres");
      default: return const Text("Erreur");
    }

  }
}