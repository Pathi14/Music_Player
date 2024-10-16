import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicefreixdevgrp22024/controller/firebase_helper.dart';
import 'package:musicefreixdevgrp22024/controller/myPermissionImage.dart';
import 'package:musicefreixdevgrp22024/controller/my_animation.dart';
import 'package:musicefreixdevgrp22024/firebase_options.dart';
import 'package:musicefreixdevgrp22024/globale.dart';
import 'package:musicefreixdevgrp22024/view/my_dash_board.dart';
import 'package:musicefreixdevgrp22024/view/play_musique.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //MyPermissionImage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PlayMusique(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
              children: [
                //image
                Container(
                  height: 300,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("lib/assets/woman.jpg"),
                          fit: BoxFit.fill
                      )
                  ),


                ),
                const SizedBox(height: 10,),


                //adresse mail
                MyAnimation(
                  time: 1,
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: mail,
                      decoration: InputDecoration(
                          hintText: "Entrer votre mail",
                          prefixIcon: const Icon(Icons.mail),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )

                      ),

                    ),
                  ),
                ),
                const SizedBox(height: 10,),



                //mot de passe
                MyAnimation(
                  time: 2,
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Entrer votre password",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )

                      ),

                    ),
                  ),
                ),

                const SizedBox(height: 10,),



                //bouton connexion
                MyAnimation(
                  time: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Connexion"),
                        onPressed: (){
                          MyFirebaseHelper().connect(mail.text, pass.text).then((onValue){

                            setState(() {
                              monUtilisateur = onValue;
                            });

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MyDashBoard()));

                          }).catchError((onError){
                            //afficher un popo up
                          });

                        },
                      ),

                      //bouton inscription
                      TextButton(
                        child: const Text("Inscription"),
                        onPressed: (){
                          MyFirebaseHelper().register(mail.text, pass.text).then((onValue){
                            setState(() {
                              monUtilisateur = onValue;
                            });

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MyDashBoard()));
                          }).catchError((onError){
                            //afficher un popo up
                          });

                        },
                      ),


                    ],
                  ),
                ),





                const Spacer()
              ]
          ),
        ),
      ),






      /*GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 20,
        children: [
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
        ],
        crossAxisCount: 3,
      )


      ListView(
        children: [
           Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdf"),
            child: Container(
               color: Colors.blue,
              height: 200,
              width: double.infinity,
            ),
          ),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdfyfjf,hgfhg"),
            child: Container(
               color: Colors.yellow,
              height: 200,
              width: double.infinity,
            ),
          ),
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key : Key("dgfsgdfhfht"),
            child: Container(
               color: Colors.purple,
              height: 200,
              width: double.infinity,
            ),
          ),
        ],
      )


       Container(
        height: 400,
        width: double.infinity,
        color: Colors.blue,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [
              Image.asset("lib/assets/woman.jpg",
          height: 350,
          width: 200,),

           ElevatedButton(
            onLongPress: (){
              print("j'ai pressé longtemps");
            },
            child: Text("Inscription"),
            onPressed: (){
              print("j'ai appuyé");
            },

            ),
            Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),
          Image.asset("lib/assets/modeling.png",
          height: 350,
          width: 200,),


            ],
          ),
        ),
      )



      TextField(
        obscureText: true,

      )


       Image.asset("lib/assets/woman.jpg",
      height: 350,
      width: 200,)




      ElevatedButton(
        onLongPress: (){
          print("j'ai pressé longtemps");
        },
        child: Text("Inscription"),
        onPressed: (){
          print("j'ai appuyé");
        },

        )



       Container(
        height: 250,
        width: 300,
        child: Text('je suis dans le container'),

        decoration: BoxDecoration(
          color: Colors.red,

          borderRadius: BorderRadius.circular(15)
        ),
      )



      Text("Je suis une chaine",
      style:TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontSize: 40
        )


      )
      */

    );
  }
}
